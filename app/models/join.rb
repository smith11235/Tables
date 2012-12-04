class Join < ActiveRecord::Base
  belongs_to :left_key
  belongs_to :right_key
  attr_accessible :name
end
