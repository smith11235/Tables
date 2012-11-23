class Field < ActiveRecord::Base
	belongs_to :data_set
	has_many :cells
  attr_accessible :name
end
