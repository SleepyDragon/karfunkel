class GroupsRoutes < Cuba
end

GroupsRoutes.define do
  on get do
    render('groups', {
      groups: Group.all.to_a
    })
  end
end
