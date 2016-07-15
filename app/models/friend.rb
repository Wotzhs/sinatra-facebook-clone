class Friend < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	has_and_belongs_to :user
end
