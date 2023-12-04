class AddSequentialIdToGroups < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :sequential_id, :integer
  end
end
