class MovieSerializer < ActiveModel::Serializer

  attributes :id, :title

  belongs_to :genre, if: -> { details }

  def details
    instance_options[:details]
  end
end