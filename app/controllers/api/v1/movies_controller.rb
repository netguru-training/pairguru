module Api
  module V1
    class MoviesController < ActionController::API
      # GET api/v1/movies
      # GET api/v1/movies?include_genre=true
      def index
        movies = Movie.all.includes(:genre)
        render json: movies, each_serializer: assign_serializer, status: 201
      end

      # GET api/v1/movies/:id
      # GET api/v1/movies/:id?include_genre=true
      def show
        movie = Movie.includes(:genre).find(params[:id])
        render json: movie, serializer: assign_serializer, status: 201
      rescue ActiveRecord::RecordNotFound
        render json: { error: I18n.t('movie.not_found') }, status: :not_found
      end

      private

      def assign_serializer
        params[:include_genre].present? ? Movies::DetailedSerializer : Movies::SimpleSerializer
      end
    end
  end
end
