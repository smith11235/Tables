class CreateKeyRecords < ActiveRecord::Migration
  def change
    create_table :key_records do |t|
      t.references :key
      t.references :record

      t.timestamps
    end
    add_index :key_records, :key_id
    add_index :key_records, :record_id
  end
end
