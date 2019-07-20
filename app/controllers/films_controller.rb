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
    Review
      .find_or_create_by(user: current_user, film_id: params[:id])
      .update(date_watched: params[:date])
  end

  def mark_unwatched
    Review
      .find_or_create_by(user: current_user, film_id: params[:id])
      .update(date_watched: nil)
  end

  private

  def film_params
    params.require(:film).permit(
      :title, :year, :poster, :movie_db_id
    )
  end
end
