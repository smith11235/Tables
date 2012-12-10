class DataSetsController < ApplicationController

	# GET /data_sets/1
	# GET /data_sets/1.json
	def show
		@jquery = InitHelper.new( gon )

		# load the target dataset
		@data_set = DataSet.find(params[:id])

		# get the other revisions of this table
		@revisions = []
		DataSet.where( :name => @data_set.name, :parameters => @data_set.parameters ).order( "created_at DESC" ).each do |revision|
			if revision.id != @data_set.id
				@revisions << revision
			end
		end
		
		gon.table = Table.new( @data_set ) # this is for the initial load
		respond_to do |format|
			format.json { render json: gon.table } 
			format.html # show.html.erb
		end
	end

	# GET /data_sets
	# GET /data_sets.json
	def index
		@jquery = InitHelper.new( gon )
		@data_sets = DataSet.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @data_sets }
		end
	end


	# GET /data_sets/new
	# GET /data_sets/new.json
	def new
		@data_set = DataSet.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @data_set }
		end
	end

	# GET /data_sets/1/edit
	def edit
		@data_set = DataSet.find(params[:id])
	end

	# POST /data_sets
	# POST /data_sets.json
	def create
		@data_set = DataSet.new(params[:data_set])

		respond_to do |format|
			if @data_set.save
				format.html { redirect_to @data_set, notice: 'Data set was successfully created.' }
				format.json { render json: @data_set, status: :created, location: @data_set }
			else
				format.html { render action: "new" }
				format.json { render json: @data_set.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /data_sets/1
	# PUT /data_sets/1.json
	def update
		@data_set = DataSet.find(params[:id])

		respond_to do |format|
			if @data_set.update_attributes(params[:data_set])
				format.html { redirect_to @data_set, notice: 'Data set was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @data_set.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /data_sets/1
	# DELETE /data_sets/1.json
	def destroy
		@data_set = DataSet.find(params[:id])
		@data_set.destroy

		respond_to do |format|
			format.html { redirect_to data_sets_url }
			format.json { head :no_content }
		end
	end
end
