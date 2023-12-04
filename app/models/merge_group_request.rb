class MergeGroupRequest < ApplicationRecord
    belongs_to :group_requesting, class_name: 'Group'
    belongs_to :group_to_merge, class_name: 'Group'
    belongs_to :course
end