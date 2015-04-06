require_relative '../helper.rb'

scope do
  test 'successful register with full information' do
    visit '/register'
    fill_in 'email', with: 'lagavulin@whiskey.de'
    fill_in 'nickname', with: 'lagavulin'
    fill_in 'password', with: 'ilikewhiskey'
    fill_in 'password_confirmation', with: 'ilikewhiskey'
    click_button 'Registrieren'

    assert_equal current_path, '/groups'
    assert has_content?('lagavulin')
  end

  test 'registering with non matching passwords should not create the user' do
    visit '/register'
    fill_in 'email', with: 'oban@whiskey.de'
    fill_in 'nickname', with: 'oban'
    fill_in 'password', with: 'ilikewhiskey'
    fill_in 'password_confirmation', with: 'wrongrepeat'
    click_button 'Registrieren'

    fill_in 'email', with: 'oban@whiskey.de'
    fill_in 'nickname', with: 'oban'
    fill_in 'password', with: 'ilikewhiskey'
    fill_in 'password_confirmation', with: 'ilikewhiskey'
    click_button 'Registrieren'

    assert_equal current_path, '/groups'
    assert has_content?('oban')
  end
end
