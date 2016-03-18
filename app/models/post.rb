class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :title, :contents, presence: true
end
