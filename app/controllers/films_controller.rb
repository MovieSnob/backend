class FilmsController < ApplicationController
  def create
    Film.create(film_params)
  end

  def index
    render json: Film.all
  end

  private

  def film_params
    params.require(:film).permit(
      :title, :year, :director
    )
  end
end