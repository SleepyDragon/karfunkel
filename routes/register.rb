class RegisterRoutes < Cuba
end

RegisterRoutes.define do
  on get do
    render('register', {
      error_on: {},
      email: nil,
      nickname: nil
    })
  end

  on post, param('email'), param('nickname'), param('password'), param('password_repeat') do |email, nickname, password, password_repeat|
    error_on = {}
    error_on['password_repeat'] = t('register.errors.passwords_not_equal') unless password == password_repeat
    error_on['password'] = t('register.errors.password_too_short') unless password.length > 5

    if error_on.empty?
      begin
        User.create(email: email, password: password, nickname: nickname)
      rescue Ohm::UniqueIndexViolation
        error_on['email'] = t('register.errors.email_already_taken')
      end
    end

    if error_on.empty?
      login(User, email, password)
      res.redirect '/'
    else
      render('register', {
        error_on: error_on,
        email: email,
        nickname: nickname
      })
    end
  end
end
