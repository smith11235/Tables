class KeyTable

	def initialize( key )
		@table = Hash.new
		@table[ :columns ] = key.data_set.fields.collect { |field| { "sTitle" => field.name } }
		@table[ :records ] = key.records.collect do |record|
			key.data_set.fields.collect do |field|
				record.get_cell( field ).string
			end
		end
	end

	def as_json(options = {})
		{
			:records => @table[:records],
			:columns => @table[:columns]
		}
	end

end
