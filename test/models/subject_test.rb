require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  test "subjects have posts" do
    assert_equal 2, subjects(:one).posts.count
    assert_equal 1, subjects(:two).posts.count
  end
  test "subjects has name" do
    assert_equal 'Subject One', subjects(:one).name
    assert_equal 'Cool Sub', subjects(:two).name
  end
  test "unique subjects" do
    assert_equal false, Subject.exists?(3)
  end
end
