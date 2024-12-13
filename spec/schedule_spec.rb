require_relative '../lib/schedule'
require_relative '../lib/event'
require_relative './helpers/spec_helper'

describe "schedule 객체는" do
  it "주어진 기간 내에 찾으려는 이벤트가 예정된 날짜 목록을 알 수 있다" do
    scd = Schedule.new
    scd_elem = double()
    scd.add_elem(scd_elem)

    allow(scd).to receive(:occurrences).and_return([Date.new(2024,11,04), Date.new(2024,12,02)])

    expect(
      scd.occurrences(
        Event.new("every mon", "golf games"),
        [Date.new(2024,11,3), Date.new(2024,12,05)]
      )
    ).to eq(
      [Date.new(2024,11,04), Date.new(2024,12,02)]
    )
    # should return uniq set of mondays from given date range
  end

  it "주어진 날짜 다음에 찾으려는 이벤트가 예정된 날짜를 알 수 있다" do
    scd = Schedule.new
    scd_elem = double()
    scd.add_elem(scd_elem)

    allow(scd).to receive(:next_occurrence).and_return(Date.new(2024,11,12))

    expect(
      scd.next_occurrence(
        Event.new("2nd tue of month", "gastro clinic"),
        Date.new(2024,11,10)
      )
    ).to eq(Date.new(2024,11,12))
    # should return next 1st or 3rd monday
  end

  it "주어진 날짜에 찾으려는 이벤트가 예정되어 있는지 알 수 있다" do
    scd = Schedule.new
    scd_elem = double()
    scd.add_elem(scd_elem)

    allow(scd).to receive(:is_occurring).and_return(true)

    expect(
      scd.is_occurring(
        Event.new("every mon", "golf games"),
        Date.new(2024,12,2)
      )
    ).to eq(true)
  end
end
