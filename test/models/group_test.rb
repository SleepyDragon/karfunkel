require_relative '../helper.rb'

setup do
  @game_master = User.create(email: 'master@peergroup.de', nickname: 'Meisterchen')
end

test 'The group can be saved and retrieved' do
  created_group = Group.create(name: 'Peergroup', system: 'dsa5', game_master: @game_master)
  found_group = Group[created_group.id]
  assert_equal created_group, found_group
  assert_equal found_group.game_master, @game_master
end
