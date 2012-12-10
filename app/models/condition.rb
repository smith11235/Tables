class Condition < ActiveRecord::Base
  belongs_to :key
  belongs_to :left_field
  belongs_to :right_field
  attr_accessible :comparison, :data_type, :right_value
end
