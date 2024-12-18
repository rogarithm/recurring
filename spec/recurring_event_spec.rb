require_relative '../lib/person'
require_relative '../lib/schedule'
require_relative '../lib/event'
require_relative '../lib/schedule_elem'
require_relative '../lib/temporal/temporal_expr'
require_relative './helpers/spec_helper'

describe "recurring event" do
  it "street cleaning outside my old house occurs on the first and third Monday of the month"

  it "schedule, schedule_element, temporal_expression 객체로 구성된다"

  it "my friend mark" do
    mark = Person.new("mark")
    scd = Schedule.new
    scd.add_elem(
      ScheduleElem.new(
        Event.new("1st and 3rd mon of month", "gastro clinic"),
        TemporalExpr.new
      )
    )
    scd.add_elem(
      ScheduleElem.new(
        Event.new("2nd wed of month", "liver clinic"),
        TemporalExpr.new
      )
    )
    scd.add_elem(
      ScheduleElem.new(
        Event.new("every mon", "golf games"),
        TemporalExpr.new
      )
    )
    mark.add_schedule scd
    # TODO expectation required!
  end
end
