class Movie < ActiveRecord::Base

	#attr_accessible :title, :rating, :description, :release_date
	def self.all_rating
		#puts "hello"
		["G","PG","PG-13","R"]
	end
end
