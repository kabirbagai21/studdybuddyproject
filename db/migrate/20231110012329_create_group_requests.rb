class CreateGroupRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :group_requests do |t|
      t.references :student, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
