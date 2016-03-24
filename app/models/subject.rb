class Subject < ActiveRecord::Base
  has_and_belongs_to_many :posts
  validates :name, presence: true, uniqueness: true
  validates :desc, presence: true
  
  def to_param
    name
  end
end
