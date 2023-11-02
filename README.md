# StudyBuddy

StudyBuddy is a collaborative platform designed to help students find study, homework, and project partners for their classes. With features that allow students to enroll in courses, join groups, and view group availability, StudyBuddy aims to enhance the academic experience and foster a community of learners.

## Live Application

The application is live at: [StudyBuddy on Heroku](https://stark-headland-66813-685e9c0117bd.herokuapp.com)

## Team members:

- Brian Luna (bsl2130)
- Kabir Bagai (kb3343)
- Sayef Iqbal (si2400)
- Yuya Taniguchi (yt2749)

## Features

- Course Enrollment: Students can browse and enroll in courses relevant to their studies.
- Group Collaboration: Enables students to join groups for collaborative study sessions.
- Availability Viewing: Students can view the availability of groups to plan their study schedules.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Ruby version: Ruby 2.7.0
- Rails version: Rails 6.0.3.4
- Database: PostgreSQL

### Installation

1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Install the required gems: bundle install
4. Set up your PostgreSQL:
  - brew reinstall libpq
  - export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
  - gem install pg
5. Create the database: rails db:create
6. Initialize the database: rails db:migrate
7. Load the seed data: rails db:seed


### Running the Tests

- To run the Cucumber scenarios:
bundle exec cucumber

- To run the RSpec test suite:
bundle exec rspec spec



### Services

Currently, no additional services like Redis or Sidekiq are integrated.

### Deployment

To deploy this on a live system, ensure all environment variables are set on the deployment platform and follow standard Rails deployment procedures for platforms like Heroku or AWS.

## Documentation

- **Cucumber Scenarios**: Located in the `features` folder with step definitions in `features/step_definitions`.
- **RSpec Tests**: Test files are in the `spec` folder.


