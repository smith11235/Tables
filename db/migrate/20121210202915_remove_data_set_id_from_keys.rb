class RemoveDataSetIdFromKeys < ActiveRecord::Migration
  def up
    remove_column :keys, :data_set_id
  end

  def down
    add_column :keys, :data_set_id, :integer
  end
end
