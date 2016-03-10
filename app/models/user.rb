class User < ActiveRecord::Base
  has_many :posts
=begin
User attributes
username: 	this is the username that the user goes by it can be used to log in. 
	 		It showed be shown next to users posts and comments. S
	 		Should be unique
password: 	personal password used to log in 
email: 		user's email addres it can be used to log in
=end


  EMAIL_REGEX =  %r{[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z}i

  validates :username, presence: true, uniqueness: true, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX 

  validates :password, confirmation: true, length: {in: 6..20}  
  validates :password_confirmation, presence: true
 
  has_secure_password	  

	def self.authenticate_with_username_or_email(username_or_email="",login_password="")
		if EMAIL_REGEX.match(username_or_email)
			user = User.find_by_email(username_or_email)
		else
			user = User.find_by_username(username_or_email)
		end
		if user && user.authenticate(login_password)
			return user
		else
			return nil
		end
	end
	
end
