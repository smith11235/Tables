class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.references :data_set
      t.string :name

      t.timestamps
    end
    add_index :fields, :data_set_id
  end
end
