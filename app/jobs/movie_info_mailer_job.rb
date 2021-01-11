MovieInfoMailerJob = Struct.new(:user_id, :movie_id) do
  def perform
    user = User.find(user_id)
    movie = Movie.find(movie_id)

    MovieInfoMailer.send_info(user, movie).deliver_now
  end

  def queue_name
    "email_delivery"
  end
end
