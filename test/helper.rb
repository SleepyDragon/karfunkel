require_relative "../app"
require "cuba/test"
require "malone/test"

prepare do
  Ohm.flush
  Malone.deliveries.clear
end
