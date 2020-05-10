class SendMovieInfoJob < ApplicationJob
  queue_as :default

  def perform(user, movie)
    MovieInfoMailer.send_info(user, movie).deliver_now
  end
end
