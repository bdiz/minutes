require "minutes/version"

class Minutes

  TIME_FORMAT = /(\d?\d):(\d\d)\s*(AM|PM)/i

  def self.add_minutes time_string, additional_minutes
    minutes = self.new(time_string)
    minutes.add_minutes(additional_minutes)
    minutes.time_string
  end

  def initialize time_string
    @time = 0 

    unless m = time_string.match(TIME_FORMAT)
      raise ArgumentError, time_string
    end

    if (1..12).include?(hour = Integer(m[1]))
      @time += hour*60 if hour != 12
    else
      raise ArgumentError, "Hour must be in the range of 1..12, not #{m[1]}"
    end

    if (0..59).include?(minute = Integer(m[2]))
      @time += minute
    else
      raise ArgumentError, "Minute must be in the range of 0..59, not #{m[2]}"
    end

    if m[3].match(/pm/i)
      @time += 12*60
    end

  end

  def add_minutes additional_minutes
    @time += additional_minutes
    @time = @time.modulo(24*60)
  end

  def time_string
    "#{hour}:#{minute.to_s.rjust(2, '0')} #{pm? ? "PM" : "AM"}"
  end

  def hour
    hour = ((@time - minute) / 60).modulo(12)
    hour == 0 ? 12 : hour
  end

  def minute
    @time.modulo 60
  end

  def pm?
    @time >= 12*60
  end

end

