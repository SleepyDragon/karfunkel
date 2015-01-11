class GroupsRoutes < Cuba
end

GroupsRoutes.define do
  on get, root do
    render('groups', {
      groups: Group.all.to_a
    })
  end

  on get, 'new' do
    render('create-group', {
      systems: System.all.to_a,
      errors: {},
      name: ""
    })
  end

  on post, param('name'), param('system') do |name, system|
    Group.create(name: name, system: system)
    res.redirect '/groups'
  end
end
