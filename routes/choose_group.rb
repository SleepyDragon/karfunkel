class ChooseGroupRoutes < Cuba
end

ChooseGroupRoutes.define do
  on get do
    render('groups', {
      groups: []
    })
  end
end
