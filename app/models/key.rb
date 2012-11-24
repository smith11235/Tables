class Key < ActiveRecord::Base
	belongs_to :data_set
	attr_accessible :name
	has_many :key_fields

	def get_records
		records = Hash.new
		# for each record in the data set
		self.data_set.records.each do |record|
			has_all_fields = true
			pk_value = ""
			# make sure it has all the required fields
			self.key_fields.each do |key_field|
				next unless has_all_fields
				cell = record.get_cell( key_field.field )	
				if cell.field_id.nil? # make sure it's a valid cell
					has_all_fields = false 
				else
					# build pk value
					pk_value << "[#{cell.string}]"
				end
			end
			records[ pk_value ] ||= Array.new
			records[ pk_value ] << record
		end
		return records
	end

end
