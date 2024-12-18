require_relative '../lib/set_expr/union'
require_relative '../lib/set_expr/intersection'
require_relative '../lib/set_expr/difference'
require_relative './helpers/spec_helper'

describe "set expression" do
  it "매달 첫 번째나 세 번째 월요일에 반복되는 이벤트를 정의할 수 있다" do
    occur_on_a_or_b = Union.new
    occur_on_a_or_b.add_elem(DayInMonth.new(1, 1))
    occur_on_a_or_b.add_elem(DayInMonth.new(1, 3))

    _1st_or_3rd_mondays = [[11, 4], [11, 18], [12, 2], [12, 16]].inject([]) {|res, m_d|
      res << Date.new(2024, m_d[0], m_d[1])
    }
    _1st_or_3rd_mondays.each {|monday|
      expect(occur_on_a_or_b.includes(monday)).to be true
    }
  end

  it "매년 5월 마지막 주 월요일에 반복되는 이벤트를 정의할 수 있다" do
    occur_on_a_and_b = Intersection.new
    occur_on_a_and_b.add_elem(DayInMonth.new(1, -1))
    occur_on_a_and_b.add_elem(RangeEachYear.new(5, 5))

    last_monday_on_may = [[2022, 5, 30], [2023, 5, 29], [2024, 5, 27]].inject([]) {|res, y_m_d|
      res << Date.new(y_m_d[0], y_m_d[1], y_m_d[2])
    }

    last_monday_on_may.each {|monday|
      expect(occur_on_a_and_b.includes(monday)).to be true
    }
  end

  it "휴일을 제외하고, 4월부터 10월까지 달의 첫 번째나 세 번째 월요일에 반복되는 이벤트를 정의할 수 있다" do
    _1st_or_3rd_monday = Union.new
    _1st_or_3rd_monday.add_elem(DayInMonth.new(1, 1))
    _1st_or_3rd_monday.add_elem(DayInMonth.new(1, 3))

    occur_on_a_and_b = Intersection.new
    occur_on_a_and_b.add_elem(_1st_or_3rd_monday)
    occur_on_a_and_b.add_elem(RangeEachYear.new(4, 10))

    children_day = Intersection.new # 2024년도의 어린이날에만 해당된다
    children_day.add_elem(RangeEachYear.new(5, 5))
    children_day.add_elem(DayInMonth.new(1, 1))

    exclude_b_from_a = Difference.new(occur_on_a_and_b, children_day)

    ocrs = [[4, 15], [5, 6], [5, 20], [6, 3]].inject([]) {|res, m_d|
      res << Date.new(2024, m_d[0], m_d[1])
    }
    ocrs.reject! {|ocr| ocr.mon == 5 and ocr.mday == 6} # 어린이날은 제외한다

    ocrs.each {|ocr|
      expect(exclude_b_from_a.includes(ocr)).to be true
    }

    # difference temporal expr이 어린이날을 실제로 제외하는지 확인한다
    expect(exclude_b_from_a.excludes(Date.new(2024, 5, 6))).to be true
  end
end
