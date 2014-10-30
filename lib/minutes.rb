require "minutes/version"

class Minutes

  TIME_FORMAT = /(\d?\d):(\d\d)\s*(AM|PM)/i
  HOUR_GROUP, MINUTE_GROUP, AM_PM_GROUP = 1, 2, 3

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
    @time = 0 

    time_data = time_string.match(TIME_FORMAT)
    raise ArgumentError, "Time not formatted properly: #{time_string}" unless time_data

    if (1..12).include?(hour = Integer(time_data[HOUR_GROUP]))
      hour = 0 if hour == 12
      @time += hour*MINUTES_IN_AN_HOUR
    else
      raise ArgumentError, "Hour is out of range: #{time_data[HOUR_GROUP]}"
    end

    if (0..59).include?(minute = Integer(time_data[MINUTE_GROUP]))
      @time += minute
    else
      raise ArgumentError, "Minutes are out of range: #{time_data[MINUTE_GROUP]}"
    end

    if time_data[AM_PM_GROUP].match(/pm/i)
      @time += HALF_A_DAY
    end

  end

  def add_minutes additional_minutes
    @time += additional_minutes
    @time = @time.modulo(A_DAY)
  end

  def time_string
    "#{hour}:#{minute.to_s.rjust(2, '0')} #{pm? ? "PM" : "AM"}"
  end

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

