require 'bcrypt'
class User < ActiveRecord::Base
	attr_accessor :password
	validates :email, :format => { :with => /\w+[@]+\w+[.]+\w{1}+\w/}, :uniqueness => true
	validates :password, :length => { :minimum => 8}
	has_many :properties
	has_many :comments
	has_many :bookings
	
	def encrypt(password)
		self.encrypted_password = BCrypt::Password.create(password)
	end
end