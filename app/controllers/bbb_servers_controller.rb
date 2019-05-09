class BbbServersController < ApplicationController

  before_action :ensure_admin
  before_action :find_bbb_server, only: [:update, :destroy]

  def index
    @bbb_servers = BbbServer.all.paginate(:page => params[:page], :per_page => 50)
  end

  def create
    @bbb_server = BbbServer.new(server_params.merge!({user: current_user}))
    if @bbb_server.save
      flash[:success] = 'Successfully created.'
      redirect_to bbb_servers_path
    else
      flash[:errors] = @bbb_server.errors.full_messages.join(',')
      redirect_to request.referer
    end
  end

  def update
    if @bbb_server.update!(server_params)
      flash[:success] = 'Successfuly Updated'
      redirect_to bbb_servers_path
    else
      flash[:errors] = @bbb_server.errors.full_messages.join(',')
      redirect_to bbb_servers_path
    end
  end

  def destroy
    @bbb_server.destroy
    redirect_to bbb_servers_path
  end

  private

  def server_params
    params.require(:bbb_server).permit(:name, :url, :secret)
  end

  def find_bbb_server
    @bbb_server = BbbServer.find params[:id]
  end

  def ensure_admin
    if current_user.nil? or !current_user.admin?
      flash[:error] = "You are not authorized to access this page"
      redirect_to root_path
    end
  end
end
