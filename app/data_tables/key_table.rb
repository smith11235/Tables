class KeyTable
	delegate :params, :h, to: :@view

	def initialize(view,key)
		@view = view
		@key = key
		@display_records = @key.records

		search # todo: build a join query

		sort_records # todo: multi field sorting
	end

	def search
		if params[:sSearch].present? && params[:sSearch].size > 0
			temp_records = []
			@display_records.map do |record|
				wanted = false
				@key.data_set.fields.map do |field| 
					value = record.get_cell( field ).string.to_s
					wanted = true if value.size > 1 && value =~ /#{params[:sSearch]}/i
				end
				temp_records << record if wanted
			end
			@display_records = temp_records
		end
	end

	def as_json(options = {})
		{
			sEcho: params[:sEcho].to_i,
			iTotalRecords: @key.records.size,
			iTotalDisplayRecords: @display_records.size,
			aaData: get_data
		}
	end

	private

	def get_data
		# format data for javascript
		@display_records.map do |record|
			@key.data_set.fields.map do |field| 
				h(record.get_cell( field ).string)
			end
		end
	end

	def sort_records
		if params[:iSortCol_0].present?
			sort_field = @key.data_set.fields[ params[:iSortCol_0].to_i ]

			cell_values = Hash.new
			# gather the values to be sorted, and their corresponding record indecies 
			@display_records.each_with_index do |record,i|
				cell_value = record.get_cell( sort_field ).string
				cell_values[ cell_value ] ||= Array.new
				cell_values[ cell_value ] << i
			end

			temp_records = [] 
			sorted_cell_values = (cell_values.keys - [nil]).sort # sort them
			# write them in order
			sorted_cell_values.each do |cell_value|
				cell_values[ cell_value ].each do |index|
					temp_records << @display_records[ index ]
				end
			end
			# add the nill values to the end
			if cell_values.has_key? nil
				cell_values[ nil ].each do |index|
					temp_records << @display_records[ index ]
				end
			end

			@display_records = temp_records
			# check if reversing is needed
			@display_records.reverse! if params[:sSortDir_0] == "desc" 
		end
	end

end
