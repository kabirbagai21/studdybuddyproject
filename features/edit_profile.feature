Feature: update student profile info

  As a student
  So that I can update my personal information 
  I want to edit my student profile info

Background: students in database and logged in as Kabir Bagai

  Given the following students exist:
  | name           | email               | email_old           | password  | bio      |
  | Kabir Bagai    | kb3343@columbia.edu | kb3343@columbia.edu | 123456789 | CS Major |
  | Yuya Taniguchi | yt2749@columbia.edu | yt2749@columbia.edu | 123456789 | CS Major |

  And I am logged in with email "kb3343@columbia.edu" and password "123456789"


Scenario: edit profile for a student
  Given I am on the start page for "Kabir Bagai"
  Then  I should see "Kabir"
  When  I follow "Edit Profile"
  Then  I should be on the edit page for "Kabir Bagai"
  When  I fill in "Bio" with "Computer Science Major"
  And   I press the "Update Profile Info" button
  Then  I should be on the profile page for "Kabir Bagai"
  And   I should see "Computer Science Major"
  But   I should not see "CS Major"