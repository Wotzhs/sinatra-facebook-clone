require 'bcrypt'

class User < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!

	include BCrypt

	has_many :statuses
	has_many :likes
	has_many :friends

	validates :email, uniqueness: true

	def self.authenticate(email, password)
		@user = User.find_by(email: email)
		@user && @user.password == password
	end

	def password
		@password ||= Password.new(hashed_password)
	end

	def password=(user_password)
		@password = Password.create(user_password)
		self.hashed_password = @password
	end
end
