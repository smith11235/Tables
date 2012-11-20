class Field < ActiveRecord::Base
  belongs_to :data_set
  attr_accessible :name
end
