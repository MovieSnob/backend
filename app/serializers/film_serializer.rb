# frozen_string_literal: true

class FilmSerializer < ActiveModel::Serializer
  attributes :id, :title, :year, :poster, :watched_on, :suggested_by, :score, :scores, :director, :imdb_id

  def watched_on
    scope.reviews&.find_by(film: object)&.date_watched
  end

  def suggested_by
    user = object.user
    {
      id: user.id,
      name: user.name,
      gender: user.gender
    }
  end

  def score
    object.reviews&.find_by(user: object.user)&.score
  end

  def scores
    object.reviews.map do |review|
      {
        user_id: review.user_id,
        score: review.score
      }
    end
  end
end
