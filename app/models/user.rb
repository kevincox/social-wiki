class User < ActiveRecord::Base
=begin
User attributes
username:   this is the username that the user goes by it can be used to log in. 
       It showed be shown next to users posts and comments. S
       Should be unique
password:   personal password used to log in 
email:     user's email addres it can be used to log in
=end
  has_many :posts
  has_many :comments

  EMAIL_REGEX =  %r{[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z}i
  PASSWORD_REGEX = %r{(?=.*[a-zA-Z])(?=.*[0-9])}i

  validates :username, presence: true, uniqueness: true, length: { in: 3..32 } 
  validates :email, confirmation: true, presence: true, uniqueness: true, format: EMAIL_REGEX 
  validates :email_confirmation, presence: true
  validates :password, confirmation: true, length: { in:8..256},format: {with: PASSWORD_REGEX, message: " must include at least one letter and atleast one number"}
  validates :password_confirmation, presence: true

  
  acts_as_voter  
  has_secure_password  
  
  def self.authenticate_with_username_or_email(username_or_email,login_password)
    if EMAIL_REGEX.match(username_or_email)
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_username(username_or_email)
    end
    if user.try :authenticate, login_password
      user
    else
      return nil
    end
  end
  
  def to_s
    username
  end
end
