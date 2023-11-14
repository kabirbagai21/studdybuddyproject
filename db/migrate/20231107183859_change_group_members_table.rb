class ChangeGroupMembersTable < ActiveRecord::Migration[7.1]
  def change
    change_table :group_members do |t|
      t.remove_references :group
      t.remove_references :student
      t.references :student, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
    end
  end
end
