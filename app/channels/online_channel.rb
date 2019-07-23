# frozen_string_literal: true

class OnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from('online')

    current_user.appear

    ActionCable.server.broadcast('online', type: 'users_list', users: users_json)
  end

  def unsubscribed
    current_user.disappear

    ActionCable.server.broadcast('online', type: 'users_list', users: users_json)
  end

  private

  def users_json
    users = User.all

    ActiveModel::ArraySerializer.new(users, each_serializer: UserSerializer).to_json
  end
end
