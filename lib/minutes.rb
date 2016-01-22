require 'minutes/version'
require 'minutes/time_parser'

class Minutes

  MINUTES_IN_AN_HOUR = 60
  HOURS_IN_A_DAY = 24
  A_DAY = HOURS_IN_A_DAY * MINUTES_IN_AN_HOUR
  HALF_A_DAY = A_DAY / 2

  def self.add_minutes time_string, additional_minutes
    minutes = self.new(time_string)
    minutes.add_minutes(additional_minutes)
    minutes.time_string
  end

  def initialize time_string
    @time = TimeParser.parse(time_string)
  end

  def add_minutes additional_minutes
    @time += additional_minutes
    @time = @time.modulo(A_DAY)
  end

  def to_s
    "#{hour}:#{minute.to_s.rjust(2, '0')} #{pm? ? "PM" : "AM"}"
  end

  def time_string
    to_s
  end

  private

  def hour
    hour_24 = ((@time - minute) / MINUTES_IN_AN_HOUR)
    hour_12 = hour_24.modulo 12
    return hour_12 == 0 ? 12 : hour_12
  end

  def minute
    @time.modulo MINUTES_IN_AN_HOUR
  end

  def pm?
    @time >= HALF_A_DAY
  end

end

