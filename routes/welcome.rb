class WelcomeRoutes < Cuba
end

WelcomeRoutes.define do
  on get do
    res.status = 401 unless authenticated(User)
    render('welcome')
  end
end
