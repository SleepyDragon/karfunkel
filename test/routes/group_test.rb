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

  test 'manage events' do
    login_as 'mary@example.com', 'puff'
    visit "/groups/#{@group.id}/welcome"
    click_link 'Neuen Termin erstellen'
    fill_in 'date', with: '2016-04-01'
    fill_in 'time', with: 'Afternoon'
    fill_in 'location', with: 'Pub'
    click_button 'Termin erstellen'

    within '#events tr:nth-child(2)' do
      assert has_content? '01.04.2016'
      assert has_content? 'Afternoon'
      assert has_content? 'Pub'
    end
  end
end
