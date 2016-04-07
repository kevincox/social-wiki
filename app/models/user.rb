class User < ActiveRecord::Base
=begin
User attributes
username:   this is the username that the user goes by it can be used to log in.
       It showed be shown next to users posts and comments. S
       Should be unique
password:   personal password used to log in
email:     user's email addres it can be used to log in
=end
  attr_accessor :remember_token, :activation_token, :reset_token
  before_create :create_activation_digest

  has_many :posts
  has_many :comments

  EMAIL_REGEX =  %r{[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z}i
  PASSWORD_REGEX = %r{(?=.*[a-zA-Z])(?=.*[0-9])}i

  validates :username, presence: true, uniqueness: true, length: { in: 3..32 } 
  validates :email, confirmation: true, presence: true, uniqueness: true, format: {with: EMAIL_REGEX, message:  " must have a valid format"}
  validates :email_confirmation, presence: true
  validates :password, confirmation: true, length: { in:8..256},format: {with: PASSWORD_REGEX, message: " must include at least one letter and atleast one number"}
  validates :password_confirmation, presence: true

  acts_as_voter  
  has_secure_password  

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
   # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end


  def trustscore
    up_score = 0.0
    vote_score = 0.0
    self.posts.each do |post|
      up_score += post.get_upvotes.size
      vote_score += post.votes_for.size
    end
    if vote_score == 0.0
      vote_score =1.0
    end
    return up_score/vote_score * 10
  end

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

  # Activates an account.
  def activate
    activated = true
    activated_at = Time.now
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

   # Sends password reset email.
  def send_password_reset_email
    create_reset_digest
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

private
 

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
