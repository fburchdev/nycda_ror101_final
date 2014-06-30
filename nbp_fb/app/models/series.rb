class Series < ActiveRecord::Base
	has_many :books, dependent: :destroy
	belongs_to :author
end
