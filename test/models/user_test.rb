require_relative './helper'
require './models/user'

setup do
  Ohm.flush
end

test 'The user can be saved and retrieved' do
  created_user = User.create(email: 'test@example.com', nickname: 'talisker')
  found_user = User.with(:email, 'test@example.com')
  assert_equal created_user, found_user
end
