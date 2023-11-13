Feature: join a study group

  As a student
  I want to join a study/project group


Background: students in database and logged in as Yuya Taniguchi

  Given the following students exist:
  | name           | email               | email_old           | password  | bio      |
  | Kabir Bagai    | kb3343@columbia.edu | kb3343@columbia.edu | 123456789 | CS Major |
  | Yuya Taniguchi | yt2749@columbia.edu | yt2749@columbia.edu | 123456789 | CS Major |

  And the following courses exist:
  | name                | course_id   |
  | Engineering SaaS    | 4152        |
  | AP                  | 3157        |

  And the following enrollments exist:
  | student_id | course_id |
  | 1          | 2         |
  | 2          | 2         |

  And the following groups exist:
  | group_id | course_id | group_owner_id |
  | 1        | 2         | 1              |

  And I am logged in with email "yt2749@columbia.edu" and password "123456789"

  Then 1 seed groups should exist


Scenario: send a join request
  Given I am on the profile page for "Yuya Taniguchi"
  When  I follow "AP" 
  Then  I should be on the course page for "AP"
  When  I follow class group link "1"
  Then  I should be on the group page for "1"
  And   I should see "Owner: Kabir"
  When  I follow "Request to Join Group"
  Then  I should see "Requested to Join"
