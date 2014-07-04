class Author < ActiveRecord::Base
	has_many :series, dependent: :destroy

	def self.get_name(author)
	  author_name = 'Unknown '
	  if !(author.prefix.blank?)
	  	author_name += author.prefix
	  end
	  if !(author.first_name.blank?)
	  	author_name += author.first_name + ' '
	  end

	  



	  return author_name
	end
end
