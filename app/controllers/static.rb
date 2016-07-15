require 'byebug'
get '/' do
	if logged_in?
		@title = "Home"
  		erb :"static/index"
  	else
  		@title = "sFacebook"
  		erb :"static/signup"
  	end
end

post '/signup' do
	@user = User.new(name: params[:user_name], email: params[:user_email], date_of_birth: params[:user_dob])
	if @user.valid?
		@user.password = params[:user_password]
		@user.save
	else
		@error = "Please ensure all fields were entered correctly"
	end
end

post '/signin' do
	if User.authenticate(params[:user_email], params[:user_password])
		session[:user_email] = params[:user_email]
		redirect to '/'
	else
		@error = "Email or password is incorrect, please try again"
		erb :"static/signup"
	end
end

get '/signout' do
	session[:user_email] = nil
	erb :"static/signup"
end

post '/post_status' do
	@user = User.find(current_user.id)
	@user.statuses.create(status: params[:status_update])
	erb :"static/index"
end

post '/update/:id' do
	@status = Status.find_by(id: params[:id])
	@status.status = params[:update_status]
	@status.save
	erb :"static/index"
end

get '/update/:id' do
	@status = Status.find_by(id: params[:id])
	if @status
		erb :"static/status"
	else
		erb :"static/404"
	end
end

get '/like/:id' do
	@user = User.find(current_user.id)
	@liked = Like.find_by(status_id: params[:id], user_id: @user.id)
	if @liked.nil?
		@user.likes.create(status_id: params[:id])
	else
		@liked.destroy
	end
	@title = "Home"
	erb :"static/index"
end

get '/profile/:id' do
	@user = User.find_by(id: params[:id])
	if @user
		@title = @user.name
		erb :"static/profile"
	else
		@title = "Error"
		erb :"static/404"
	end
end

error Sinatra::NotFound do
  @title = "Error"
  erb :"static/404"
end

get '/add_friend/:id' do
	@friend_id = params[:id]
	@user = User.find(current_user.id)
	@friended = @user.friends.find_by(friend_id: params[:id])
	if @friended.nil?
		@user.friends.create(friend_id: params[:id])
	else
		@friended.destroy
	end
	redirect to "/profile/"+@friend_id
end

get '/delete/:id' do
	@status = Status.find_by(id: params[:id])
	@status.delete
	erb :"static/index"
end