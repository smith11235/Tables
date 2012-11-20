class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.references :record
      t.references :field
      t.string :string
      t.datetime :datetime
      t.int :int
      t.float :float

      t.timestamps
    end
    add_index :cells, :record_id
    add_index :cells, :field_id
  end
end
