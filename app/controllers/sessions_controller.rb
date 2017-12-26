class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]
  
  def new
    redirect_to root_path if current_user
  end
  
  def create
    # where method will return array so need to attach first to get that user
    user = User.find_by(email: params[:email])   
    
    if user && user.authenticate(params[:password])
      login_users!(user)
    else
      flash[:danger] = "There is something wrong with your username or password."
      redirect_to sign_in_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've signed out."
    redirect_to root_path
  end
  
  private 
    
  def login_users!(user)
    session[:user_id] = user.id
    flash[:success] = "Welcome, you have signed in."
    redirect_to root_path
  end
    
end