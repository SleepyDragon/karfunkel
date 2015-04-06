class WelcomeRoutes < Cuba
end

WelcomeRoutes.define do
  on get, 'welcome' do
    res.status = 401 unless authenticated(User)
    render('welcome')
  end

  on get, 'manage' do
    users_except_current_user = User.all.to_a
    users_except_current_user.delete_if { |user| user.id == current_user.id }

    render('manage-group', {
      players: users_except_current_user
    })
  end

  on post, 'manage' do
    players = req.params['players'].map { |id| User[id] }
    group.players.replace(players)
    res.redirect '/groups/1/manage'
  end
end
