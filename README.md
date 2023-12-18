# StudyBuddy

StudyBuddy is a collaborative platform designed to help students find study, homework, and project partners for their classes. With features that allow students to enroll in courses, join groups, and view group availability, StudyBuddy aims to enhance the academic experience and foster a community of learners.

## Live Application

The application is live at: [StudyBuddy on Heroku](https://quiet-stream-84389-6ae62200e85e.herokuapp.com/students/sign_in)

## Team members:

- Brian Luna (bsl2130)
- Kabir Bagai (kb3343)
- Sayef Iqbal (si2400)
- Yuya Taniguchi (yt2749)

## Current Features

- Login and Signup page
- Course Enrollment: Students can enroll in courses relevant to their studies using a course code (for example use 4152 or 3157).
- Student Profile: Students can create and edit a profile with relevant info
- Instructor Profile: Instructors can sign up (by clicking the instructor checkbox) and create a profile
- Course Creation: Instructors can create a new course and set the course parameters. Creating a course will generate a join code that students can use to join the class.
- Course Page: Students can view the groups in the course as well as the groups they are in
- Create/Join Group: Students can create new group and request to join
- Approve Requests: Group Owners can approve requests for students to join their group
- Merge groups: A group can request to join with another group. The group receiving the request can accept/reject the request. 
- Leave/Delete group
- Updated UI

## Using the app
- Signup: Fill in the necessary fields on the signup page. If you are an instructor check the "Are you an instructor box.
- Course creation: When signed in as an instructor, click the "Create New Course" button and fill in fields. Once the course is created, the instructor can also edit the fields by clicking the "Edit Course" button on the course page.
- Join Code: On the instructor's profile page, make note of the join code for the class you just created. Copy the code to the clipboard
- Edit Profile: Students can edit their profile by clicking the "Edit Profile" button on their profile page.
- Joining a course: When signed in as a student, paste the join code into the "Join Course" textbox. Doing so will enroll the student in a course
- Creating a group: When logged in as a student, click the "Create new group" button on the course page. You can leave or delete the group as well.
- Public profiles: Click on the student's name in the group to view their public profile. 
- Requesting to join a group: Click on the group you wish to join and click "Request to join". You can cancel the join request as well. You cannot request to join a group if it is full or if you are already in a group.
- Approving a join request: If you are a member of a group, you can see and approve all join requests for your group. 
- Merge requests: Follow the same process for approving/denying as join requests. Once a merge request is approved, all students from the requesting group will be added to the requested group.

Note: there is some seed data that exists. Here is the login info 
Password (for all users): 123456789
Students
Email: kb3343@columbia.edu 
       yt2749@columbia.edu
       si2400@columbia.edu
Instructors:
Email: jy2324@columbia.edu
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
