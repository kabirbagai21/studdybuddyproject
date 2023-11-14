class GroupRequest < ApplicationRecord
  belongs_to :student
  belongs_to :group
  belongs_to :course, optional: true

  validates :student_id, presence: true
  validates :group_id, presence: true

  def request_status

    status || 'pending'
  end
end
