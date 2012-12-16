class KeyTable

	def initialize( key, records_type )
		@table = Hash.new
		@table[ :columns ] = key.keyable.fields.collect { |field| { "sTitle" => field.name } }

		case records_type
		when nil # the matching records
			@title = "Minimal Records For Key: #{key.name}"
			@table[ :records ] = key.records.collect do |record|
				key.keyable.fields.collect do |field|
					record.get_cell( field ).string
				end
			end
		when 'not'
			@title = "Records Without Minimal Fields For Key: #{key.name}"
			@table[ :records ] = Array.new
			valid_record_ids = key.key_records.map(&:record_id)
			key.keyable.records.each do |record| # full record search
				if ! valid_record_ids.include? record.id 
					record_info = key.keyable.fields.collect {|field| record.get_cell( field ).string } 
					@table[:records] << record_info
				end
			end
		when 'valid'
			@title = "Conditional Key Records For: #{key.name}"
			@table[ :records ] = Array.new
			key.key_records.where( :status => 'valid' ).each do |key_record| 
				@table[:records] << key.keyable.fields.collect { |field| key_record.record.get_cell( field ).string } 
			end
		when 'invalid'
			@title = "Not Meeting Conditions For Key: #{key.name}"
			@table[ :records ] = Array.new
			key.key_records.where( "status != 'valid'" ).each do |key_record| 
				record_values = key.keyable.fields.collect { |field| key_record.record.get_cell( field ).string } 
				@table[:records] << record_values
			end
		when 'duplicate'
			@title = "Records With Duplicate Values In Their Key Fields For Key: #{key.name}"
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
