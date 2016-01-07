require 'byebug'
get '/properties' do
	current_user
	erb :'properties/new'
end

post '/properties' do

	@p = current_user.properties.new(address: params[:property][:address], category: params[:property][:category], number_of_guests: params[:property][:number_of_guests], number_of_bathrooms: params[:property][:number_of_bathrooms])
	@p.save
	redirect to "/properties/#{@p.id}"
end

get '/properties/:property_id' do
	@property = Property.find(params[:property_id])
	erb :'properties/profile'
end

post '/properties/:property_id/:user_id/update' do
	@property = Property.find(params[:property_id])
	current_user

	if @property.user.id == current_user.id
		@property.update(address: params[:property][:address], category: params[:property][:category], number_of_guests: params[:property][:number_of_guests], number_of_bathrooms: params[:property][:number_of_bathrooms]) 
		redirect to "/properties/#{params[:property_id]}"
	else
		redirect to "/properties/#{params[:property_id]}"
	end
end

post '/properties/:property_id/:user_id/delete' do
	@property = Property.find(params[:property_id])
	current_user

	if @property.user.id == current_user.id
		@property.destroy
		redirect to '/users/dashboard'
	else
		redirect to '/users/dashboard'
	end
end
