class ApiRequest
  API_SERVER = "https://pairguru-api.herokuapp.com"
  
  def movie_details(movie_title)
    uri = URI.parse(URI.escape("#{API_SERVER}/api/v1/movies/#{movie_title}"))
    Net::HTTP.start(uri.host) do |http|
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request request
      json_body = JSON.parse(response.body)
      Net::HTTPSuccess and json_body.key?('data') ? json_body['data']['attributes'] : nil
    end
  end
end
