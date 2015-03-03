ENV['DATABASE_URL'] = 'redis://localhost:6379/1'
require_relative '../app'
require 'cuba/test'
require 'cuba/capybara'
require 'malone/test'

prepare do
  Ohm.flush
  Malone.deliveries.clear
end

def login_as(email, password)
  visit '/login'
  fill_in 'email', with: email
  fill_in 'password', with: password
  click_button 'submit'
end

def logout
  visit '/'
  click_button 'Abmelden'
end
