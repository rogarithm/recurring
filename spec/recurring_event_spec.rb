require_relative '../lib/person'
require_relative '../lib/schedule'
require_relative '../lib/event'

describe "recurring event" do
  it "street cleaning outside my old house occurs on the first and third Monday of the month" do
  end

  it "schedule, schedule_element, temporal_expression 객체로 구성된다"

  it "my friend mark" do
    mark = Person.new("mark")
    scd = Schedule.new
    scd.add_evt(Event.new("1st and 3rd mon of month", "gastro clinic"))
    scd.add_evt(Event.new("2nd wed of month", "liver clinic"))
    scd.add_evt(Event.new("every mon", "golf games"))
    mark.add_schedule scd
    p mark.schedule
  end
end
