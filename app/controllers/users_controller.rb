# frozen_string_literal: true

# BigBlueButton open source conferencing system - http://www.bigbluebutton.org/.
#
# Copyright (c) 2018 BigBlueButton Inc. and by respective authors (see below).
#
# This program is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; either version 3.0 of the License, or (at your option) any later
# version.
#
# BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License along
# with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.

class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy, :user_update, :user_rooms, :user_room_delete, :user_room_show]
  before_action :find_room, only: [:user_room_delete, :user_room_show]
  before_action :ensure_admin, except: [:destroy, :edit, :update]

  # def recording_date(date)
  #   date.strftime("%B #{date.day.ordinalize}, %Y.")
  # end
  # helper_method :recording_date
  # # Helper for converting BigBlueButton dates into a nice length string.
  # def recording_length(playbacks)
  #   # Stats format currently doesn't support length.
  #   valid_playbacks = playbacks.reject { |p| p[:type] == "statistics" }
  #   return "0 min" if valid_playbacks.empty?
  #
  #   len = valid_playbacks.first[:length]
  #   if len > 60
  #     "#{(len / 60).round} hrs"
  #   elsif len == 0
  #     "< 1 min"
  #   else
  #     "#{len} min"
  #   end
  # end
  # helper_method :recording_length
  #
  # # Prevents single images from erroring when not passed as an array.
  # def safe_recording_images(images)
  #   Array.wrap(images)
  # end
  # helper_method :safe_recording_images
  def index
    @search = (params[:q] and params[:q][:search]) ? params[:q][:search] : nil
    @q = User.ransack(name_or_email_cont: @search)
    condition = "users.id != #{current_user.id}"
    condition += " and users.role = 0" if current_user.supervisor?
    @users = @q.result(distinct: true).order(created_at: :desc).where(condition).paginate(:page => params[:page], :per_page => 50)
  end

  # POST /u
  def create
    # Verify that GreenLight is configured to allow user signup.
    # return unless Rails.configuration.allow_user_signup
    @user = User.new(user_params.merge!({provider: 'greenlight',password: User.new_token, invited_by: current_user}))
    if @user.save
      flash[:success] = 'Invitation Successfully sent.'
      UserMailer.invitation_instructions(@user, invitation_link(@user)).deliver
      redirect_to users_path
    else
      flash[:errors] = @user.errors.full_messages.join(',')
      redirect_to request.referer
    end
  end

  # GET /signup
  # def new
  #   if Rails.configuration.allow_user_signup
  #     @user = User.new
  #   else
  #     redirect_to root_path
  #   end
  # end

  # GET /u/:user_uid/edit
  def edit
    if current_user
      redirect_to current_user.room unless @user == current_user
    else
      redirect_to root_path
    end
  end

  def user_update
    if @user.update_attributes(user_params)
      flash[:success] = 'User Successfully updated.'
      redirect_to users_path
    else
      flash[:errors] = @user.errors.full_messages.join(',')
      redirect_to request.referer
    end
  end
  # PATCH /u/:user_uid/edit
  def update
    if params[:setting] == "password"
      # Update the users password.
      errors = {}

      if @user.authenticate(user_params[:password])
        # Verify that the new passwords match.
        if user_params[:new_password] == user_params[:password_confirmation]
          @user.password = user_params[:new_password]
        else
          # New passwords don't match.
          errors[:password_confirmation] = "doesn't match"
        end
      else
        # Original password is incorrect, can't update.
        errors[:password] = "is incorrect"
      end

      if errors.empty? && @user.save
        # Notify the user that their account has been updated.
        redirect_to edit_user_path(@user), notice: I18n.t("info_update_success")
      else
        # Append custom errors.
        errors.each { |k, v| @user.errors.add(k, v) }
        render :edit, params: { settings: params[:settings] }
      end
    elsif user_params[:email] != @user.email && @user.update_attributes(user_params)
      @user.update_attributes(email_verified: false)
      redirect_to edit_user_path(@user), notice: I18n.t("info_update_success")
    elsif @user.update_attributes(user_params)
      update_locale(@user)
      redirect_to edit_user_path(@user), notice: I18n.t("info_update_success")
    else
      render :edit, params: { settings: params[:settings] }
    end
  end

  # DELETE /u/:user_uid
  def destroy
    if current_user && current_user == @user
      @user.destroy
      session.delete(:user_id)
      redirect_to root_path
    elsif current_user.admin_or_supervisor?
      @user.destroy
      redirect_to users_path, notice: I18n.t("user_delete_success")
    end
  end

  # GET | POST /terms
  def terms
    redirect_to '/404' unless Rails.configuration.terms

    if params[:accept] == "true"
      current_user.update_attributes(accepted_terms: true)
      login(current_user)
    end
  end

  # GET | POST /u/verify/confirm
  def confirm
    if !current_user || current_user.uid != params[:user_uid]
      redirect_to '/404'
    elsif current_user.email_verified
      login(current_user)
    elsif params[:email_verified] == "true"
      current_user.update_attributes(email_verified: true)
      login(current_user)
    else
      render 'verify'
    end
  end

  # GET /u/verify/resend
  def resend
    if !current_user
      redirect_to '/404'
    elsif current_user.email_verified
      login(current_user)
    elsif params[:email_verified] == "false"
      begin
        UserMailer.verify_email(current_user, verification_link(current_user)).deliver
        render 'verify'
      rescue => e
        logger.error "Error in email delivery: #{e}"
        mailer_delivery_fail
      end
    else
      render 'verify'
    end
  end

  def user_rooms
    redirect_to user_room_show_path(user_uid: @user.uid, room_uid: @user.main_room.uid)
  end

  def user_room_show
  end

  def user_room_delete
    @room.destroy
    redirect_to user_rooms_path(@user.uid)
  end


  private

  def mailer_delivery_fail
    redirect_to root_path, notice: I18n.t(params[:message], default: I18n.t("delivery_error"))
  end

  def verification_link(user)
    request.base_url + confirm_path(user.uid)
  end

  def invitation_link user
    request.base_url + invitation_path(user.invitation_token)
  end

  def find_user
    @user = User.find_by!(uid: params[:user_uid] || params[:id])
  end

  def find_room
    @room = Room.find_by!(uid: params[:room_uid])
  end
  def ensure_unauthenticated
    redirect_to current_user.main_room if current_user
  end

  def ensure_admin
    if current_user.nil? or !current_user.admin_or_supervisor?
      flash[:error] = "You are not authorized to access this page"
      redirect_to root_path
    end
  end
  def user_params
    params.require(:user).permit(:name, :email, :bbb_server_id, :role, :image, :number_of_recordings, :number_of_rooms,:password, :password_confirmation,
      :new_password, :provider, :accepted_terms, :language)
  end
end
