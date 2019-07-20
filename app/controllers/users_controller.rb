class UsersController < ApplicationController
  def me
    render json: {
      name: @current_user.name,
      email: @current_user.email
    }
  end
end
