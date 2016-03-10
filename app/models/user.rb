class User < ActiveRecord::Base
=begin
User attributes
username: 	this is the username that the user goes by it can be used to log in. 
	 		It showed be shown next to users posts and comments. S
	 		Should be unique
password: 	personal password used to log in 
email: 		user's email addres it can be used to log in
=end


	def lookup_username(uname)
		return User.find_by username: uname
	end

	def lookup_email(ema)
		return User.find_by email: ema
	end
	
end
