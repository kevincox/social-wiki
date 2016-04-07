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

  validates :username, presence: true, uniqueness: true, length: { in: 3..32 }
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :password, confirmation: true, length: {in: 8..256}
  validates :password_confirmation, presence: true

  acts_as_voter
  has_secure_password

  def trustscore
      # Rails has no easy way to parameterize raw SQL but since ID is an int we
      # should be fine. I added to_i to be extra safe.
      ActiveRecord::Base.connection.execute(<<-SQL).first['score'.freeze]
        SELECT
          COALESCE(
            SUM(CASE WHEN vote_flag THEN vote_weight ELSE -VOTE_WEIGHT END) / COUNT(*),
            0) as score
        FROM posts
        JOIN votes ON votable_id = posts.id
          AND votable_type = 'Post'
        WHERE posts.user_id = #{id.to_i}
      SQL
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
end
