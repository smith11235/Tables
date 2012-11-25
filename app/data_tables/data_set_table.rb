class DataSetTable
	delegate :params, :h, to: :@view

	def initialize(view,data_set)
		@view = view
		@data_set = data_set
		@display_records = @data_set.records

		if params[:sSearch].present?
			temp_records = []
			@display_records.map do |record|
				wanted = false
				@data_set.fields.map do |field| 
					wanted = true if record.get_cell( field ).string =~ /#{params[:sSearch]}/i
				end
				temp_records << record if wanted
			end
			@display_records = temp_records
		end
	end

	def as_json(options = {})
		{
			sEcho: params[:sEcho].to_i,
			iTotalRecords: @data_set.records.size,
			iTotalDisplayRecords: @data_set.records.size,
			aaData: get_data
		}
	end

	private

	def get_data
		@display_records.map do |record|
			@data_set.fields.map do |field| 
				h(record.get_cell( field ).string)
			end
		end
	end

end
