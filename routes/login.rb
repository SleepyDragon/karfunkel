class LoginRoutes < Cuba
end

LoginRoutes.define do
  on get do
    render('login', {
      email: nil,
      error_on: {}
    })
  end

  on post, param('email'), param('password') do |email, password|
    error_on = {}

    error_on['login'] = t('login.errors.wrong_username_or_password') unless login(User, email, password)

    if error_on.empty?
      res.redirect '/'
    else
      render('login', {
        email: email,
        error_on: error_on
      })
    end
  end
end
