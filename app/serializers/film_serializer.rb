class FilmSerializer < ActiveModel::Serializer
  attributes :id, :title, :year, :poster, :watched_on

  def watched_on
    scope.reviews&.find_by(film: object)&.date_watched
  end
end
