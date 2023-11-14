Feature: sign in to StudyBuddy page

  As a student
  So that I can access my class and enrollment info
  I want to sign in to the StudyBuddy page


Background: students in database

  Given the following students exist:
  | name           | email               | email_old           | password  | bio      |
  | Kabir Bagai    | kb3343@columbia.edu | kb3343@columbia.edu | 123456789 | CS Major |
  | Yuya Taniguchi | yt2749@columbia.edu | yt2749@columbia.edu | 123456789 | CS Major |

  And I am on the sign in page
  Then 2 seed students should exist


Scenario: correct login
  Given I am on the sign in page
  When  I fill in "Email" with "kb3343@columbia.edu"
  And   I fill in "Password" with "123456789"
  And   I press the "Log in" button
  Then  I should be on the start page for "Kabir Bagai"
  And   I should see "Signed in successfully."
  And   I should see "Kabir"

Scenario: incorrect login  
  Given I am on the sign in page
  When  I fill in "Email" with "yt2749@columbia.edu"
  When  I fill in "Password" with "1234567890"
  And   I press the "Log in" button
  Then  I should be on the sign in page
  And   I should see "Log in"
  But   I should not see "Yuya Taniguchi"