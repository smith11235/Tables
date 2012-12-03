class KeyTable

	def initialize( key, records_type )
		@table = Hash.new
		@table[ :columns ] = key.data_set.fields.collect { |field| { "sTitle" => field.name } }

		case records_type
		when nil # the matching records
			@table[ :records ] = key.records.collect do |record|
				key.data_set.fields.collect do |field|
					record.get_cell( field ).string
				end
			end
		when 'not'
			@table[ :records ] = Array.new
			record_ids = key.records.map(&:id) # id's of records matching this key
			key.data_set.records.each do |record| # loop through all available
				if ! record_ids.include?( record.id )
					@table[ :records ] << key.data_set.fields.collect do |field|
						record.get_cell( field ).string
					end
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
