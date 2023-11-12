Feature: delete my group

  As a student
  I want to be able to delete a study/project group


Background: students in database and logged in as Yuya Taniguchi

  Given the following students exist:
  | name           | email               | email_old           | password  | bio      |
  | Kabir Bagai    | kb3343@columbia.edu | kb3343@columbia.edu | 123456789 | CS Major |
  | Yuya Taniguchi | yt2749@columbia.edu | yt2749@columbia.edu | 123456789 | CS Major |

  And the following courses exist:
  | name                | course_id   |
  | Engineering SaaS    | 4152        |
  | AP                  | 3157        |

  And I am logged in with email "yt2749@columbia.edu" and password "123456789"
  And I am enrolled in "4152"


Scenario: delete my group
  Given I am on the profile page for "Yuya Taniguchi"
  When  I follow "Engineering SaaS" 
  Then  I should be on the course page for "Engineering SaaS"
  When  I follow "Create New Group"
  Then  I should be on the course page for "Engineering SaaS"
  And   I should see "My Groups" before "1"
  And   I should see "1" before "Class Groups"
  When  I follow my group link "1"
  Then  I should be on the group page for "1"
  And   I should see "Owner: Yuya"
  When  I press the "Delete Group" button
  Then  I should be on the course page for "Engineering SaaS"
  And   I should see "Group deleted successfully."
  And   I should not see "1"