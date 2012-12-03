class Key < ActiveRecord::Base
	belongs_to :data_set
	attr_accessible :name

	has_many :key_fields, :dependent => :destroy
	has_many :fields, :through => :key_fields
	has_many :key_records, :dependent => :destroy
	has_many :records, :through => :key_records

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

end
