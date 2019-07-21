class FilmSerializer < ActiveModel::Serializer
  attributes :id, :title, :year, :poster, :watched_on, :suggested_by

  def watched_on
    scope.reviews&.find_by(film: object)&.date_watched
  end

  def suggested_by
    {
      id: object.user.id,
      name: object.user.name
    }
  end
end
