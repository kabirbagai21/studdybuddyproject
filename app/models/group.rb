class Group < ApplicationRecord
  before_create :set_group_id
  belongs_to :course

  #belongs_to :group_owner, class_name: 'Student'
  #has_and_belongs_to_many :students

  #Group-student association
  has_many :group_members
  has_many :students, through: :group_members

  def set_group_id
    last_group_id = self.class.maximum(:group_id) || 0
    self.group_id = last_group_id + 1
  end



end
