require_relative '../helpers/spec_helper'

describe "schedule element" do
  it "각 event에 대한 schedule element를 schedule 객체에 전달한다"

  it "주어진 기간 내에 찾으려는 이벤트가 예정된 날짜 목록을 알 수 있다" do
    scd_elem = Recur::ScheduleElem.new(
      Recur::Event.new("1st mon of month", "golf games"),
      Recur::DayInMonth.new(1, 1)
    )

    expect(
      scd_elem.occurrences(
        Recur::Event.new("1st mon of month", "golf games"),
        [Date.new(2024,11,3), Date.new(2024,12,5)]
      )
    ).to eq(
      [Date.new(2024,11,4), Date.new(2024,12,2)]
    )
  end

  it "daterange 내에 속한 날짜를 가져올 수 있다" do
    date_range = [Date.new(2024,11,3), Date.new(2024,12,5)]
    stt_date, end_date = date_range[0], date_range[1]
    res = []
    stt_date.upto(end_date) do |d|
      res << d
    end
    expect(res[0]).to eq(Date.new(2024,11,3))
    expect(res[-1]).to eq(Date.new(2024,12,5))
  end

  it "주어진 날짜 다음에 찾으려는 이벤트가 예정된 날짜를 알 수 있다" do
    scd_elem = Recur::ScheduleElem.new(
      Recur::Event.new("2nd tue of month", "gastro clinic"),
      Recur::DayInMonth.new(2, 2)
    )

    # allow(scd_elem).to receive(:next_occurrence).and_return("2024-11-12")
    expect(
      scd_elem.next_occurrence(
        Recur::Event.new("2nd tue of month", "gastro clinic"),
        Date.new(2024,11,10)
      )
    ).to eq(Date.new(2024,11,12))
  end

  it "주어진 날짜에 찾으려는 이벤트가 예정되어 있는지 알 수 있다" do
    scd_elem = Recur::ScheduleElem.new(
      Recur::Event.new("1st mon of month", "golf games"),
      Recur::DayInMonth.new(1, 1)
    )

    expect(
      scd_elem.is_occurring(
        Recur::Event.new("1st mon of month", "golf games"),
        Date.new(2024, 12, 2)
      )
    ).to eq(true)
  end

  it "tmpr_expr에 set_expr이 올 수 있다" do
    union = Recur::Union.new
    union.add_elem Recur::DayInMonth.new(1, 1)
    union.add_elem Recur::DayInMonth.new(1, 3)

    scd_elem = Recur::ScheduleElem.new(
      Recur::Event.new("1st or 3rd mon of month", "golf games"),
      union
    )

    [Date.new(2024, 12, 2), Date.new(2024, 12, 16)].each do |d|
      expect(
        scd_elem.is_occurring(
          Recur::Event.new("1st or 3rd mon of month", "golf games"),
          d
        )
      ).to eq(true)
    end


    intersection = Recur::Intersection.new
    intersection.add_elem(Recur::DayInMonth.new(1, -1))
    intersection.add_elem(Recur::RangeEachYear.new(5, 5))

    memorial_days = [[2022, 5, 30], [2023, 5, 29], [2024, 5, 27]]
                           .inject([]) { |res, y_m_d|
                             res << Date.new(y_m_d[0], y_m_d[1], y_m_d[2])
                           }

    scd_elem = Recur::ScheduleElem.new(
      Recur::Event.new("last monday in May", "The US holiday of memorial day"),
      intersection
    )

    memorial_days.each {|d|
      expect(
        scd_elem.is_occurring(
          Recur::Event.new("last monday in May", "The US holiday of memorial day"),
          d
        )
      ).to eq(true)
    }
  end
end
