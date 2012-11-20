class Record < ActiveRecord::Base
  belongs_to :data_set
  # attr_accessible :title, :body
end
