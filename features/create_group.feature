Feature: create new study group

  As a student
  So that I can efficiently communicate and collaborate with my classmates
  I want to create a study/project group


Background: students in database and logged in as Yuya Taniguchi

  Given the following students exist:
  | name           | email                 | email_old             | password  | bio      | instructor |
  | Kabir Bagai    | kb3343@columbia.edu   | kb3343@columbia.edu   | 123456789 | CS Major | false      |
  | Yuya Taniguchi | yt2749@columbia.edu   | yt2749@columbia.edu   | 123456789 | CS Major | false      |
  | Instructor     | instruct@columbia.edu | instruct@columbia.edu | 123456789 | CS Major | true       |


And the following courses exist:
  | name                | course_id   | course_code | max_group_size | semester | year | instructor_id |
  | AP                  | 3157        | COMS 3157   | 4              | Fall     | 2023 | 1             |

  And I am logged in with email "yt2749@columbia.edu" and password "123456789"
  And I am enrolled in "AP"


Scenario: successfully create new group 
  Given I am on the start page for "Yuya Taniguchi"
  When  I follow course link "AP"
  When  I follow "Create New Group"
  Then  I should be on the course page for "AP"
  And   I should see "1: Yuya"
  When  I follow my group link "1"
  Then  I should be on the group page for "1"
  And   I should see "Owner" before "Yuya"


Scenario: create more than one group
  Given I am on the profile page for "Yuya Taniguchi"
  When  I follow "AP" 
  Then  I should be on the course page for "AP"
  When  I follow "Create New Group"
  Then  I should be on the course page for "AP"
  When  I follow "Create New Group"
  Then  I should see "You cannot create more than one group in a course."


