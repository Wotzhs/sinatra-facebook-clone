class Like < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	belongs_to :status
	belongs_to :user

	validates :status_id, uniqueness: {scope: :user_id}
end
