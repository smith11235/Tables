class CreateKeyFields < ActiveRecord::Migration
  def change
    create_table :key_fields do |t|
      t.references :key
      t.references :field

      t.timestamps
    end
    add_index :key_fields, :key_id
    add_index :key_fields, :field_id
  end
end
