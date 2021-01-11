class CommentDecorator < Draper::Decorator
  delegate_all

  def author
    object.user.try(:name)
  end

  def accessible_to(user)
    object.user == user
  end
end
