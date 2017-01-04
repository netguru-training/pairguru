## Welcome to Pairguru App!
Place where we examine our candidates

## :hammer: Setup

Before pairing:
 - Clone repo `git clone git@github.com:netguru-training/pairguru.git`
 - run `bundle install` within app directory
 - run `rake db:setup` This will create database, run migrations and fill db with seeds
 - run `rails s` :boom:

 ## Pre-interview tasks (optional)
 ### Task 1 - consume api
 We would like to have more information about the movie in movie show page. The information should come from themoviedb api. We should display movie poster, average rating and plot overview. We can't store this data in database.

 ### Task 2 - build api
 We would like to share our movies via api. We want to return list of all out movies (id and title). Besides that we would like to for user to get specific movie by id.

 After a while developers started asking us to extend our results by adding genre details. They want genre id, name and number of movies in this genre to be returned along with the movies. We don't want to break api for existing users or make them to fetch more data.

 ### Task 3 - long running tasks
 We have two tasks that run too long and users leave our page frustrated: emailing details about movie (button in movie show) and emailing movies csv export (in navigation). We should make it that user doesn't have to wait for page load and still get emails.
