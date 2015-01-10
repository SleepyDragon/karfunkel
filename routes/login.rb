class LoginRoutes < Cuba
end

LoginRoutes.define do
  on get do
    render('login', {
      email: nil,
      errors: {}
    })
  end

  on post, param('email'), param('password') do |email, password|
    if login(User, email, password)
      res.redirect '/'
    else
      render('login', {
        email: email,
        errors: {
          login: [:wrong_username_or_password]
        }
      })
    end
  end
end
