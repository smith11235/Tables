class KeyTable

	def initialize( key, records_type )
		@table = Hash.new
		@table[ :columns ] = key.keyable.fields.collect { |field| { "sTitle" => field.name } }
		@title = "<h2>Key: #{key.name}</h2><br />"
		case records_type
		when 'not'
			@title << "Records Missing Core Key Fields"
			@table[ :records ] = Array.new
			valid_record_ids = key.key_records.map(&:record_id)
			key.keyable.records.each do |record| # full record search
				if ! valid_record_ids.include? record.id 
					record_info = key.keyable.fields.collect {|field| record.get_cell( field ).string } 
					@table[:records] << record_info
				end
			end
		when 'valid'
			@title << "Passing All Conditions"
			@table[ :records ] = Array.new
			key.key_records.where( :status => 'valid' ).each do |key_record| 
				@table[:records] << key.keyable.fields.collect { |field| key_record.record.get_cell( field ).string } 
			end
		when 'invalid'
			@title << "Failed Meeting Conditions For"
			@table[ :records ] = Array.new
			key.key_records.where( "status != 'valid'" ).each do |key_record| 
				record_values = Array.new
				key.keyable.fields.collect do |field| 
					record_values << key_record.record.get_cell( field ).string 
				end
				@table[:records] << record_values
			end
		when 'duplicate'
			@title << "Duplicate Values In Key Fields"
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
			:columns => @table[:columns],
			:title => @title
		}
	end

end
