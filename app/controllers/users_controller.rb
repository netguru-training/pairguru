class UsersController < ApplicationController
  def top_commenters
    @top_commenters = Users::Queries::TopCommenters.call
  end
end
