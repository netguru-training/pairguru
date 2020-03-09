class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies_list = Movie.all.includes(:genre).paginate(page: params[:page], per_page: 20)
    @movies = ImportData.call(@movies_list, @movies_list.pluck(:title).uniq)
  end

  def show
    @movie = Movie.find(params[:id])
    @comment = @movie.comments.build
    @comments = Comment.where(movie_id: params[:id])
    @movie = ImportData.call([@movie], [@movie.title])[0]
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: I18n.t('movie.not_found')
  end

  def send_info
    if params[:id]
      SendMovieInfoWorker.perform_async(current_user.id, params[:id])
      redirect_back(fallback_location: root_path, notice: I18n.t('movie.sent_movie_info'))
    else
      redirect_to root_path, alert: I18n.t('movie.not_found')
    end
  end

  def export
    file_path = 'tmp/movies.csv'
    ExportMoviesWorker.perform_async(current_user.id, file_path)
    redirect_to root_path, notice: I18n.t('movies.exported')
  end
end
