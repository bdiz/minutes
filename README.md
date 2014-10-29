# Minutes

The Minutes class interprets times from a time string provided to its constructor.

    minutes = Minutes.new("9:13PM")

Internally, the number of minutes are stored for a 24 hour day as a Fixnum. Minutes can be added
to the Minutes object after construction and the time string will be updated accordingly.

    minutes = Minutes.new("9:13PM")
    minutes.add_minutes(10)
    minutes.time_string # => "9:23 AM"

## Usage

The Minutes class has a class method called add_minutes which presents an interface as requested in the 
exercise instructions.

    require 'minutes'
    Minutes.add_minutes("9:13 AM", 10) # => "9:23 AM"
    Minutes.add_minutes("11:59PM", 10) # => "12:09 AM"

See test/test_minutes.rb for more detailed usage.

