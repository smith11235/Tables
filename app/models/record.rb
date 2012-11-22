class Record < ActiveRecord::Base
  belongs_to :data_set
	has_many :cells

	def get_cell( field )
		populate_fields_hash
		return @fields_hash.has_key?( field ) ? @fields_hash[ field ] : Cell.new
	end	

	def populate_fields_hash
		return if @fields_hash
		@fields_hash = Hash.new
		self.cells.each do |cell|
		  @fields_hash[ cell.field ] = cell	
		end
	end	
end
