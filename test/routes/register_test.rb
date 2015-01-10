require_relative '../helper.rb'

scope do
  test 'successful register with full information' do
    visit '/register'
    fill_in 'email', with: 'lagavulin@whiskey.de'
    fill_in 'nickname', with: 'lagavulin'
    fill_in 'password', with: 'ilikewhiskey'
    fill_in 'password_repeat', with: 'ilikewhiskey'
    click_button 'Registrieren'

    assert_equal current_path, '/'
    assert has_content?('lagavulin')
  end
end
