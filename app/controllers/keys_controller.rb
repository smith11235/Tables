class KeysController < ApplicationController
	$key_index = 1 # what index in the main tab, todo: improve this

	# POST /keys
	# POST /keys.json
	def create
		@jquery = InitHelper.new( gon )
		@keyable = DataSet.find(params[:data_set_id])

		if params[:field_ids].nil?
			raise "Must select fields when creating a key" 
		else
			@key = @keyable.keys.create(params[:key])
			params[:field_ids].each do |field_id|
				field = @keyable.fields.where( :id => field_id )
				key_field = @key.key_fields.create 
				key_field.field_id = field_id
				key_field.save!
			end
			@key.set_records # create a key_record's index

			respond_to do |format|
				format.json { render json: { 'key_id' => @key.id, 'html' => render_to_string( :partial =>"key.html.erb",:locals =>{:key=>@key} )  } }
			end
		end
	end

	# GET /keys/1
	# GET /keys/1.json
	def show
		@data_set = DataSet.find(params[:data_set_id])
		@key = @data_set.keys.find(params[:id])

		records_type = params[:records_type] 
		table = KeyTable.new( @key, records_type )
		respond_to do |format|
			format.json { render json: table  } 
		end
	end

	# DELETE /keys/1
	# DELETE /keys/1.json
	def destroy
		@key = Key.find(params[:id])
		@key.destroy

		respond_to do |format|
			format.json { head :no_content }
		end
	end
end
