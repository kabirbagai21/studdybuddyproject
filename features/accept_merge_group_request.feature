Feature: accept merge group request

  As a student
  I want to accept a merge group request


Background: students in database and logged in as Yuya Taniguchi

  Given the following students exist:
  | name           | email               | email_old           | password  | bio      |
  | Kabir Bagai    | kb3343@columbia.edu | kb3343@columbia.edu | 123456789 | CS Major |
  | Yuya Taniguchi | yt2749@columbia.edu | yt2749@columbia.edu | 123456789 | CS Major |

And the following courses exist:
  | name                | course_id   | course_code | max_group_size | semester | year | instructor_id |
  | AP                  | 3157        | COMS 3157   | 4              | Fall     | 2023 | 1             |

  And the following enrollments exist:
  | student_id | course_id |
  | 1          | 1        |
  | 2          | 1        |

  And the following groups exist:
  | group_id | course_id | group_owner_id |
  | 1        | 1         | 1              |
  | 2        | 1         | 2              |

  And the following group members exist:
  | student_id | group_id |
  | 1          | 1        |
  | 2          | 2        |

  And the following merge group requests exist:
  | group_requesting_id | group_to_merge_id | course_id |
  | 1                   | 2                 | 1         |

  And I am logged in with email "yt2749@columbia.edu" and password "123456789"


Scenario: accept a merge group request
  Given I am on the profile page for "Yuya Taniguchi"
  When  I follow "AP" 
  Then  I should be on the course page for "AP"
  When  I follow my group link "2"
  Then  I should be on the group page for "2"
  And   I should see "Request from 1: Kabir"
  When  I press "Approve Merge Request"
  Then  I should see "Group: 1"
  And   I should see "Enrollment: 2/4"