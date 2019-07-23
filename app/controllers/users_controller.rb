# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def me
    render json: @current_user
  end
end
