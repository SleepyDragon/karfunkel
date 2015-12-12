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
    fill_in 'time', with: '2016-04-01T19:00'
    fill_in 'length', with: '4'
    fill_in 'location', with: 'Pub'
    click_button 'Termin erstellen'

    within '#events tr:nth-child(2)' do
      assert has_content? '01.04.2016 19:00 – 23:00'
      assert has_content? 'Pub'
    end
  end

  test 'hide past events' do
    @group.events << Event.create(
      start_time: '2000-01-01T13:00',
      end_time: '2000-01-01T17:00',
      location: 'Past'
    )
    @group.events << Event.create(
      start_time: Time.now,
      end_time: Time.now + 3600,
      location: 'Today'
    )
    @group.events << Event.create(
      start_time: '2050-01-01T13:00',
      end_time: '2050-01-01T17:00',
      location: 'Future'
    )
    visit "/groups/#{@group.id}/welcome"

    within '#events' do
      assert !(has_content? 'Past')
      assert has_content? 'Today'
      assert has_content? 'Future'
    end
  end
end
