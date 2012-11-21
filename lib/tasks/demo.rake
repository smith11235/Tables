namespace :demo do

	task :index,[:search] => :environment do |t,args|
		args.with_defaults :search => "*"

		puts "Datasets: #{DataSet.count}"
		# this command taken from: 
		# http://stackoverflow.com/questions/8369812/rails-how-can-i-get-unique-values-from-column 
		unique_names = DataSet.select( :name ).uniq
		unique_names.each do |desired_set|
			subsets = DataSet.where( :name => desired_set.name )
			puts " - #{desired_set.name}: iterations #{subsets.size}"
			subsets.each do |set|
				puts "   - { :created_at => #{set[:created_at]},"
			  puts "       :record_count => #{set.records.size},"
				puts "       :fields => #{set.fields.size}"
				puts "     }"
			end
		end
	end

	task :load => :environment do

		datasets = get_simple_datasets

		datasets.each do |dataset|

			set = DataSet.new( :name => dataset[:name], :source => "rake demo:do" )	
			set.save! 

			ifield = set.fields.create :name => "i" # for recording record indecies

			dataset[:records].each_with_index do |record_hash,i|
				record = set.records.create  
				i_cell = record.cells.create( :int => i )
 				i_cell.field = ifield
				i_cell.save

				record_hash.each do |key,value|
					# distinctly get a field, create a listing for it if it's new
					field = set.fields.where( :name => key ).first
					field = set.fields.create( :name => key ) if field.nil?
					cell = record.cells.create :string => value.to_s
					cell.field = field
					cell.save 
				end
			end
		end
	end

	def get_simple_datasets
		datasets = []

		dataset = {
			:name => "friends",
			:records => [
				{ :recorded_on => ( DateTime.now - 1 ) },
				{ :i => "0", :name => "mike", :age => "25" },
				{ :i => "1", :name => "jon", :age => "25", :status => "little" },
				{ :i => "2", :name => "john", :age => "25", :status => "awol" },
				{ :i => "3", :name => "andrew", :age => "old" },
				{ :i => "4", :name => "kate", :age => "24", :is_a => "student" }
		]
		}
		datasets << dataset

		dataset = {
			:name => "friends",
			:records => [
				{ :recorded_on => DateTime.now },
				{ :i => "0", :name => "mike", :age => "26" },
				{ :i => "1", :name => "jon", :age => "25", :status => "little" },
				{ :i => "2", :name => "john", :age => "26", :status => "lost" },
				{ :i => "3", :name => "andrew", :married_to => "kate" },
				{ :i => "4", :name => "kate", :age => "25", :is_a => "doctor" }
		]
		}

		datasets << dataset

		dataset = {
			:name => "the good, the bad, the ugly",
			:records => [
				{ :name => "katie", :who => "mike", :start => "2004-08-22", :end => "too late" },
				{ :name => "kate", :who => "andrew", :start => "2008-07-15" },
				{ :name => "jon", :who => "rachel", :start => "2012-02-15" }
		]
		}
		datasets << dataset

		datasets
	end



end
