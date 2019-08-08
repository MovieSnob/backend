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

    date_watched = review.date_watched || Date.today
    review.update(date_watched: date_watched, date_reviewed: Date.today, score: params[:score])
    film.reviewed! if film.reviewed_by_everyone?

    ActionCable.server.broadcast(
      'review',
      type: 'scores',
      scores: scores(film),
      movie_id: film.id
    )
  end

  def destroy
    film = Film.find(params[:id])

    film.reviews.delete_all
    film.delete
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
