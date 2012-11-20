class DataSet < ActiveRecord::Base
  attr_accessible :checksum, :name, :parameters, :source
end
