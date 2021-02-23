class Api::V1::SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: :create
  before_action :set_user, only: :create

  def create
    if @user.authenticate sign_in_params[:password]
      # sign_in @user # Define your sign_in method or using with Devise gem
      render json: {user_info: @user, auth_token: @user.encode_auth_token,
        messages: I18n.t("sessions.signed_in")}, status: :ok
    else
      render_invalid
    end
  end

  def destroy
    # sign_out @user # Define your sign_out method or using with Devise gem
    @user.generate_new_auth_token
    render json: {messages: I18n.t("sessions.signed_out")}, status: :ok
  end

  private

  def ensure_params_exist
    return if params[:sign_in].present?

    render json: {messages: I18n.t("sessions.missing_params")},
      status: :bad_request
  end

  def render_invalid
    render json: {messages: I18n.t("sessions.invalid")}, status: :unauthorized
  end

  def sign_in_params
    params.require(:sign_in).permit :email, :password
  end

  def set_user
    @user = User.find_by email: sign_in_params[:email]
    return if @user

    render_invalid
  end
end
