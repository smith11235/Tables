class CreateDataSets < ActiveRecord::Migration
  def change
    create_table :data_sets do |t|
      t.string :name
      t.string :parameters
      t.string :checksum
      t.string :source

      t.timestamps
    end
  end
end
