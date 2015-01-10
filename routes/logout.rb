class LogoutRoutes < Cuba
end

LogoutRoutes.define do
  on post do
    logout(User)
    res.redirect '/login'
  end
end
