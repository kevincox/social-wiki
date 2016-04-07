class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :contents, presence: true
  
  def html_id
    "c#{id}"
  end
end
