Feature: show and update course enrollment

  As a class instructor
  So that I can keep enrollment information for each course
  I want to view and update student enrollment info

Background: students in database

  Given the following students exist:
  | name           | email               | bio      |
  | Kabir Bagai    | kb3343@columbia.edu | CS Major |
  | Yuya Taniguchi | yt2749@columbia.edu | CS Major |

  And the following courses exist:
  | name                | course_id   |
  | Engineering SaaS    | 4152        |
  | AP                  | 3157        |

  And I am on the StudyBuddy home page
  Then 2 seed students should exist

Scenario: view the enrollment for each student
  Given I am on the profile page for "Yuya Taniguchi"
  Then  I should see "No enrolled courses"

Scenario: view the enrollment for each course
  Given I am on the profile page for "Kabir Bagai"
  When  I fill in "Course ID" with "4152"
  And   I press the "Join" button
  Then  I should be on the profile page for "Kabir Bagai"
  And   I should see "Successfully enrolled in the course."
  And   I should see "Engineering SaaS"
  When  I follow "Engineering SaaS" 
  Then  I should be on the course page for "Engineering SaaS"
  And   I should see "Kabir Bagai"

Scenario: enroll a student in a course
  Given I am on the profile page for "Yuya Taniguchi"
  When  I fill in "Course ID" with "4152"
  And   I press the "Join" button
  Then  I should be on the profile page for "Yuya Taniguchi"
  And   I should see "Successfully enrolled in the course."
  And   I should see "Engineering SaaS"

Scenario: enroll a student in an already enrolled course
  Given I am on the profile page for "Yuya Taniguchi"
  When  I fill in "Course ID" with "3157"
  And   I press the "Join" button
  Then  I should be on the profile page for "Yuya Taniguchi"
  And   I should see "Successfully enrolled in the course."
  And   I should see "AP"
  When  I fill in "Course ID" with "3157"
  And   I press the "Join" button
  Then  I should be on the profile page for "Yuya Taniguchi"
  And   I should see "You are already enrolled in this course."

Scenario: enroll a student in an invalid course
  Given I am on the profile page for "Yuya Taniguchi"
  When  I fill in "Course ID" with "0000"
  And   I press the "Join" button
  Then  I should be on the profile page for "Yuya Taniguchi"
  And   I should see "Invalid Course ID. Please try again."