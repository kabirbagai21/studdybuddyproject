class CreateMergeGroupRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :merge_group_requests do |t|
      t.references :group_requesting, null: false, foreign_key: { to_table: :groups }
      t.references :group_to_merge, null: false, foreign_key: { to_table: :groups }
      t.references :course, null: false, foreign_key: true
      t.timestamps
    end
  end
end
