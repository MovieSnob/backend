# frozen_string_literal: true

class FilmSerializer < ActiveModel::Serializer
  attributes :id, :title, :year, :poster, :watched_on, :suggested_by

  def watched_on
    scope.reviews&.find_by(film: object)&.date_watched
  end

  def suggested_by
    user = object.user
    {
      id: user.id,
      name: user.name,
      gender: user.gender
    }
  end
end
