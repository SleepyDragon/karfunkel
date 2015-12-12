require 'scrivener'

class CreateEventValidation < Scrivener
  attr_accessor :time
  attr_accessor :length
  attr_accessor :location

  TIMESTAMP_FORMAT = /\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}\z/

  def validate
    if assert_present :time
      assert_format :time, TIMESTAMP_FORMAT
    end

    if assert_present :length
      assert_numeric :length
    end

    assert_present :location
  end

  def attributes
    {
      start_time: self.start_time,
      end_time: self.end_time,
      location: self.location
    }
  end

  def start_time
    Time.parse(self.time)
  end

  def end_time
    start_time + (self.length.to_i * 3600)
  end
end
