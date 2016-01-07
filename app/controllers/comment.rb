
post '/properties/:property_id/comments' do

	@c = current_user.comments.new(property_id: params[:property_id], comment: params[:comment])
	@c.save
	redirect to "/properties/#{params[:property_id]}"
end

post '/comments/:comment_id/update' do
	@c = Comment.find(params[:comment_id])
	current_user
	if @c.user.id == current_user.id
		@c.update(comment: params[:comment])

		redirect to "/properties/#{@c.property_id}"
	end
end

post '/comments/:comment_id/delete' do
	@c = Comment.find(params[:comment_id])
	current_user

	if @c.user.id == current_user.id
		@c.destroy
		redirect to "/properties/#{@c.property_id}"
	end
end