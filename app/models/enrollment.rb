class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :course
  validates :student_id, uniqueness: { scope: :course_id, message: "should happen once per course" }
end
