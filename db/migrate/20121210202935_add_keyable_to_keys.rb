class AddKeyableToKeys < ActiveRecord::Migration
  def change
    add_column :keys, :keyable_id, :integer
    add_column :keys, :keyable_type, :string
  end
end
