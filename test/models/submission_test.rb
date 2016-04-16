require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @submissions = Submission.new(title: "Lorem ipsum", user_id: @user.id)
  end

  test "should be valid" do
    assert @submissions.valid?
  end

  test "user id should be present" do
    @submissions.user_id = nil
    assert_not @submissions.valid?
  end

end
