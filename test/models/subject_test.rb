require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  test "subjects have posts" do
    assert_equal 2, subjects(:one).posts.count
    assert_equal 1, subjects(:two).posts.count
  end
end
