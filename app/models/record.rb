class Record < ActiveRecord::Base
  belongs_to :data_set
	has_many :cells
end
