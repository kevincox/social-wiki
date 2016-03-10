class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :author,:title, :contents, presence: true
end
