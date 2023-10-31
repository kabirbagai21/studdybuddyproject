# README

## StudyBuddy

StudyBuddy is a platform designed to help students find study, homework, and project partners for their classes. It allows students to enroll in courses, join groups, and view group availability.

**Team members**:

- Brian Luna (bsl2130)
- Kabir Bagai (kb3343)
- Sayef Iqbal (si2400)
- Yuya Taniguchi (yt2749)

## Things you may want to cover:

- **Ruby version**: Ruby 2.7.0

- **System dependencies**:

  - Rails 6.0.3.4
  - PostgreSQL

- **Configuration**:

  - Ensure all environment variables and configurations are set.
  - Set up your database.yml with the correct username and password for PostgreSQL.

- **Database creation**: rails db:create

- **Database initialization**:
  rails db:migrate

* **Load seed data**:
  db:seed

- **How to run the Cucumber scenarios** :
  bundle exec cucumber

- **How to run the test suite**:
  bundle exec rspec spec

- **Services (job queues, cache servers, search engines, etc.)**:

* Currently, no additional services like Redis or Sidekiq are integrated.

- **Deployment instructions**:

* Ensure all environment variables are set on the deployment platform.
* Follow standard Rails deployment procedures for platforms like Heroku or AWS.

### Cucumber Scenarios

The Cucumber feature files are located in the `features` folder.
The step definition files are located in the `features/step_definitions` folder.
Tu run Cucumber scenarios, execute the following: bundle exec cucumber

### Rspec Tests

The rspec test files are located in the `spec` folder.
To run rspec tests, execute the following:
bundle exec rspec spec
