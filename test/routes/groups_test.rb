require_relative '../helper.rb'

scope do
  setup do
    game_master_1 = User.create(nickname: 'Peter', email: 'peter@example.com')
    game_master_2 = User.create(nickname: 'Paul', email: 'paul@example.com')

    @groups = [
      Group.create(name: 'Peergroup', system: 'DSA 5', game_master: game_master_1),
      Group.create(name: 'Spinner', system: 'DSA 4', game_master: game_master_2)
    ]
  end

  test 'shows all groups' do
    visit '/groups'

    within '.groups' do
      assert page.assert_selector('h2', text: 'Peergroup')
      assert page.assert_selector('h2', text: 'Spinner')
    end
  end
end
