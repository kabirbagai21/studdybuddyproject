Feature: show and update student profile info

  As a class instructor
  So that I can keep information about each individual student
  I want to view and edit student profile info

Background: students in database

  Given the following students exist:
  | name           | email               | bio      |
  | Kabir Bagai    | kb3343@columbia.edu | CS Major |
  | Yuya Taniguchi | yt2749@columbia.edu | CS Major |

  And I am on the StudyBuddy home page
  Then 2 seed students should exist

Scenario: view the profile for each student
  Given I am on the StudyBuddy home page
  When  I follow "Kabir Bagai"
  Then  I should be on the profile page for "Kabir Bagai"
  And   I should see "kb3343@columbia.edu"
  But   I should not see "yt2749@columbia.edu"

Scenario: edit profile for a student
  Given I am on the profile page for "Kabir Bagai"
  When  I follow "Edit Profile"
  Then  I should be on the edit page for "Kabir Bagai"
  When  I fill in "Bio" with "Computer Science Major"
  And   I press the "Update Profile Info" button
  Then  I should be on the profile page for "Kabir Bagai"
  And   I should see "Computer Science Major"
  But   I should not see "CS Major"