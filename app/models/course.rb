class Course < ApplicationRecord
  before_create :set_course_id
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :groups, dependent: :destroy #ensures that when a course is deleted, all associated groups are also automatically deleted
  has_many :group_requests, dependent: :destroy
  has_many :merge_group_requests, dependent: :destroy

  validates_uniqueness_of :name, scope: [:section, :instructor_id], message: 'This class and section already exist for the instructor.'

  private 

  def set_course_id 
    begin
      rand_course_id = rand(100000..999999)
    end while Course.exists?(course_id: rand_course_id)
    self.course_id = rand_course_id
  end

end
