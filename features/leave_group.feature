Feature: leave class group

  As a student
  I want to be able to leave a study/project group


Background: students in database and logged in as Yuya Taniguchi

  Given the following students exist:
  | name           | email               | email_old           | password  | bio      |
  | Kabir Bagai    | kb3343@columbia.edu | kb3343@columbia.edu | 123456789 | CS Major |
  | Yuya Taniguchi | yt2749@columbia.edu | yt2749@columbia.edu | 123456789 | CS Major |

And the following courses exist:
  | name                | course_id   | course_code | max_group_size | semester | year | instructor_id |
  | AP                  | 3157        | COMS 3157   | 4              | Fall     | 2023 | 1             |

  And I am logged in with email "yt2749@columbia.edu" and password "123456789"
  And I am enrolled in "AP"


Scenario: leave my group
  Given I am on the profile page for "Yuya Taniguchi"
  When  I follow "AP" 
  Then  I should be on the course page for "AP"
  When  I follow "Create New Group"
  Then  I should be on the course page for "AP"
  And   I should see "My Groups" before "1"
  And   I should see "1" before "Class Groups"
  When  I follow my group link "1"
  Then  I should be on the group page for "1"
  And   I should see "Owner" before "Yuya"
  When  I press the "Leave Group" button
  Then  I should be on the course page for "AP"
  And   I should not see "1: Yuya"
  And   I should not see "Group deleted successfully."