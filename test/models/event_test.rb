require_relative '../helper.rb'

test 'Create an event' do
  Event.create(
    start_time: Time.new(2015, 12, 24, 19, 30),
    end_time: Time.new(2015, 12, 24, 23, 30),
    location: 'Bei Tobi'
  )

  assert_equal Time.new(2015, 12, 24, 19, 30), Event[1].start_time
  assert_equal Time.new(2015, 12, 24, 23, 30), Event[1].end_time
  assert_equal 'Bei Tobi', Event[1].location
end
