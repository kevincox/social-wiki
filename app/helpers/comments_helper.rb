module CommentsHelper
  def comment_path comment
    post_path comment.post, anchor: comment.html_id
  end
end
