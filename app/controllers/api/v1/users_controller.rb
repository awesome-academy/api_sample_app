class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :create
  before_action :set_user, only: %i(show update destroy)

  def index
    @users = User.newest.page params[:page]

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new user_params
    if @user.save
      render json: @user, status: :created #201
    else
      render json: {error: @user.errors}, status: :unprocessable_entity #422
    end
  end

  def update
    if @user.update user_params
      render json: @user, status: :ok #200
    else
      render json: {error: @user.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content #204
  end

  private

  def set_user
    @user = User.find_by id: params[:id]

    return if @user
    render json: {}, status: :not_found
  end

  def user_params
    params.require(:user).permit :first_name, :last_name, :email, :password
  end
end
