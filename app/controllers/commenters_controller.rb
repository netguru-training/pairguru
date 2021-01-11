class CommentersController < ApplicationController

  def index
    @commenters = User.comments_count_ordered
  end

end
