require_relative '../helper.rb'

scope do
  setup do
    Ohm.flush
    User.create(email: 'test@example.com', nickname: 'talisker', password: 'verysecret')
  end

  test 'logging out the user hides the navigation bar' do
    # Login
    visit '/login'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'verysecret'
    click_button 'submit'

    click_button 'Abmelden'
    assert_equal current_path, '/login'
    assert has_no_selector?('nav')
  end
end
