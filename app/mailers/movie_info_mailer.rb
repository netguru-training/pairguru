class MovieInfoMailer < ApplicationMailer
  def send_info(user, movie)
    @movie = movie
    mail(to: user.email, subject: "Info about movie #{movie.title}")
  end
end
