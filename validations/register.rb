class RegisterValidation < Scrivener
  attr_accessor :email
  attr_accessor :nickname
  attr_accessor :password
  attr_accessor :password_confirmation

  def validate
    if assert_present(:email)
      assert_email(:email)
      assert_unique(:email, :User)
    end

    assert_present(:nickname)

    if assert_present(:password)
      assert_minimum_length(:password, 5)
    end

    if assert_present(:password_confirmation)
      assert_confirmation(:password)
    end
  end
end
