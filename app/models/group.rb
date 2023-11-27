class Group < ApplicationRecord
  
  before_create :set_group_id
  belongs_to :course

  #Group-student association
  has_many :group_members
  has_many :students, through: :group_members

  #Group-request association
  has_many :group_requests, dependent: :destroy
  has_many :requesting_students, through: :group_requests, source: :student

  #Merge Group-request association
  has_many :merge_group_requests, foreign_key: :group_to_merge_id , dependent: :destroy
  has_many :requesting_groups, through: :merge_group_requests, source: :group_requesting

  has_many :merge_group_requests_as_target, foreign_key: :group_requesting_id, class_name: 'MergeGroupRequest', dependent: :destroy
  has_many :requested_groups, through: :merge_group_requests_as_target, source: :group_to_merge


  # Validation to ensure one group per student
  validate :one_group_per_student, on: :create

  private

  # Automatically sets a unique group ID before creating a new group
  def set_group_id
    last_group_id = self.class.maximum(:group_id) || 0
    self.group_id = last_group_id + 1
  end

  # Validation method to check if a student already owns a group
  def one_group_per_student
    if Group.where(group_owner_id: group_owner_id, course_id: course_id).exists?
      errors.add(:group_owner_id, "can't create more than one group")
    end
  end

end
