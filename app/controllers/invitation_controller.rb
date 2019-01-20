class InvitationController < ApplicationController

  before_action :set_user, only: [:show, :update]
  def show
  end

  def update
    errors = {}
    if user_params[:password].nil?
      errors[:password] = "can't be blank"
      flash[:error] = "Password can't be blank"
    elsif user_params[:password_confirmation].nil?
      errors[:password_confirmation]  = "can't be blank"
      flash[:error] = "Confirm password can't be blank"
    elsif user_params[:password] != user_params[:password_confirmation]
      flash[:error] = "Password and confirm password not matched."
      errors[:password_confirmation] = "doesn't match"
    end

    if errors.empty?  and @user.update!(user_params.merge!({invitation_token: nil, email_verified: true, status: 'accepted'}))
      flash[:success] = 'Successfuly On-board. Welcome To Virtual Classrooms Management.'
      login(@user)
    else
      flash[:errors] = @user.errors.full_messages.join(',')
      render :show
    end
  end

  private

  def set_user
    redirect_to root_path if current_user.present?
    @user = User.find_by_invitation_token(params[:token])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role, :image, :password, :password_confirmation,
                                 :new_password, :provider, :accepted_terms, :language)
  end
end
