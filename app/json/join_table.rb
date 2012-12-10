class JoinTable

	def initialize( join )
		@join = join
		@table = Hash.new
		@table[ :columns ] = Array.new
		@join.left_key.data_set.fields.each { |field| @table[:columns] << { "sTitle" => "left.#{field.name}" } }
		@table[ :columns ] << { "sTitle" => "left.record_id" }
		@table[ :columns ] << { "sTitle" => "right.record_id" }
		@join.right_key.data_set.fields.each { |field| @table[:columns] << { "sTitle" => "right.#{field.name}" } }

		@table[ :records ] = Array.new
		find_records
	end

	def find_records
		records = Hash.new
		@join.left_key.key_records.each do |left_key_record|
			@join.right_key.key_records.each do |right_key_record|
			  				
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

