class ChooseGroupRoutes < Cuba
end

ChooseGroupRoutes.define do
  on get do
    render('groups', {
      groups: Group.all.to_a
    })
  end
end
