class Film < ApplicationRecord
  enum state: %i[suggested watched reviewed]

  validates :title, presence: true
  validates :year, presence: true

  belongs_to :user
  has_many :reviews, dependent: :destroy
end
