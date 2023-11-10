class RenameEmailToEmailOldInStudents < ActiveRecord::Migration[7.1]
  def change
    rename_column :students, :email, :email_old
  end
end
