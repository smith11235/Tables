namespace :demo do

	task :do => :environment do
		Rake::Task["db:reset"].invoke

		datasets = get_simple_datasets
		datasets.each do |dataset|
			puts "Name: #{dataset[:name]}" if dataset.has_key?( :name )
			puts " Records: #{dataset[:records].size}" if( dataset.has_key?( :records ) && dataset[:records].is_a?( Array ) )
			set = DataSet.new( :name => dataset[:name], :source => "rake demo:do" )	
			dataset[:records].each do |record|

				record.each do |field,raw|

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
