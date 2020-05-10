class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.paginate(:page => params[:page], :per_page => 5).decorate
  end

  def show
    @movie = Movie.find(params[:id])
    if current_user
      @user_comment_exists = @movie.comments.find_by_user_id(current_user.id)
      @comment = @movie.comments.build unless @user_comment_exists
    end
  end
 
  def send_info
    @movie = Movie.find(params[:id])
    SendMovieInfoJob.perform_later(current_user, @movie)
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    CsvMoviesExportJob.perform_later(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end
end
