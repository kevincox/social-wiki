class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :author, :contents, presence: true
  
end
