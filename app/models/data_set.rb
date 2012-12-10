class DataSet < ActiveRecord::Base
  attr_accessible :checksum, :name, :parameters, :source
	has_many :records
	has_many :fields
	has_many :keys, :as => :keyable
end
