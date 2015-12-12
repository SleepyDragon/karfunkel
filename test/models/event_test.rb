require_relative '../helper.rb'

test 'Create an event' do
  Event.create(date: Date.new(2015, 12, 24), time: '13 - 17 Uhr', location: 'Bei Tobi')
  assert_equal 'Bei Tobi', Event[1].location
  assert_equal '13 - 17 Uhr', Event[1].time
  assert_equal Date.new(2015, 12, 24), Event[1].date
end
