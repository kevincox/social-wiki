class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :title, :contents, presence: true
  validates :author, uniqueness: true, presence: true
end
