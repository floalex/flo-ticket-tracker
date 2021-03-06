class UsersController < ApplicationController  
  before_action :require_user, only: [:index]
  
  def index
    @users = User.all
    @tickets = Ticket.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Thank you for for registering! You can sign in now."
      redirect_to sign_in_path
    else
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

end