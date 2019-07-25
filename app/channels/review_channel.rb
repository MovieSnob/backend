# frozen_string_literal: true

class ReviewChannel < ApplicationCable::Channel
  def subscribed
    stream_from('review')
  end
end
