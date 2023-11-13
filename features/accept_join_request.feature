Feature: accept a join request

  As a student
  I want to accept a join request for my study/project group


Background: students in database and logged in as Kabir Bagai

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

  And the following group requests exist:
  | student_id | course_id | group_id |
  | 2          | 2         | 1        |

  And I am logged in with email "kb3343@columbia.edu" and password "123456789"

  Then 1 seed groups should exist


Scenario: accept a join request
  Given I am on the start page for "Kabir Bagai"
  When  I follow "AP" 
  Then  I should be on the course page for "AP"
  When  I follow my group link "1"
  Then  I should be on the group page for "1"
  When  I press the "Approve Request" button
  Then  I should be on the group page for "1"
  And   I should see "Yuya" before "Requests:"

