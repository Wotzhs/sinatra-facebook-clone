class Status < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	belongs_to :user
	has_many :likes
end
