# frozen_string_literal: true

class StatsService
  def self.avg_scores
    User.all.map do |user|
      reviews_count = user.reviews.where('score > 0').count.to_f
      reviews_score_sum = user.reviews.reduce(0) do |sum, review|
        review.score.to_i.positive? ? review.score.to_i + sum : sum
      end

      {
        user_id: user.id,
        user_name: user.name,
        avg_score: (reviews_score_sum / reviews_count).round(2)
      }
    end
  end
end
