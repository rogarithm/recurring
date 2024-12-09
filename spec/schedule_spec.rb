require_relative '../lib/schedule'
require_relative '../lib/event'
require_relative '../lib/schedule_elem'
require_relative '../lib/temporal_expr'

describe "schedule 객체는" do
  it "어떤 날에 어떤 이벤트가 있는지 알 수 있다" do

  end

  it "주어진 기간 내에 찾으려는 이벤트가 예정된 날짜 목록을 알 수 있다" do
    scd = Schedule.new
    scd.add_elem(
      ScheduleElem.new(
        Event.new("every mon", "golf games"),
        TemporalExpr.new
      )
    )
    scd.occurrences("golf games", ["2024-11-10","2024-12-31"])
    # should return uniq set of mondays from given date range
  end

  it "주어진 날짜 다음에 찾으려는 이벤트가 예정된 날짜를 알 수 있다" do
    scd = Schedule.new
    scd.add_elem(
      ScheduleElem.new(
        Event.new("1st and 3rd mon of month", "gastro clinic"),
        TemporalExpr.new
      )
    )
    scd.nextOccurrence("gastro clinic", "2024-11-10")
    # should return next 1st or 3rd monday
  end

  it "주어진 날짜에 찾으려는 이벤트가 예정되어 있는지 알 수 있다" do
    scd = Schedule.new
    scd.add_elem(
      ScheduleElem.new(
        Event.new("every mon", "golf games"),
        TemporalExpr.new
      )
    )
    scd.isOccurring("golf games", "2024-12-02")
    # should return true, because 2024-12-02 is monday
  end
end