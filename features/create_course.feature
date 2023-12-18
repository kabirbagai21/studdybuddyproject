Feature: create course

  As a class instructor
  SI want to create a new course

Background: students in database

  Given the following students exist:
  | name            | email               | email_old           | password  | instructor |
  | Test Instructor | test@columbia.edu   | test@columbia.edu   | 123456789 | true       |

  Then 1 seed students should exist

 And I am logged in with email "test@columbia.edu" and password "123456789"

Scenario: view the enrollment for each student
  Given I am on the start page for "Test Instructor"
  Then  I should see "Test Instructor"
  And   I should see "No created courses"
  When  I follow "Create New Course"
  Then  I should see "New Course"
  When  I fill in "Name" with "Test Course"
  And   I fill in "Course Code" with "COMS 1111"
  And   I fill in "Section" with "1"
  And   I select "Fall" from "Semester"
  And   I select "2023" from "Year"
  And   I fill in "Max group size" with "4"
  And   I press the "Create Course" button
  Then  I should be on the course page for "Test Course"
  And   I should see "Test Instructor"

