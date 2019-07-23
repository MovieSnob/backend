# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :films
  has_many :reviews

  default_scope { order(name: :asc) }

  def appear
    update(online: true)
  end

  def disappear
    update(online: false)
  end
end
