require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "new_registration_email" do
    mail = AdminMailer.new_registration_email
    assert_equal "New registration email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
