class CreateGroupsStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :groups_students, id: false do |t|
      t.belongs_to :group
      t.belongs_to :student
      t.timestamps
    end
  end
end