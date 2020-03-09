module ApplicationHelper
  def comments_present?(comments)
    comments.present?
  end

  def user_has_no_comments?(comments)
    users_ids = comments.pluck(:user_id)
    users_ids.include?(current_user&.id) ? false : true
  end

  def user_comment?(comment)
    current_user&.id == comment&.user_id
  end

  def avatar_or_cover(movie)
    movie&.avatar.present? ? movie.avatar : movie.cover
  end

  def is_model_instance?(model, model_name)
    model.is_a?(model_name)
  end
end
