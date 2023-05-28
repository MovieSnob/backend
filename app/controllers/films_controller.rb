# frozen_string_literal: true

class FilmsController < ApplicationController
  def create
    FilmCreator.call(film_params.merge(user: @current_user))
    TelegramNotifier.call(
      "#{@current_user.name} #{@current_user.gender == 0 ? 'предложил' : 'предложила'} посмотреть фильм «#{film_params[:title]}»"
    )

    render json: Film.suggested
  end

  def suggested
    render json: Film.suggested
  end

  def watched
    render json: Film.watched
  end

  def reviewed
    render json: Film.reviewed.order(created_at: :desc), each_serializer: ReviewedFilmSerializer
  end

  def index
    render json: Film.all
  end

  def mark_watched
    user = User.find(params[:user_id])
    film = Film.find(params[:id])

    TelegramNotifier.call("#{user.name} #{user.gender == 0 ? 'посмотрел' : 'посмотрела'} фильм «#{film.title}»")

    Review
      .find_or_create_by(user_id: params[:user_id], film_id: params[:id])
      .update(date_watched: params[:date])
  end

  def mark_unwatched
    user = User.find(params[:user_id])
    film = Film.find(params[:id])

    TelegramNotifier.call("#{user.name} #{user.gender == 0 ? 'отметил' : 'отметила'} фильм «#{film.title}» непросмотренным")

    Review
      .find_or_create_by(user_id: params[:user_id], film_id: params[:id])
      .update(date_watched: nil)
  end

  def score
    film = Film.find(params[:id])

    review = Review.find_or_create_by(user: current_user, film_id: params[:id])
    date_watched = review.date_watched || Date.today

    review.update(
      date_watched:,
      date_reviewed: Date.today,
      score: params[:score]
    )

    film.reviewed! if film.reviewed_by_everyone?

    ActionCable.server.broadcast(
      'review',
      {
        type: 'scores',
        scores: scores(film),
        movie_id: film.id
      }
    )
  end

  def destroy
    film = Film.find(params[:id])

    film.reviews.delete_all
    film.delete
  end

  private

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
      :title, :year, :poster, :movie_db_id, :runtime
    )
  end
end
