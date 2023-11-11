class Course < ApplicationRecord
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :groups
  has_many :group_requests
end
