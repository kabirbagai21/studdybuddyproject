class GroupRequest < ApplicationRecord
  belongs_to :student
  belongs_to :group
  belongs_to :course, optional: true
end
