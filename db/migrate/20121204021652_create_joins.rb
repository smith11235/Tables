class CreateJoins < ActiveRecord::Migration
  def change
    create_table :joins do |t|
      t.string :name
      t.references :left_key
      t.references :right_key

      t.timestamps
    end
    add_index :joins, :left_key_id
    add_index :joins, :right_key_id
  end
end
