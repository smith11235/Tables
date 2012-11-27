class KeyRecord < ActiveRecord::Base
  belongs_to :key
  belongs_to :record
  # attr_accessible :title, :body
end
