class Group < ApplicationRecord
  #before_create :set_group_id
  before_create :set_sequential_id # New method for setting sequential_id
  after_destroy :reassign_sequential_ids # New method for recalculating sequential_id after a group is destroyed

  belongs_to :course

  # Group-student association
  has_many :group_members
  has_many :students, through: :group_members

  # Group-request association
  has_many :group_requests, dependent: :destroy
  has_many :requesting_students, through: :group_requests, source: :student

  # Merge Group-request association
  has_many :merge_group_requests, foreign_key: :group_to_merge_id, dependent: :destroy
  has_many :requesting_groups, through: :merge_group_requests, source: :group_requesting

  has_many :merge_group_requests_as_target, foreign_key: :group_requesting_id, class_name: 'MergeGroupRequest', dependent: :destroy
  has_many :requested_groups, through: :merge_group_requests_as_target, source: :group_to_merge

  # Validation to ensure one group per student
  validate :one_group_per_student, on: :create

  attr_accessor :destroyed_for_merge # New attribute to track if destruction is for merge

  private

  # Automatically sets a unique group ID before creating a new group
  def set_group_id
    last_group_id = self.class.maximum(:group_id) || 0
    self.group_id = last_group_id + 1
  end

  # Sets a sequential ID for new groups
  def set_sequential_id
    max_sequential_id = Group.maximum(:sequential_id) || 0
    self.sequential_id = max_sequential_id + 1
  end

  # Recalculates sequential IDs for remaining groups after a group is destroyed
  def reassign_sequential_ids
    Group.where('sequential_id > ?', self.sequential_id).order(:sequential_id).each_with_index do |group, index|
      group.update_column(:sequential_id, index + 1)
    end
  end

  # Validation method to check if a student already owns a group
  def one_group_per_student
    if Group.where(group_owner_id: group_owner_id, course_id: course_id).exists?
      errors.add(:group_owner_id, "can't create more than one group")
    end
  end
end
