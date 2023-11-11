class AddCourseReferenceToGroupRequests < ActiveRecord::Migration[7.1]
  def change
    add_reference :group_requests, :course, null: false, foreign_key: true
  end
end
