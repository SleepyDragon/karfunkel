require 'cuba/capybara'
require './app'

scope do
  setup do
    Ohm.flush
    User.create(email: 'test@example.com', nickname: 'talisker', password: 'verysecret')
  end

  test 'successful login redirects to root URL and greats user' do
    visit '/login'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'verysecret'

    click_button 'submit'
    assert_equal current_path, '/'
    assert has_content?('talisker')
  end

  test 'entering the wrong password will give an error' do
    visit '/login'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'verywrong'

    click_button 'submit'
    assert_equal current_path, '/login'
    assert has_content?('Benutzername oder Passwort falsch')
  end
end
