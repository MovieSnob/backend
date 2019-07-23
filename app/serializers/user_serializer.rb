# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :gender, :online, :watched_movies

  def watched_movies
    object.reviews.where.not(date_watched: nil).pluck(:film_id)
  end
end
