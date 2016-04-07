class Post < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :subjects
  has_many :comments, dependent: :destroy
  validates :title, :contents, presence: true

  acts_as_votable

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end
  
  def subject_ids_add= ids
    update subject_ids: subject_ids + [*ids]
  end
  
  def vote_by_user user
    return 0 unless user
    vote = votes_for.where(voter: user).take
    pp vote
    return 0 unless vote
    vote.vote_flag ? vote.vote_weight : -vote.vote_weight
  end
  
  def self.order_by_score
    order <<-SQL
      (SELECT
        COALESCE(
          SUM(CASE WHEN vote_flag THEN vote_weight ELSE -VOTE_WEIGHT END),
          0)
      FROM votes
      WHERE votable_id = posts.id
      AND votable_type = 'Post') DESC
    SQL
  end
end
