# frozen_string_literal: true

class Film < ApplicationRecord
  enum state: %i[suggested reviewed]

  validates :title, presence: true
  validates :year, presence: true

  belongs_to :user
  has_many :reviews, dependent: :destroy

  def reviewed_by_everyone?
    total_users = User.count

    reviews.map(&:date_reviewed).compact.length == total_users
  end
end
