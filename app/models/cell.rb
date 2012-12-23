class Cell < ActiveRecord::Base
  belongs_to :record
  belongs_to :field
  attr_accessible :datetime, :float, :int, :string

	def set_to_type( type )
		case type
		when 'datetime'
			self.datetime = self.string
		when 'float'
			return false unless self.string =~ /^\d*\.?\d+$/
			self.float = self.string
		when 'int'
			return false unless self.string =~ /^\d+$/
			self.int = self.string
		end
		return self.save
	end

end
