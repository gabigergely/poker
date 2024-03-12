# README

* Ruby version
3.3.0

* Rails version
7.1.3

* Configuration
Run `bundle install` to get all dependencies installed. The app doesn't connect to a database and doesn't leverage ActiveRecord. Data is fed to the games_controller directly for simplicity. It can be found in poker.txt file. To start it, run `bundle exec rails s` and navigate to http://localhost:3000/games

* How to run the test suite
bundle exec rspec
