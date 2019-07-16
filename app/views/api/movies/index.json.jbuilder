json.array! @movies do |movie|
    json.id movie.id
    json.title movie.title
    if @with_details
        json.genre do
            json.id movie.genre.id
            json.name movie.genre.name
            json.count_movies movie.genre.movies.count
        end
    end
end