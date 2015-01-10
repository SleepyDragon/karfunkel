ENV['DATABASE_URL'] = 'redis://localhost:6379/1'
require_relative '../app'
require 'cuba/test'
require 'cuba/capybara'
require 'malone/test'

prepare do
  Ohm.flush
  Malone.deliveries.clear
end
