class Minutes
  module TimeParser

    TIME_FORMAT = /(\d?\d):(\d\d)\s*(AM|PM)/i
    HOUR_GROUP, MINUTE_GROUP, AM_PM_GROUP = 1, 2, 3

    class << self

      def parse time_string
        time_data = time_string.match(TIME_FORMAT)
        raise ArgumentError, "Time not formatted properly: #{time_string}" unless time_data
        value_of_hour(time_data[HOUR_GROUP]) + value_of_minute(time_data[MINUTE_GROUP]) + value_of_am_pm(time_data[AM_PM_GROUP])
      end

      private

      def value_of_hour hour
        if (1..12).include?(hour = Integer(hour))
          hour = 0 if hour == 12
          hour * MINUTES_IN_AN_HOUR 
        else
          raise ArgumentError, "Hour is out of range: #{hour}"
        end
      end

      def value_of_minute minute
        if (0..59).include?(minute = Integer(minute))
          minute
        else
          raise ArgumentError, "Minutes are out of range: #{minute}"
        end
      end

      def value_of_am_pm am_pm
        am_pm.match(/pm/i) ? HALF_A_DAY : 0
      end

    end
  end
end
