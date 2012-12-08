class Key < ActiveRecord::Base
	belongs_to :data_set
	attr_accessible :name

	has_many :key_fields, :dependent => :destroy
	has_many :fields, :through => :key_fields
	has_many :key_records, :dependent => :destroy
	has_many :records, :through => :key_records

	has_many :left_joins, :class_name => "Join", :foreign_key => "left_key_id"
	has_many :right_joins, :class_name => "Join", :foreign_key => "right_key_id"

	def unique_field_names
		return self.fields.collect {|field| field.name }
	end

	def set_records
		self.data_set.records.each do |record| # check each record
			has_all_fields = true # does it have the requisite keys
			self.key_fields.each do |key_field|
				has_all_fields = false if record.get_cell( key_field.field ).field_id.nil?
			end
			if has_all_fields
				key_record = self.key_records.create
				key_record.record = record
				key_record.save
			end
		end
	end

	def get_not_records
		record_ids = self.records.map(&:id) # id's of records matching this key
		not_records = Array.new
		self.data_set.records.each do |record| # loop through all available records
			not_records << record unless record_ids.include?( record.id ) # if not matched to this key
		end
		not_records 
	end

	def get_duplicate_records
		primary_keys = Hash.new	

		self.records.each do |record| # check each record
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
