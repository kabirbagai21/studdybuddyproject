class RenameGroupsStudentsToGroupMembers < ActiveRecord::Migration[7.1]
  def change
    rename_table :groups_students, :group_members
  end
end
