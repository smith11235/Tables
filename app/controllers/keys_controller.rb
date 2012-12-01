class KeysController < ApplicationController
	$key_index = 1 # what index in the main tab, todo: improve this

	# POST /keys
	# POST /keys.json
	def create
		@data_set = DataSet.find(params[:data_set_id])
		if params[:field_ids].nil?
			redirect_to( data_set_path( @data_set ), :notice => "Must select fields when creating a key" ) 
		else
			@key = @data_set.keys.create(params[:key])
			params[:field_ids].each do |field_id|
				field = @data_set.fields.where( :id => field_id )
				key_field = @key.key_fields.create 
				key_field.field_id = field_id
				key_field.save!
			end
			@key.set_records # create a key_record's index

			respond_to do |format|
				format.json { render json: @key } 
			end
		end
	end
	
	def find_records
		@data_set = DataSet.find(params[:data_set_id])
		@key = @data_set.keys.find(params[:id])
		@key.key_records.destroy_all # wipe out the current mappings
		@key.set_records # rebuild mappings
		redirect_to( data_set_path(@key.data_set), :tab_index => $key_index, :key_id => @key.id )
	end

	# GET /keys
	# GET /keys.json
	def index
		@keys = Key.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @keys }
		end
	end

	# GET /keys/1
	# GET /keys/1.json
	def show
		@data_set = DataSet.find(params[:data_set_id])
		@key = @data_set.keys.find(params[:id])

		table = KeyTable.new( @key )
		respond_to do |format|
			format.json { render json: table  } 
		end
	end

	# GET /keys/new
	# GET /keys/new.json
	def new
		@key = Key.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @key }
		end
	end

	# GET /keys/1/edit
	def edit
		@key = Key.find(params[:id])
	end


	# PUT /keys/1
	# PUT /keys/1.json
	def update
		@key = Key.find(params[:id])

		respond_to do |format|
			if @key.update_attributes(params[:key])
				format.html { redirect_to @key, notice: 'Key was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @key.errors, status: :unprocessable_entity }
			end
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
