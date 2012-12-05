class Join < ActiveRecord::Base
  attr_accessible :name
	belongs_to :left_key, :class_name => "Key"
	belongs_to :right_key, :class_name => "Key"
end
