require_relative '../helper.rb'

test 'The user can be saved and retrieved' do
  created_user = User.create(email: 'test@example.com', nickname: 'talisker')
  found_user = User.with(:email, 'test@example.com')
  assert_equal created_user, found_user
end

test 'The user can be authenticated with the right username and password' do
  User.create(email: 'test2@example.com', nickname: 'oban', password: '1234')
  assert User.authenticate('test2@example.com', '1234')
end

test 'The user can not be authenticated with the right username and wrong password' do
  User.create(email: 'test3@example.com', nickname: 'aberlour', password: '1234')
  assert !User.authenticate('test3@example.com', 'falsch')
end
