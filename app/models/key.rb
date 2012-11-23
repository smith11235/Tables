class Key < ActiveRecord::Base
  belongs_to :data_set
  attr_accessible :name
	has_many :key_fields
end
