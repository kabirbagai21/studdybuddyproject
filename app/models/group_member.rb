class GroupMember < ApplicationRecord
    belongs_to :student
    belongs_to :group
end