class AddGroupOwnerToGroupsTable < ActiveRecord::Migration[7.1]
  def change
    add_reference :groups, :group_owner, foreign_key: { to_table: :students }
  end
end
