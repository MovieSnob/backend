# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def register
    user = User.create(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      gender: params[:gender]
    )

    unless user
      render json: { error: user.errors }, status: :unauthorized

      return
    end

    authenticate
  end

  def authenticate
    if Rails.env.development?
      user = User.find_by_email(params[:email])

      render json: { token: JsonWebToken.encode(user_id: user.id) }
      return
    end

    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
