Feature: sign up for StudyBuddy

  As a student
  So that I can create an account to access my class and enrollment info
  I want to sign up for StudyBuddy


Background: students in database

  Given the following students exist:
  | name           | email               | email_old           | password  | bio      |
  | Kabir Bagai    | kb3343@columbia.edu | kb3343@columbia.edu | 123456789 | CS Major |
  | Kabir Bagai    | yt2749@columbia.edu | yt2749@columbia.edu | 123456789 | CS Major |

  And I am on the sign in page
  Then 2 seed students should exist


Scenario: correct sign up
  Given I am on the sign in page
  When  I follow "Sign up"
  Then  I should be on the sign up page
  When  I fill in "Name" with "Yuya Taniguchi"
  And   I fill in "Email" with "yt27828@columbia.edu"
  And   I fill in "Password" with "123456789"
  And   I fill in "Password confirmation" with "123456789"
  And   I press the "Sign up" button
  Then  I should be on the start page for "Yuya Taniguchi"
  And   I should see "Welcome! You have signed up successfully."

Scenario: email taken on sign up  
  Given I am on the sign in page
  When  I follow "Sign up"
  Then  I should be on the sign up page
  When  I fill in "Email" with "yt2749@columbia.edu"
  And   I fill in "Password" with "123456789"
  And   I fill in "Password confirmation" with "123456789"
  And   I press the "Sign up" button
  Then  I should see "Email has already been taken"

Scenario: blank password  
  Given I am on the sign in page
  When  I follow "Sign up"
  Then  I should be on the sign up page
  When  I fill in "Email" with "yuya@gmail.com"
  And   I press the "Sign up" button
  Then  I should see "Password can't be blank"

Scenario: password too short
  Given I am on the sign in page
  When  I follow "Sign up"
  Then  I should be on the sign up page
  When  I fill in "Email" with "yuya@gmail.com"
  And   I fill in "Password" with "123"
  And   I fill in "Password confirmation" with "123"
  And   I press the "Sign up" button
  Then  I should see "Password is too short (minimum is 6 characters)"

Scenario: email taken on sign up and blank password  
  Given I am on the sign in page
  When  I follow "Sign up"
  Then  I should be on the sign up page
  When  I fill in "Email" with "yt2749@columbia.edu"
  And   I press the "Sign up" button
  Then  I should see "Email has already been taken"
  And   I should see "Password can't be blank"