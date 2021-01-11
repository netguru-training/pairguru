module Movies
  class API < Grape::API
    version 'v1', using: :path, vendor: 'Pairguru'
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers
    prefix :api

    rescue_from :all do |e|
      error_response(message: e.message, backtrace: e.backtrace, status: e.status)
    end

    # curl -d '{"details": true}' -X GET http://localhost:3000/api/v1/movies -H Content-Type:application/json -v
    # curl -d '{"details": false}' -X GET http://localhost:3000/api/v1/movies/2 -H Content-Type:application/json -v

    resource :movies do
      params do
        optional :details, type: Boolean, default: false
      end

      desc 'Return all movies info'
      get '/' do
        render Movie.all, extra: { details: params[:details] }
      end

      desc 'Return movies info by id'
      get ':id' do
        render Movie.find(params[:id]), extra: { details: params[:details] }
      end

    end

  end
end