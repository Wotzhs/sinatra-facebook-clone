helpers do
	def current_user
		if session[:user_email]
			@current_user ||= User.find_by(email: session[:user_email])
		end
	end

	def logged_in?
		!current_user.nil?
	end
end