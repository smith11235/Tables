class Condition < ActiveRecord::Base
  belongs_to :key
  belongs_to :left_field, :class_name => "Field"
  belongs_to :right_field, :class_name => "Field"
  attr_accessible :comparison, :data_type, :right_value
end
