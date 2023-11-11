class Course < ApplicationRecord
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :groups, dependent: :destroy #ensures that when a course is deleted, all associated groups are also automatically deleted
end
