require "minitest/autorun"
require "httparty"
require "json"
require_relative "expensable"

class PeopleTest < Minitest::Test
  def test_sessions_login_error
    credentials = { email: "test", password: "123456" }

    assert_raises(HTTParty::ResponseError) { Services::Sessions.login(credentials) }
  end

  # def test_user_signup_error
  # end
end
