require 'json'

class FilmCreator
  def self.call(params)
    directors = get_directors(params[:movie_db_id])

    Film.create(params.merge(director: directors))
  end

  def self.get_directors(movie_db_id)
    credits_url = 'https://api.themoviedb.org/3/movie/' \
                  "#{movie_db_id}?api_key=#{ENV['MOVIEDB_API_KEY']}" \
                  '&append_to_response=credits'
    json = Net::HTTP.get_response(URI(credits_url)).body

    JSON
      .parse(json)['credits']['crew']
      .keep_if { |member| member['job'] == 'Director' }
      .map { |director| director['name'] }
      .join(', ')
  end
end
