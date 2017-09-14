module V1
  class UsersController < ApplicationController
    skip_before_action :authorize_request, only: :create
    before_action :set_user, only: %i[show update destroy]

    def index
      @users = User.page(params[:page])
      json_response(@users)
    end

    def show
      json_response(@user)
    end

    def create
      user = User.create!(user_params)
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: Message.account_created, auth_token: auth_token }
      json_response(response, :created)
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
      params.permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end
