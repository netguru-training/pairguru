class MovieDecorator < Draper::Decorator
  delegate_all
  def cover
    "http://lorempixel.com/100/150/" +
      %w[abstract nightlife transport].sample +
      "?a=" + SecureRandom.uuid
  end
  
  def self.collection_decorator_class
    PaginatingDecorator
  end
end
