class KeyField < ActiveRecord::Base
  belongs_to :key
  belongs_to :field
  # attr_accessible :title, :body
end
