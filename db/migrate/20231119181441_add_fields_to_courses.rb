class AddFieldsToCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :course_code, :string
    add_column :courses, :max_group_size, :integer, null: false, default: 4
    add_reference :courses, :instructor, foreign_key: { to_table: :students }
  end
end
