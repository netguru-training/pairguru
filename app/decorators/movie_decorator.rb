class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    "http://lorempixel.com/100/150/" +
      %w[abstract nightlife transport].sample +
      "?a=" + SecureRandom.uuid
  end

  def rating
    return if details.empty?
    h.content_tag :span, details["rating"], class: "badge badge-secondary"
  end

  def plot
    return if details.empty?
    details["plot"]
  end

  def poster
    return if details.empty?
    "https://pairguru-api.herokuapp.com#{details["poster"]}"
  end

  def is_commented_by?(user)
    comments.where(user: user).any?
  end

  private

  def details
    @details ||= MovieImporter.new(object).call
  end
end
