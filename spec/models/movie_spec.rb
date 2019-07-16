require "rails_helper"

describe Movie do
  let(:movie) { build(:movie) }
  
  it "movie should be have a poster" do
    movie.title = "Deadpool"
    expect(movie.poster().to_s).to include(".jpg") 
  end
  
  it "movie not should be have a poster" do
    movie.title = "Deadpol"
    expect(movie.poster()).to eq(nil) 
  end
  
  it "movie should be have a plot" do
    movie.title = "Deadpool"
    expect(movie.plot()).to_not eq(nil) 
  end

  it "movie not should be have a plot" do
    movie.title = "Deadpol"
    expect(movie.plot()).to eq(nil) 
  end
  
  it "movie should be have a rating" do
    movie.title = "Deadpool"
    expect(movie.rating()).to_not eq(nil) 
  end

  it "movie not should be have a rating" do
    movie.title = "Deadpol"
    expect(movie.rating()).to eq(nil) 
  end
end
