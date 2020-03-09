class SendMovieInfoWorker < BaseWorker
  def perform(user_id, movie_id)
    user = User.find(user_id)
    movie = Movie.find(movie_id)
    MovieInfoMailer.send_info(user, movie)&.deliver_now
  end
end
