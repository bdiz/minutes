require 'minitest_helper'

describe Minutes do

  it "raises an ArgumentError for bad time formats" do
    lambda { Minutes.new(";ljasdf") }.must_raise ArgumentError
  end

  it "can store a time" do
    minutes = Minutes.new("9:13PM")
    minutes.time_string.must_equal("9:13 PM")
  end

  it "raises an ArgumentError for out of range hour, minute or am/pm" do
    lambda { Minutes.new("13:01 AM") }.must_raise ArgumentError
    lambda { Minutes.new("3:60 PM") }.must_raise ArgumentError
    lambda { Minutes.new("3:00 ZM") }.must_raise ArgumentError
  end

  it "can add minutes to a time" do
    # Simple
    Minutes.add_minutes("9:13AM", 10).must_equal("9:23 AM")
    Minutes.add_minutes("9:13AM", 5*60).must_equal("2:13 PM")

    # Corner case
    Minutes.add_minutes("11:59AM", 1).must_equal("12:00 PM")
    Minutes.add_minutes("11:59PM", 1).must_equal("12:00 AM")
    Minutes.add_minutes("11:59PM", 10).must_equal("12:09 AM")

    # Wrap around cases
    Minutes.add_minutes("11:59PM", Minutes::A_DAY*1000 + 1).must_equal("12:00 AM")
    Minutes.add_minutes("12:00PM", Minutes::HALF_A_DAY).must_equal("12:00 AM")
    Minutes.add_minutes("11:59PM", Minutes::HALF_A_DAY*1001 + 1).must_equal("12:00 PM")
  end

end
