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

test 'The group should have a representation of the title' do
  created_group = Group.create(name: 'Peergroup', system: 'dsa5', game_master: @game_master)
  assert_equal created_group.title, 'Peergroup (Meisterchen)'
end

test 'Add a player to the game' do
  created_group = Group.create(name: 'Peergroup', system: 'dsa5', game_master: @game_master)
  player = User.create(email: 'player@peergroup.de', nickname: 'Spielerlein')
  created_group.players << player
  assert_equal created_group.players.first, player
end

test 'Add an event to the group' do
  group = Group.create(name: 'Peergroup', system: 'dsa5', game_master: @game_master)
  event = Event.create(start_time: Time.now, end_time: Time.now + 3600, location: 'Internet')
  group.events << event
  assert_equal event, Group[group.id].events.first
end
