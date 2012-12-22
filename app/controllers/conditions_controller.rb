class ConditionsController < ApplicationController

	# POST /conditions
	# POST /conditions.json
	def create
		@condition = Condition.new 
		@condition.key = Key.find( params[:key_id] )
		raise "Invalid Key Id: #{params[:key_id]}" if @condition.key.nil?

		left_field = Field.find( params[:condition][:left_field] )
		raise "invalide left field id: #{params[:condition][:left_field]}" if left_field.nil?
		@condition.left_field = left_field
		@condition.comparison = params[:condition][:comparison]
		@condition.data_type = params[:condition][:data_type]
		if params[:condition][:right_field] =~ /\d+/
			right_field = Field.find( params[:condition][:right_field] )
			raise "invalide right field id: #{params[:condition][:right_field]}" if right_field.nil?
			@condition.right_field = right_field 
		elsif params[:condition][:right_value] =~ /.+/
			@condition.right_value = params[:condition][:right_value]
		else
			raise "Missing 'right' side"
		end

		@condition.save!

		@condition.key.reindex_records

		respond_to do |format|
			format.json { render json: 
				{ 'html' => render_to_string( :partial =>"condition.html.erb",:locals =>{:condition=>@condition} ),
					'key_id' => @condition.key.id,
					'table' => KeyTable.new( @condition.key, 'valid' )
			} 
			}
		end
	end

	# DELETE /conditions/1
	# DELETE /conditions/1.json
	def destroy
		@condition = Condition.find(params[:id])
		@condition.destroy

		respond_to do |format|
			format.html { redirect_to conditions_url }
			format.json { head :no_content }
		end
	end
end
