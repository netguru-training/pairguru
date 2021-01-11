class GenreSerializer < ActiveModel::Serializer

  attributes :id, :name, :movies_count

  def movies_count
    Movie.where(genre_id: object.id).count
  end

end