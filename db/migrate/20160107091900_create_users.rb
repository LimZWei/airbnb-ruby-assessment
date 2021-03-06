
class CreateUsers < ActiveRecord::Migration
	

	def change
		create_table :users do |t|
			t.string :first_name, :null => true
			t.string :last_name, :null => true
			t.string :email, :null => false 
			t.string :encrypted_password
			t.timestamps :null => false
		end
	end
end