require 'ohm'
Ohm.redis = Redic.new(ENV['TEST_DATABASE_URL'])
