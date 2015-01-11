class LoginRoutes < Cuba
end

LoginRoutes.define do
  on get do
    render('login', {
      email: nil,
      errors: {}
    })
  end

  on post do
    email = req.params['email']
    password = req.params['password']

    if login(User, email, password)
      res.redirect '/groups'
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
