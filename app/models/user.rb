class User < ActiveRecord::Base
  has_many :posts
  validates :password, presence: true, length: {minimum: 8}
  validates :username, presence: true, length: {minimum: 3}
  validates :email, uniqueness: true, presence: true
=begin
	User attributes

	username: 	this is the username that the user goes by it can be used to log in. 
	 			It showed be shown next to users posts and comments. S
	 			Should be unique
	password: 	personal password used to log in 
	email: 		user's email addres it can be used to log in
=end

end
