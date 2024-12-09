require_relative '../lib/schedule'
require_relative '../lib/event'

describe "schedule 객체는" do
  RSpec.configure do |config|
    config.filter_run_when_matching(focus: true)
    config.example_status_persistence_file_path = 'spec/pass_fail_history'
  end

  it "주어진 기간 내에 찾으려는 이벤트가 예정된 날짜 목록을 알 수 있다" do
    scd = Schedule.new
    schedule_elem = double()
    # scd.add_elem(
    #   ScheduleElem.new(
    #     Event.new("every mon", "golf games"),
    #     TemporalExpr.new
    #   )
    # )
    scd.add_elem(schedule_elem)

    allow(scd).to receive(:occurrences) {["2024-11-18","2024-11-25","2024-12-02"]}
    expect(
      scd.occurrences("golf games", ["2024-11-10","2024-12-03"])
    ).to eq(
      ["2024-11-18","2024-11-25","2024-12-02"]
    )
    # should return uniq set of mondays from given date range
  end

  it "주어진 날짜 다음에 찾으려는 이벤트가 예정된 날짜를 알 수 있다" do
    scd = Schedule.new
    schedule_elem = double()
    # scd.add_elem(
    #   ScheduleElem.new(
    #     Event.new("1st and 3rd mon of month", "gastro clinic"),
    #     TemporalExpr.new
    #   )
    # )
    scd.add_elem(schedule_elem)

    allow(scd).to receive(:next_occurrence) {"2024-11-18"}
    expect(scd.next_occurrence("gastro clinic", "2024-11-10")). to eq("2024-11-18")
    # should return next 1st or 3rd monday
  end

  it "주어진 날짜에 찾으려는 이벤트가 예정되어 있는지 알 수 있다" do
    scd = Schedule.new
    schedule_elem = double()
    # schedule_elem = ScheduleElem.new(
    #   Event.new("every mon", "golf games"),
    #   DayInMonth.new(1, 1)
    # )
    scd.add_elem(schedule_elem)

    allow(scd).to receive(:is_occurring) {true}

    expect(
      scd.is_occurring(
        Event.new("every mon", "golf games"),
        Date.new(2024,12,2)
      )
    ).to eq(true)
  end
end