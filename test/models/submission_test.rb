require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @submission = Submission.new(title: "Lorem ipsum", user_id: @user.id)
  end

  test "should be valid" do
    assert @submission.valid?
  end

  test "user id should be present" do
    @submission.user_id = nil
    assert_not @submission.valid?
  end
  
  test "title should be present" do
    @submission.title = "   "
    assert_not @submission.valid?
  end

  test "title should be at most 140 characters" do
    @submission.title = "a" * 141
    assert_not @submission.valid?
  end
end
