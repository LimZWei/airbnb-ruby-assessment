require 'byebug'
get '/' do
	unless params[:error].nil?
		@error = params[:error]
	end
  erb :"static/index"
end

get '/signup' do
	erb :'users/new'
end

get '/signup/' do
	erb :'users/new'
end

post '/signup' do
	# Do something processing with user input

	@user = User.new(email: params[:user][:email]) 
	@user.password = params[:user][:password]
	@user.encrypt(@user.password)
	if @user.save
		session['user_id'] = @user.id
		redirect to 'users/dashboard'
	else
		redirect to"/signup/?error=invalid email, password must be at least 8 characters"
	end
end

post '/login' do
	if User.where(email: params[:user][:email]).blank?
		redirect "/?error=invalid email and password combination"
	end

	@user = User.find_by(email: params[:user][:email]) 

	if BCrypt::Password.new(@user.encrypted_password).is_password? params[:user][:password]
		session[:user_id] = @user.id
		redirect to 'users/dashboard'
	else
		redirect "/?error=invalid email and password combination"
	end
end

post '/logout' do
	session.clear
	redirect to '/'
end

get '/users/dashboard' do
	current_user
	erb :'users/dashboard'
end

get "/users/:user_id" do
	current_user
	@bookings = Booking.all
	erb :'users/profile'
end