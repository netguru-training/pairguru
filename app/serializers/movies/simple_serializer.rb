module Movies
  class SimpleSerializer < ActiveModel::Serializer
    attributes :id, :title
  end
end
