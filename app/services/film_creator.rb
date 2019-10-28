require 'json'
require 'net/http'

class FilmCreator
  def self.call(params)
    current_film = film_data(params[:movie_db_id])
    directors = get_directors(current_film)
    imdb_id = current_film['imdb_id']

    Film.create(params.merge(director: directors, imdb_id: imdb_id))
  end

  def self.get_directors(film_data)
    film_data['credits']['crew']
      .keep_if { |member| member['job'] == 'Director' }
      .map { |director| director['name'] }
      .join(', ')
  end

  def self.film_data(movie_db_id)
    credits_url = 'https://api.themoviedb.org/3/movie/' \
                  "#{movie_db_id}?api_key=#{ENV['MOVIEDB_API_KEY']}" \
                  '&append_to_response=credits'
    json = Net::HTTP.get_response(URI(credits_url)).body

    JSON.parse(json)
  end
end
