# app/models/user.rb
class User < ApplicationRecord
	has_secure_password
	has_many :courses
	has_many :posts
	has_many :tasks
	before_save :downcase_email
	# Асоціації
	belongs_to :admin, optional: true
	validates :name, presence: true, length: {minimum: 4}
	validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
	validates :password, presence: true, length: {minimum: 8}
	
	def downcase_email
		self.email = email.downcase
	end
 
 
	before_save :downcase_email
 
	validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
end
 