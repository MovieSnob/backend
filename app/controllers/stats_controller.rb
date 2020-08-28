# frozen_string_literal: true

class StatsController < ApplicationController
  def index
    render json: {
      avg_scores: StatsService.avg_scores
    }
  end
end
