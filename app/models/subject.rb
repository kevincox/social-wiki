class Subject < ActiveRecord::Base
  has_and_belongs_to_many :posts
  validates :name, presence: true, uniqueness: true
  validates :desc, presence: true
  
  def to_param
    name
  end
  
  def self.where_not_includes post
    Subject.find_by_sql [<<-SQL, post.id]
      SELECT * FROM subjects
      WHERE NOT EXISTS (
        SELECT * FROM posts_subjects
        WHERE subject_id = subjects.id
        AND   post_id = ?
      )
    SQL
  end
end
