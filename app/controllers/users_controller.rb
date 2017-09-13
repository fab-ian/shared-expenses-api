class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all
    json_response(@users)
  end

  def show
    json_response(@user)
  end

  def create
    @user = User.create!(user_params)
    json_response(@user, :created)
  end

  def new
    @user = User.new
  end

  def update
    @user.update(user_params)
    head :no_content
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
