class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  expose_decorated(:movies) { Movie.all }
  expose(:movie)

  def send_info
    MovieInfoMailer.send_info(current_user, movie).deliver_now
    redirect_to :back
  end
end
