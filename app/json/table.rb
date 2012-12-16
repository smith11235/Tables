class Table

	def initialize( data_set )
		@table = Hash.new
		@table[ :columns ] = data_set.fields.collect { |field| { "sTitle" => field.name } }
		@table[ :records ] = data_set.records.collect do |record|
			data_set.fields.collect do |field|
				record.get_cell( field ).string
			end
		end
	end

	def as_json(options = {})
		{
			:title => 'All Records',
			:records => @table[:records],
			:columns => @table[:columns]
		}
	end

end

