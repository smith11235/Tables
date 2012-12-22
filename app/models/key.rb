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

	def reindex_records

		self.key_records.each do |key_record|
			key_record.status = ''

			self.conditions.each do |condition|
				condition.valid_record?( key_record )
			end # end of conditions.each

			if key_record.status == ''
				key_record.status = 'valid'
			end

			key_record.save!

		end # end of key_record.each
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
