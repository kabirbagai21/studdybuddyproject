Feature: show and update course enrollment

  As a class instructor
  So that I can keep enrollment information for each course
  I want to view and update student enrollment info

Background: students in database

  Given the following students exist:
  | name           | email               | email_old           | password  | bio      | insturctor |
  | Yuya Taniguchi | yt2749@columbia.edu | yt2749@columbia.edu | 123456789 | CS Major | false      |


  And the following courses exist:
  | name                | course_id   | course_code | max_group_size |
  | AP                  | 3157        | COMS 3157   | 4              |

  Then 1 seed students should exist
  And 1 seed courses should exist

 And I am logged in with email "yt2749@columbia.edu" and password "123456789"

Scenario: view the enrollment for each student
  Given I am on the start page for "Yuya Taniguchi"
  Then  I should see "Yuya"
  And   I should see "No enrolled courses"

Scenario: enroll a student in a course
  Given I am on the start page for "Yuya Taniguchi"
  Then  I should see "Yuya"
  When  I fill in "Course ID" with "AP"
  And   I press the "Join" button
  Then  I should be on the profile page for "Yuya Taniguchi"
  And   I should see "Successfully enrolled in the course."
  And   I should see "AP"

Scenario: enroll a student in an already enrolled course
  Given I am on the start page for "Yuya Taniguchi"
  Then  I should see "Yuya"
  When  I fill in "Course ID" with "AP"
  And   I press the "Join" button
  Then  I should be on the profile page for "Yuya Taniguchi"
  And   I should see "Successfully enrolled in the course."
  And   I should see "AP"
  When  I fill in "Course ID" with "AP"
  And   I press the "Join" button
  Then  I should be on the profile page for "Yuya Taniguchi"
  And   I should see "You are already enrolled in this course."

Scenario: enroll a student in an invalid course
  Given I am on the start page for "Yuya Taniguchi"
  Then  I should see "Yuya"
  When  I fill in "Course ID" with "0000"
  And   I press the "Join" button
  Then  I should be on the profile page for "Yuya Taniguchi"
  And   I should see "Invalid Course ID. Please try again."