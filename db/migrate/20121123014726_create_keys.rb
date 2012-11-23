class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :name
      t.references :data_set

      t.timestamps
    end
    add_index :keys, :data_set_id
  end
end
