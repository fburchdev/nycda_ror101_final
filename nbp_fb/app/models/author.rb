class Author < ActiveRecord::Base
	has_many :series, dependent: :destroy

	def self.get_name(author)
	  author_name = ''
	  if !(author.prefix.blank?)
	  	author_name += author.prefix
	  end
	  if !(author.first_name.blank?)
	  	author_name += author.first_name + ' '
	  end
	  if !(author.middle_name.blank?)
	  	author_name += author.middle_name + ' '
	  end
	  if !(author.last_name.blank?)
	  	author_name += author.last_name + ' '
	  end
	  if !(author.suffix.blank?)
	  	author_name += author.suffix
	  end
	  return author_name.chomp
	end
end
