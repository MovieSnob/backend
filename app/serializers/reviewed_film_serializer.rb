# frozen_string_literal: true

class ReviewedFilmSerializer < ActiveModel::Serializer
  attributes :watched_on, :title, :year, :poster, :suggested_by, :scores, :avg

  def watched_on
    object.created_at.to_time.to_i
  end

  def suggested_by
    user = object.user
    {
      id: user.id,
      name: user.name,
      gender: user.gender
    }
  end

  def scores
    object.reviews.each_with_object({}) do |review, memo|
      memo["user_#{review.user_id}"] = {
        user_id: review.user_id,
        name: review.user.name,
        score: review.score
      }
    end
  end

  def avg
    reviews_count = object.reviews.count

    sum = object.reviews.map(&:score).inject(0.0) { |sum, el| sum + el }

    (sum / reviews_count).round(2)
  end
end
