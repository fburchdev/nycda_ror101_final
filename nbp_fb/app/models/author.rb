class Author < ActiveRecord::Base
	has_many :series, dependent: :destroy

	def self.get_name(author)
	  author_name = 'Unknown'
	  return author_name
	end
end
