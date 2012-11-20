class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :data_set

      t.timestamps
    end
    add_index :records, :data_set_id
  end
end
