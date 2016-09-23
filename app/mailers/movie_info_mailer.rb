class MovieInfoMailer < ApplicationMailer
  def send_info(user, movie)
    @movie = movie
    sleep(3) # this emulates long email sending, do not remove
    mail(to: user.email, subject: "Info about movie #{movie.title}")
  end
end
