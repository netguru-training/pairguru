# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  belongs_to :genre
  has_many :comments
    
  validates_with TitleBracketsValidator
  
  def api_data
    api_request = ApiRequest.new()
    api_request.movie_details(self.title)
  end

  def poster
    (@api_data ||= api_data)
    @api_data ? URI.join(ApiRequest::API_SERVER, @api_data['poster']) : nil
  end

  def plot
    (@api_data ||= api_data)
    @api_data ? @api_data['plot'] : nil
  end
    
  def rating
    (@api_data ||= api_data)
    @api_data ? @api_data['rating'] : nil
  end    
end

 