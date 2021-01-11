require "rails_helper"

describe Movie, :api do
  let!(:movies) { create_list(:movie, 20) }

  context 'GET /api/v1/movies' do
    it 'returns 200' do
      expect(call_api).to eq(200)
    end

    it 'returns all movies' do
      call_api
      movie_list = JSON.parse(response.body)
      expect(movie_list.count).to eq(movies.count)
      expect(movie_list[0].keys).to eq ["id", "title"]
    end
  end

  context 'GET /api/v1/movies?details=true' do

    it 'returns 200' do
      expect(call_api).to eq(200)
    end

    it 'returns all movies with genre details' do
      call_api
      movie_list = JSON.parse(response.body)
      expect(movie_list[0]).to have_key("genre")
      expect(movie_list[0]["genre"].keys).to eq(["id", "name", "movies_count"])
    end

  end

  context 'GET /api/v1/movies/1' do

    it 'returns 200' do
      expect(call_api).to eq(200)
    end

    it 'returns one movie by id' do
      call_api
      movie_list = JSON.parse(response.body)
      expect(movie_list).to be_kind_of(Hash)
      expect(movie_list).to have_key("id")
      expect(movie_list).to have_key("title")
    end

  end

  context 'GET /api/v1/movies/1?details=true' do

    before(:each) {
      call_api
      @one_movie = JSON.parse(response.body)
    }

    it 'returns one movie by id with genre details' do
      expect(@one_movie).to have_key("genre")
      expect(@one_movie["genre"].keys).to eq(["id", "name", "movies_count"])
    end

    it 'returns correct genre details' do
      genre_count = movies.select {|m| m.genre_id == @one_movie["genre"]["id"] }.count
      expect(@one_movie).to have_key("genre")
      expect(@one_movie["genre"]["movies_count"]).to eq genre_count
    end

  end

end