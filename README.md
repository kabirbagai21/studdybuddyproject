# StudyBuddy

StudyBuddy is a collaborative platform designed to help students find study, homework, and project partners for their classes. With features that allow students to enroll in courses, join groups, and view group availability, StudyBuddy aims to enhance the academic experience and foster a community of learners.

## Live Application

The application is live at: [StudyBuddy on Heroku](https://stark-headland-66813-685e9c0117bd.herokuapp.com)

## Team members:

- Brian Luna (bsl2130)
- Kabir Bagai (kb3343)
- Sayef Iqbal (si2400)
- Yuya Taniguchi (yt2749)

## Current Features

- Course Enrollment: Students can enroll in courses relevant to their studies using a course code (for example use 4152 or 3157).
- Group Collaboration: Enables students to view classmates and groups in courses they're enrolled in.
- Student Profile: Students can create and edit a profile with relevant info

Note: The "Add Student" functionality has not yet been implemented
## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Ruby version: Ruby 2.7.0
- Rails version: Rails 6.0.3.4
- Database: PostgreSQL

### Installation

1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Install the required gems: `bundle install`
4. Set up your PostgreSQL:
```
brew reinstall libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
gem install pg
```
5. Create the database: `rails db:create`
6. Initialize the database: `rails db:migrate`
7. Load the seed data: `rails db:seed`


### Running the Tests

- To run the Cucumber scenarios:
`bundle exec cucumber`

- To run the RSpec test suite:
`bundle exec rspec spec`



### Services

Currently, no additional services like Redis or Sidekiq are integrated.

### Deployment

To deploy this on a live system, ensure all environment variables are set on the deployment platform and follow standard Rails deployment procedures for platforms like Heroku or AWS.

## Documentation

- **Cucumber Scenarios**: Located in the `features` folder with step definitions in `features/step_definitions`.
- **RSpec Tests**: Test files are in the `spec` folder.


# User Registration 

## Devise
https://www.digitalocean.com/community/tutorials/how-to-set-up-user-authentication-with-devise-in-a-rails-7-application

## Devise setup from scratch

#### Install necessary gems

```
gem 'bcrypt', '~> 3.1.7' # For password hashing
gem 'devise', '~> 4.8'   # For user authentication
```

#### Generate Devise configuration
```
rails generate devise:install
```
This will create a configuration file at config/initializers/devise.rb. 

#### Generate migration file for Student model using devise
```
rails generate devise Student
```

#### Update `app/models/student.rb`
```
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
```

#### Create views for registrations
```
rails generate devise:views
```

#### Update `config/routes.rb`
```
devise_for :students
```

#### Add necessary `sign_in/sign_up/sign_out` options
Open show.html.erb file under Student view and add it in the beginning of the file
```
<% if student_signed_in? %>
<%= button_to "Sign Out", destroy_student_session_path, method: :delete %> 
<% else %>
<%= link_to 'Sign Up', new_student_registration_path %>
<%= link_to 'Sign In', new_student_session_path %>
<% end %>
```

#### Update controller
Add the following block in the controller to show sign in page before the show.html.erb file is rendered
```
before_action :authenticate_student!, only: [:show]
```

## Devise usage (Registration)

### Install necessary gems
```
gem 'bcrypt', '~> 3.1.7' # For password hashing
gem 'devise', '~> 4.8'   # For user authentication
```

```
bundle install
```

### Run db migrations
```
rails db:create
rails db:migrate
rails db:seed
```

### Run the app
```
rails server
```