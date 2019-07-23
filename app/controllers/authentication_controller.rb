# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def register
    user = User.create(name: params[:name], email: params[:email], password: params[:password])

    unless user
      render json: { error: user.errors }, status: :unauthorized

      return
    end

    authenticate
  end

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
