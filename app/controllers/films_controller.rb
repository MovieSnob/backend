# frozen_string_literal: true

class FilmsController < ApplicationController
  def create
    Film.create(film_params.merge(user: @current_user))

    render json: Film.suggested
  end

  def suggested
    render json: Film.suggested
  end

  def watched
    render json: Film.watched
  end

  def index
    render json: Film.all
  end

  def mark_watched
    review.update(date_watched: params[:date])
  end

  def mark_unwatched
    review.update(date_watched: nil)
  end

  def score
    film = Film.find(params[:id])

    review.update(date_reviewed: Date.today, score: params[:score])

    ActionCable.server.broadcast(
      'review',
      type: 'scores',
      scores: scores(film),
      movie_id: film.id,
      all_voted: false # TODO: if all users have voted
    )
  end

  private

  def review
    Review.find_or_create_by(user: current_user, film_id: params[:id])
  end

  def scores(film)
    film.reviews.map do |review|
      {
        user_id: review.user_id,
        score: review.score
      }
    end
  end

  def film_params
    params.require(:film).permit(
      :title, :year, :poster, :movie_db_id
    )
  end
end
