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

  on post, param('email'), param('nickname'), param('password'), param('password_confirmation') do |email, nickname, password, password_confirmation|
    registration = RegisterValidation.new(
      email: email,
      nickname: nickname,
      password: password,
      password_confirmation: password_confirmation
    )

    if registration.valid?
      begin
        User.create(registration.slice(:email, :nickname, :password))
        login(User, registration.email, registration.password)
        res.redirect '/'
      rescue Ohm::UniqueIndexViolation
        registration.errors[:email].push(:email_already_taken)
      end
    end

    render('register', {
      errors: registration.errors,
      email: email,
      nickname: nickname
    })
  end
end
