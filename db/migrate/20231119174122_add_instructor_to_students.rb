class AddInstructorToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :instructor, :boolean
  end
end
