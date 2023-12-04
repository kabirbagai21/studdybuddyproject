class AddCourseInfoToCourse < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :year, :integer
    add_column :courses, :section, :string
    add_column :courses, :semester, :string
  end
end
