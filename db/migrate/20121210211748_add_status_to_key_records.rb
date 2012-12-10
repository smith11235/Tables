class AddStatusToKeyRecords < ActiveRecord::Migration
  def change
    add_column :key_records, :status, :string
  end
end
