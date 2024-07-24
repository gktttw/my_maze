# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  * 3.1.6

* System dependencies

* Configuration

* Database creation
  * dev
    * docker run --name maze_development -d -p 5432:5432 -e POSTGRES_DB=maze_development -e POSTGRES_USER=maze_user -e POSTGRES_PASSWORD=maze_password postgres
  * test
    * docker run --name maze_test -d -p 5433:5432 -e POSTGRES_DB=maze_test -e POSTGRES_USER=maze_user -e POSTGRES_PASSWORD=maze_password postgres

* Database initialization
  * dev
    * rails db:migrate
  * test
    * RAILS_ENV=test rake db:migrate

* How to run the test suite
  * bundle exec rspec
