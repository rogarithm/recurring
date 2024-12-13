require_relative './helpers/spec_helper'

describe "schedule element" do
  it "각 event에 대한 schedule element를 schedule 객체에 전달한다"

  it "주어진 기간 내에 찾으려는 이벤트가 예정된 날짜 목록을 알 수 있다" do
    scd_elem = ScheduleElem.new(
      Event.new("1st mon of month", "golf games"),
      DayInMonth.new(1, 1)
    )

    expect(
      scd_elem.occurrences(
        Event.new("1st mon of month", "golf games"),
        ["2024-11-03", "2024-12-05"]
      )
    ).to eq(
      ["2024-11-04", "2024-12-02"]
    )
  end

  it "daterange 내에 속한 날짜를 가져올 수 있다" do
    date_range = ["2024-11-03", "2024-12-05"]
    stt_date, end_date = date_range.map!{|d| Date.new(*d.split("-").map(&:to_i))}
    res = []
    stt_date.upto(end_date) do |d|
      res << d
    end
    expect(res[0].to_s).to eq("2024-11-03")
    expect(res[-1].to_s).to eq("2024-12-05")
  end

  it "주어진 날짜 다음에 찾으려는 이벤트가 예정된 날짜를 알 수 있다" do
    scd_elem = ScheduleElem.new(
      Event.new("1st mon of month", "gastro clinic"),
      DayInMonth.new(1, 1)
    )

    allow(scd_elem).to receive(:next_occurrence).and_return("2024-12-02")
    expect(
      scd_elem.next_occurrence("gastro clinic", "2024-11-10")
    ).to eq("2024-12-02")
  end

  it "주어진 날짜에 찾으려는 이벤트가 예정되어 있는지 알 수 있다" do
    scd_elem = ScheduleElem.new(
      Event.new("1st mon of month", "golf games"),
      DayInMonth.new(1, 1)
    )

    expect(
      scd_elem.is_occurring(
        Event.new("1st mon of month", "golf games"),
        Date.new(2024, 12, 2)
      )
    ).to eq(true)
  end
end