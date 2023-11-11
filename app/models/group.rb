class Group < ApplicationRecord
  
  before_create :set_group_id
  belongs_to :course

  #Group-student association
  has_many :group_members
  has_many :students, through: :group_members

  #Group-request association
  has_many :group_requests
  has_many :requesting_students, through: :group_requests, source: :student


  def set_group_id
    last_group_id = self.class.maximum(:group_id) || 0
    self.group_id = last_group_id + 1
  end



end
