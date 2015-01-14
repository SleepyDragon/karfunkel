class RegisterRoutes < Cuba
end

RegisterRoutes.define do
  on get do
    render('register', {
      errors: {},
      email: nil,
      nickname: nil
    })
  end

  on post do
    registration = RegisterValidation.new(req.params)

    if registration.valid?
      User.create(registration.slice(:email, :nickname, :password))
      login(User, registration.email, registration.password)
      res.redirect '/'
    else
      render('register', {
        errors: registration.errors,
        email: registration.email,
        nickname: registration.nickname
      })
    end
  end
end
