class Post < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :subjects
  has_many :comments, dependent: :destroy
  validates :title, :contents, presence: true

  acts_as_votable

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end
  
end
