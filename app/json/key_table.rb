class KeyTable

	def initialize( key, records_type )
		@table = Hash.new
		@table[ :columns ] = key.keyable.fields.collect { |field| { "sTitle" => field.name } }

		case records_type
		when nil # the matching records
			@table[ :records ] = key.valid_records.collect do |record|
				key.keyable.fields.collect do |field|
					record.get_cell( field ).string
				end
			end
		when 'not'
			@table[ :records ] = key.get_not_records.collect do |record|
				key.keyable.fields.collect do |field|
					record.get_cell( field ).string
				end
			end
		when 'duplicate'
			@table[ :records ] = key.get_duplicate_records.collect do |record|
				key.keyable.fields.collect do |field|
					record.get_cell( field ).string
				end
			end
		else 
			raise "Could not find records type: #{records_type}"
		end

	end

	def as_json(options = {})
		{
			:records => @table[:records],
			:columns => @table[:columns]
		}
	end

end
