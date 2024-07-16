class UsersController < ApplicationController
  before_action :require_login
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @loans = @user.loans
  end

  private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end
end
