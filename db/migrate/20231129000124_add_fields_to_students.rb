class AddFieldsToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :linked_in_profile, :string, null: true
    add_column :students, :facebook_profile, :string, null: true
    add_column :students, :personal_website, :string, null: true
    add_column :students, :github_profile, :string, null: true
    add_column :students, :skills, :string, null: true
    add_column :students, :address, :string, null: true
  end
end
