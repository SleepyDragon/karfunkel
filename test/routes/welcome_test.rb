require_relative '../helper.rb'

scope do
  setup do
    game_master = User.create(nickname: 'Mary', password: 'puff', email: 'mary@example.com')
    @group = Group.create(name: 'Die Tollen', system: 'DSA 5', game_master: game_master)
    User.create(nickname: 'Rolf', password: 'pups', email: 'rolf@example.com')
    User.create(nickname: 'Hannes', password: 'pups', email: 'hannes@example.com')
  end

  test 'manage players' do
    login_as 'mary@example.com', 'puff'
    visit "/groups/#{@group.id}/welcome"
    click_link 'Gruppenverwaltung'
    select 'Rolf', from: 'players[]'
    click_button 'Spieler festlegen'
    assert has_select?('players[]', selected: ['Rolf'])
    logout
  end

  test 'players cannot manage the group' do
    login_as 'rolf@example.com', 'pups'
    visit "/groups/#{@group.id}/manage"
    assert_equal current_path, "/login"
    logout
  end
end
