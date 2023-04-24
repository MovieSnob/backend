# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def me
    render json: {
      me: UserSerializer.new(@current_user),
      users: ActiveModel::ArraySerializer.new(User.all, each_serializer: UserSerializer)
    }
  end
end
