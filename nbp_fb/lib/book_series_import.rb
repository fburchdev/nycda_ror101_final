#check to see whether Author exists
#if Author does not exist, instantiate new Author
	#Series and Books will all be new if Author is new
	#instantiate new Series
	#add series to Author.series
	#instantiate new books 
	#add books to Series.books
	#save Author, Series, and Books in one transaction
#if Author already exists
	#instantiate Author equal to existing one
	#check to see whether Series already exists
		#if Series already exists, the task is through with the current .series file
		#if Series does not exist, instantiate new Series
		#add Series to Author.series
		#add Books to Series.books
		#save Series and Books in one transaction - does this work as an update to Author?
	#When the task is complete, puts a message to that effect
class BookSeriesImporter

def self.hello_world_fb
	puts "Hello World from FB!"
end

end



