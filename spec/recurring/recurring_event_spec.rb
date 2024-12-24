require_relative '../../lib/recurring/person'
require_relative '../../lib/recurring/schedule'
require_relative '../../lib/recurring/event'
require_relative '../../lib/recurring/schedule_elem'
require_relative '../../lib/recurring/tmpr_expr/temporal_expr'
require_relative '../helpers/spec_helper'

describe "recurring event" do
  it "street cleaning outside my old house occurs on the first and third Monday of the month"

  it "schedule, schedule_element, temporal_expression 객체로 구성된다"

  it "my friend mark" do
    mark = Recur::Person.new("mark")
    scd = Recur::Schedule.new
    scd.add_elem(
      Recur::ScheduleElem.new(
        Recur::Event.new("1st and 3rd mon of month", "gastro clinic"),
        Recur::TemporalExpr.new
      )
    )
    scd.add_elem(
      Recur::ScheduleElem.new(
        Recur::Event.new("2nd wed of month", "liver clinic"),
        Recur::TemporalExpr.new
      )
    )
    scd.add_elem(
      Recur::ScheduleElem.new(
        Recur::Event.new("every mon", "golf games"),
        Recur::TemporalExpr.new
      )
    )
    mark.add_schedule scd
    # TODO expectation required!
  end
end
