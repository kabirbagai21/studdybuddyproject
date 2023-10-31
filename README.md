# README

## StudyBuddy

StudyBuddy is a platform designed to help students find study, homework, and project partners for their classes. It allows students to enroll in courses, join groups, and view group availability.

## Things you may want to cover:

* **Ruby version**: Ruby 2.7.0

* **System dependencies**: 
  - Rails 6.0.3.4
  - PostgreSQL

* **Configuration**: 
  - Ensure all environment variables and configurations are set.
  - Set up your database.yml with the correct username and password for PostgreSQL.

* **Database creation**: rails db:create


* **Database initialization**: 
rails db:migrate


* **How to run the test suite**: 
bundle exec rspec spec


* **Services (job queues, cache servers, search engines, etc.)**: 
- Currently, no additional services like Redis or Sidekiq are integrated.

* **Deployment instructions**: 
- Ensure all environment variables are set on the deployment platform.
- Follow standard Rails deployment procedures for platforms like Heroku or AWS.

### Rspec Tests

The rspec test files are located in the `spec` folder.
To run rspec tests, execute the following:
bundle exec rspec spec
