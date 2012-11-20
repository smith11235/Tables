namespace :demo do

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
		datasets
	end

	task :do do # => :environment do
		puts get_simple_datasets.to_yaml

	end

	
end
