class AddSequentialIdToGroups < ActiveRecord::Migration[6.0]
    def change
      add_column :groups, :sequential_id, :integer
    end
  end
