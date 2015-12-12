class CreateEventValidation < Scrivener
  attr_accessor :date
  attr_accessor :time
  attr_accessor :location

  def validate
    assert_present(:date)
    assert_present(:time)
    assert_present(:location)
  end
end
