class SeriesRequest < ActiveRecord::Base
	validates_presence_of :email, message: "please provide email address"
	validates :email, presence: :true
end
