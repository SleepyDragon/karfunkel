require_relative '../helper.rb'

scope do
  setup do
    game_master_1 = User.create(nickname: 'Peter', email: 'peter@example.com')
    game_master_2 = User.create(nickname: 'Paul', email: 'paul@example.com')
    User.create(nickname: 'Mary', password: 'puff', email: 'mary@example.com')

    @groups = [
      Group.create(name: 'Peergroup', system: 'DSA 5', game_master: game_master_1),
      Group.create(name: 'Spinner', system: 'DSA 4', game_master: game_master_2)
    ]
  end

  test 'shows all groups' do
    visit '/groups'

    within '.groups' do
      assert page.assert_selector('h2', text: 'Peergroup (Peter)')
      assert page.assert_selector('.system', text: 'DSA 5')
      assert page.assert_selector('h2', text: 'Spinner (Paul)')
      assert page.assert_selector('.system', text: 'DSA 4')
    end
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

  test 'creating a new group is not possible if you are not logged in' do
    visit '/groups'
    click_link 'Neue Gruppe erstellen'

    fill_in 'name', with: 'Never created'
    select 'DSA 5', from: 'system'
    click_button 'Gruppe erstellen'

    assert_equal Group.find(name: 'Never created').count, 0
    assert_equal current_path, '/login'
  end
end
