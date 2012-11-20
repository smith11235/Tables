class Cell < ActiveRecord::Base
  belongs_to :record
  belongs_to :field
  attr_accessible :datetime, :float, :int, :string
end
