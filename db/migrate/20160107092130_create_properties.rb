class CreateProperties < ActiveRecord::Migration
	def change
		create_table :properties do |t|
			t.integer :user_id
			t.string :address, :null => false
			t.string :category, :null => true
			t.integer :number_of_guests
			t.integer :number_of_bathrooms
			t.timestamps :null => false
		end
	end
end