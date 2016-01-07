require 'date'
post '/properties/:property_id/booking' do

	@b = current_user.bookings.new(property_id: params[:property_id], from: Date.parse(params[:from]), to: Date.parse(params[:to]))
	@b.save
	redirect to "/properties/#{params[:property_id]}"
end

post '/users/:user_id/:booking_id/update' do
	@b = Booking.find(params[:booking_id])
	current_user
	if @b.user.id == current_user.id
		@b.update(from: Date.parse(params[:from]), to: Date.parse(params[:to]))
		redirect to "/users/#{params[:user_id]}"
	end
end

post '/users/:user_id/:booking_id/delete' do
	@b = Booking.find(params[:booking_id])
	current_user

	if @b.user.id == current_user.id
		@b.destroy
		redirect to "/users/#{params[:user_id]}"
	end
end
