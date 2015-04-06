class GroupRoutes < Cuba
end

GroupRoutes.define do
  on get, 'welcome' do
    res.status = 401 unless authenticated(User)
    render('welcome')
  end

  on 'manage' do
    on get do
      res.status = 401 unless current_user.game_master_for? group
      users_except_current_user = User.all.to_a
      users_except_current_user.delete_if { |user| user.id == current_user.id }

      render('manage-group', {
        players: users_except_current_user
      })
    end

    on post do
      players = req.params['players'].map { |id| User[id] }
      group.players.replace(players)
      res.redirect '/groups/1/manage'
    end
  end
end
