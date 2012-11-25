class DataSetsController < ApplicationController

	class JQueryUIsTracker
		def initialize( gon )
			@gon = gon
			@gon.jquery_uis = Hash.new
		end

		def set_id( id, type, settings = {} )
			@gon.jquery_uis[ type ] ||= Hash.new
			if settings.size == 0 # set defaults?
				case type
				when :tabs
					settings.reverse_merge! 'collapsible' => true, 'heightStyle' => "content"
				when :accordion
					settings.reverse_merge!	'collapsible' => true, 'heightStyle' => 'content', 'active' => false
				when :data_table
					settings.reverse_merge!	'sPaginationType' => 'full_numbers',  'bJQueryUI' => true 
				end
			end
			@gon.jquery_uis[ type ][ id ] = settings 
			return "id=#{id}"
		end
	end

	# GET /data_sets/1
	# GET /data_sets/1.json
	def show
		@jquery = JQueryUIsTracker.new( gon )

		# load the target dataset
		@data_set = DataSet.find(params[:id])

		# get the other revisions of this table
		@revisions = []
		DataSet.where( :name => @data_set.name, :parameters => @data_set.parameters ).order( "created_at DESC" ).each do |revision|
			if revision.id != @data_set.id
				@revisions << revision
			end
		end

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @data_set }
		end
	end

	# GET /data_sets
	# GET /data_sets.json
	def index
		@jquery = JQueryUIsTracker.new( gon )
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
