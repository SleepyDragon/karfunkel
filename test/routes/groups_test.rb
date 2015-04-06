require_relative '../helper.rb'

scope do
  setup do
    game_master_1 = User.create(nickname: 'Peter', email: 'peter@example.com', password: 'secret')
    game_master_2 = User.create(nickname: 'Paul', email: 'paul@example.com', password: 'secret')
    User.create(nickname: 'Mary', password: 'puff', email: 'mary@example.com')

    @groups = [
      Group.create(name: 'Peergroup', system: 'DSA 5', game_master: game_master_1),
      Group.create(name: 'Spinner', system: 'DSA 4', game_master: game_master_2)
    ]
  end

  test 'shows all groups' do
    login_as 'peter@example.com', 'secret'
    visit '/groups'

    within '.groups' do
      assert page.assert_selector('h2', text: 'Peergroup (Peter)')
      assert page.assert_selector('.system', text: 'DSA 5')
      assert page.assert_selector('h2', text: 'Spinner (Paul)')
      assert page.assert_selector('.system', text: 'DSA 4')
    end

    logout
  end

  test 'create a new group' do
    login_as 'mary@example.com', 'puff'

    visit '/groups'
    click_link 'Neue Gruppe erstellen'

    fill_in 'name', with: 'Ardberg'
    select 'DSA 5', from: 'system'
    click_button 'Gruppe erstellen'

    assert_equal current_path, '/groups'
    within '.groups' do
      assert page.assert_selector('h2', text: 'Ardberg (Mary)')
    end

    logout
  end

  test 'selecting group should bring you to the welcome page for the group' do
    login_as 'mary@example.com', 'puff'

    group = @groups.last
    visit '/groups'
    click_link group.name

    assert has_content?("Spielgruppe: #{group.name}")
    assert_equal current_path, "/groups/#{group.id}/welcome"

    logout
  end

  test 'redirect to group selection if group ID does not exist' do
    login_as 'mary@example.com', 'puff'

    visit '/groups/10000/welcome'
    assert_equal current_path, '/groups'

    logout
  end

  test 'showing the groups should not be possible if you are not logged in' do
    visit '/groups'
    assert_equal current_path, '/login'
  end

  test 'creating a group should not be possible if you are not logged in' do
    visit '/groups/new'
    assert_equal current_path, '/login'
  end
end
