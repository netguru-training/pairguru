## Welcome to Pairguru App!
Place where we examine our candidates

## :hammer: Setup

Before pairing:
 - Clone repo `git clone git@github.com:netguru-training/pairguru.git`
 - run `bundle install` within app directory
 - run `rake db:setup` This will create database, run migrations and fill db with seeds
 - run `rails s` :boom:

 ## Pre-interview tasks (optional)

 Do not fork the repository - clone it
 Do not forget to write tests for your solutions

 ### Task 1 - consume api
 We would like to have more information about the movie in movie show and index page. The information should come from pairguru api (e.g. https://pairguru-api.herokuapp.com/api/v1/movies/Godfather). We should display movie poster (e.g. https://pairguru-api.herokuapp.com/godfather.jpg), rating and plot overview. We can't store this data in database.

 ### Task 2 - build api
 We would like to share our movies via api. We want to return list of all out movies (id and title). Besides that we would like to for user to get specific movie by id.

 After a while developers started asking us to extend our results by adding genre details. They want genre id, name and number of movies in this genre to be returned along with the movies. We don't want to break api for existing users or make them to fetch more data.

 ### Task 3 - long running tasks
 We have two tasks that run too long and users leave our page frustrated: emailing details about movie (button in movie show) and emailing movies csv export (in navigation). We should make it that user doesn't have to wait for page load and still get emails.

 ### Task 4 - brackets validation
 Our moderators are adding parentheses and brackets to the titles.

 For example `The Fellowship of the Ring [Lord of The Rings {Peter Jackson}] (2012)`.

 This is ok, but we need to make sure that all brackets are closed and not empty. They can be nested as in the example above.

 Uncomment tests in `spec/validators/title_brackets_validator_spec.rb` and add validations for movie title that match all the criteria.

 Hint: It can't be solved via regular expressions.

 ### Task 5 - comments
 Our users want to comment on movies. Let's add feature that allows them to do that.

 We should have new comment form under the movie description and all the comments listed below that.

 Additionally - one user should be allowed to leave only one comment to the movie. He can create another only if he deletes previous one.

 ### Task 6 - sql query (dependent on 5)
 We want to reward our users for commenting movies. The idea is to create page with top commenters this week.

 It should have 10 users that have the most comments in last week (from 7 days ago to now).

 This page will be very popular. We don't want to spam database with many queries in one pageview.

 Hint: It can be solved by using ActiveRecord.
