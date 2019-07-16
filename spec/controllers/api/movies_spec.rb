require 'rails_helper'
describe Api::MoviesController, :type => :request do
  describe "GET #index" do
    let(:movie) {build(:movie)}
    
    before do
      movie.save
    end    
    
    it "render template" do
      get "/api/movies"
      expect(response).to render_template(:index)      
    end
    
    it "returns http success" do
      get "/api/movies"
      expect(response).to have_http_status(:success)
    end
    
    it "response with JSON body containing expected Movie attributes" do
      get "/api/movies"
      hash_body = JSON.parse(response.body)
      expect(hash_body[0]).to match({id: movie.id, title: movie.title}.as_json)
    end
    
    it "response with JSON body containing expected Movie attributes with genre data" do
      get "/api/movies?details=true"
      hash_body = JSON.parse(response.body)
      expect(hash_body[0]).to include("genre")
    end
  end
end