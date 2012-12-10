class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.references :key
      t.references :left_field
      t.string :comparison
      t.string :data_type
      t.references :right_field
      t.string :right_value

      t.timestamps
    end
    add_index :conditions, :key_id
    add_index :conditions, :left_field_id
    add_index :conditions, :right_field_id
  end
end
