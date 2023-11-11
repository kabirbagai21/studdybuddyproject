Feature: sign out of StudyBuddy 

  As a student
  I want to sign out of the StudyBuddy page


Background: students in database

  Given the following students exist:
  | name           | email               | email_old           | password  | bio      |
  | Kabir Bagai    | kb3343@columbia.edu | kb3343@columbia.edu | 123456789 | CS Major |
  | Yuya Taniguchi | yt2749@columbia.edu | yt2749@columbia.edu | 123456789 | CS Major |

  And I am on the sign in page
  Then 2 seed students should exist


Scenario: successful sign out
  Given I am on the sign in page
  When  I fill in "Email" with "kb3343@columbia.edu"
  And   I fill in "Password" with "123456789"
  And   I press the "Log in" button
  Then  I should be on the profile page for "Kabir Bagai"
  And   I should see "Signed in successfully."
  When  I press the "Sign Out" button
  Then  I should be on the sign in page