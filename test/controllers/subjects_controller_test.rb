require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
  test "should get new" do
    get :new
    assert_response :success
  end
  test "should create subject" do
    assert_difference('Subject.count') do
      s = Subject.new(name: 'History 101', desc: 'A boring class')
      s.save
    end
  end
end
