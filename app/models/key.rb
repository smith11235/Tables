class Key < ActiveRecord::Base
	belongs_to :keyable, :polymorphic => true
	attr_accessible :name

	has_many :key_fields, :dependent => :destroy
	has_many :fields, :through => :key_fields
	has_many :key_records, :dependent => :destroy
	has_many :records, :through => :key_records

	has_many :left_joins, :class_name => "Join", :foreign_key => "left_key_id"
	has_many :right_joins, :class_name => "Join", :foreign_key => "right_key_id"

	has_many :conditions, :dependent => :destroy

	def unique_field_names
		return self.fields.collect {|field| field.name }
	end

	def set_cell_to_type( cell, type )
		case type
		when 'datetime'
			cell.datetime = cell.string
		when 'float'
			cell.float = cell.string
		when 'int'
			cell.int = cell.string
		end
		return cell.save
	end

	def reindex_records
		self.key_records.each do |key_record|
			status = ''
			self.conditions.each do |condition|
				left_cell = key_record.record.get_cell( condition.left_field )
				if left_cell.field_id.nil?		
					status << "[missing left field]"
				elsif ! self.set_cell_to_type( left_cell, condition.data_type )
					status << "[cant convert #{left_cell.string} to #{condition.data_type}]"
				end

				right_cell = Cell.new # default for right value
				if condition.right_field
					right_cell = key_record.record.get_cell( condition.right_field )
					status << "[missing right field]" if right_cell.field_id.nil?		
				elsif condition.right_value
					right_cell.string = condition.right_value
				end

				if ! self.set_cell_to_type( right_cell, condition.data_type )
					raise "dont actually save a fake cell, but still validate it"
				end

				raise "run @condition.comparison"

			end

			status = 'valid' if status == ''
			if status != key_record.status
				key_record.status = status
				key_record.save!
			end
		end
	end

	def set_records
		self.keyable.records.each do |record| # check each record
			has_all_fields = true # does it have the requisite keys
			self.key_fields.each do |key_field|
				has_all_fields = false if record.get_cell( key_field.field ).field_id.nil?
			end
			if has_all_fields
				key_record = self.key_records.create
				key_record.record = record
				key_record.status = 'valid'
				key_record.save
			end
		end
	end

	def valid_records
		self.key_records.where( :status => 'valid' ).collect {|key_record| key_record.record }
	end

	def get_not_records
		record_ids = valid_records.map(&:id)  # id's of records matching this key
		not_records = Array.new
		self.keyable.records.each do |record| # loop through all available records
			not_records << record unless record_ids.include?( record.id ) # if not matched to this key
		end
		not_records 
	end

	def get_duplicate_records
		primary_keys = Hash.new	

		valid_records.each do |record| # check each record
			pk_value = ""
			self.key_fields.each do |key_field|
				pk_value << "[#{record.get_cell( key_field.field ).string}]"
			end
			primary_keys[ pk_value ] ||= Array.new
			primary_keys[ pk_value ] << record
		end

		duplicate_records = Array.new
		primary_keys.each do |key,records|
			duplicate_records.concat( records ) if records.size > 1	
		end
		duplicate_records	
	end

end
