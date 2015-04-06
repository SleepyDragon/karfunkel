class GroupsRoutes < Cuba
end

GroupsRoutes.define do
  on get, root do
    if logged_in?
      render('groups', {
        groups: Group.all.to_a
      })
    else
      res.status = 401
    end
  end

  on get, 'new' do
    if logged_in?
    render('create-group', {
      systems: System.all.to_a,
      errors: {},
      name: ""
    })
    else
      res.status = 401
    end
  end

  on post do
    if logged_in?
      create_group = CreateGroupValidation.new(req.params.merge(game_master: current_user))
      if create_group.valid?
        Group.create(create_group.attributes)
        res.redirect '/groups'
      else
        render('create-group', {
          systems: System.all.to_a,
          errors: create_group.errors,
          name: create_group.name
        });
      end
    else
      res.status = 401
    end
  end
end
