class RegisterValidation < Scrivener
  attr_accessor :email
  attr_accessor :nickname
  attr_accessor :password
  attr_accessor :password_confirmation

  def validate
    assert_email(:email)
    assert_minimum_length(:password, 5)
    assert_confirmation(:password)
  end
end
