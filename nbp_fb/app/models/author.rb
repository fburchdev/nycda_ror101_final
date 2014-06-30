class Author < ActiveRecord::Base
	has_many :series, dependent: :destroy
end
