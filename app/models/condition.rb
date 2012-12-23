class Condition < ActiveRecord::Base
	belongs_to :key
	belongs_to :left_field, :class_name => "Field"
	belongs_to :right_field, :class_name => "Field"
	attr_accessible :comparison, :data_type, :right_value

	def add_error_status( key_record, status )
		key_record.status << status
	end

	def valid_record?( key_record )
		# find the left cell, it should always be present
		left_cell = key_record.record.get_cell( self.left_field )
		if left_cell.field_id.nil?		
			add_error_status key_record, "[no left field: #{self.left_field.name}]"
		elsif ! left_cell.set_to_type( self.data_type )
			add_error_status key_record, "[cant convert #{left_cell.string} to #{self.data_type}]"
		end

		fake_right_cell = nil # using value or cell
		right_cell = if self.right_value # are we using a static comparison value
									 fake_right_cell = true # using value or cell
									 Cell.new( :string => self.right_value ) # default for right value
								 elsif self.right_field
									 cell = key_record.record.get_cell( self.right_field )
									 add_error_status key_record, "[no right field: #{self.right_field.name}]" if cell.field_id.nil?		
									 cell
								 else
									 raise "No Right Side Of Comparison"
								 end

		if ! right_cell.set_to_type( self.data_type )
			add_error_status key_record, "[cant convert #{right_cell.string} to #{self.data_type}]"
		end

		self.compare( left_cell, right_cell, key_record )

		# clean up temp cell if applicable
		right_cell.destroy if fake_right_cell # clean up temporary cell
	end

	def compare( left_cell, right_cell, key_record )
		left_value, right_value = self.get_cell_values( left_cell, right_cell )
		case self.comparison
		when '='
			add_error_status key_record, "[left and right not equal]" if left_value != right_value 
		when '<'
			add_error_status key_record, "[left not < right]" if left_value >= right_value
		when '>'
			add_error_status key_record, "[left not > right]" if left_value <= right_value
		when 'regex'
			add_error_status key_record, "[left !~ /right/i]" if left_value !~ /#{right_value}/i
		end
	end

	def get_cell_values( left_cell, right_cell )
		case self.data_type
		when 'datetime'
			return left_cell.datetime, right_cell.datetime
		when 'int'
			return left_cell.int, right_cell.int
		when 'float'
			return left_cell.float, right_cell.float
		when 'string'
			return left_cell.string, right_cell.string
		end
	end
end
