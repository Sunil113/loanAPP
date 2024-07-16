class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    admin = Admin.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:user_type] = 'User'
      redirect_to user_path(user), notice: 'Logged in successfully'
    elsif admin && admin.authenticate(params[:password])
      session[:user_id] = admin.id
      session[:user_type] = 'Admin'
      redirect_to admin_path(admin), notice: 'Logged in successfully'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    redirect_to root_path, notice: 'Logged out successfully'
  end
end
