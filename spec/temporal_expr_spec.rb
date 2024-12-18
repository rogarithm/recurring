require 'date'

require_relative '../lib/temporal/temporal_expr'
require_relative '../lib/temporal/range_each_year'
require_relative '../lib/temporal/day_in_month'
require_relative './helpers/spec_helper'

describe "temporal expression" do
  context "temporal expression 구현 방식을 정의한다" do
    it "주어진 날이 자신(temporal expr)에 속하는지 판단할 수 있다"
    it "기본 메서드를 갖는 temporal expr이 있고, 더 세부적인 질문에 답할 수 있는 메서드를 갖는 temporal expr의 구현 클래스가 있다"
  end

  context "day in month temporal expr을 정의할 수 있다" do
    it "인자로 받는 day_idx는 요일을 나타내고 1부터 7까지의 값이 올 수 있다" do
      invalid_args = [[0, 1], [8, 1]]

      invalid_args.each do |arg|
        expect {DayInMonth.new(*arg)}.to raise_error(RuntimeError)
      end
    end

    it "인자로 받는 cnt는 몇번째 주인지를 나타내고 1~5 또는 -1~-5 까지의 값이 올 수 있다" do
      invalid_args = [[1, 0], [1, 6], [1, -6]]

      invalid_args.each do |arg|
        expect {DayInMonth.new(*arg)}.to raise_error(RuntimeError)
      end
    end

    it "주어진 date의 요일을 알 수 있다" do
      monday_in_1st_week = DayInMonth.new(1, 1)
      monday = Date.new(2024, 11, 11)
      expect(monday_in_1st_week.day_matches monday).to eq(true)
    end

    it "첫번째 주를 기준으로 주어진 date가 달의 몇번째 주에 속하는지 알 수 있다" do
      monday_in_2nd_week = DayInMonth.new(1, 2)

      nov_1st_mon = Date.new(2024, 11, 4)
      expect(monday_in_2nd_week.week_matches nov_1st_mon).to eq(false)

      nov_2nd_mon = Date.new(2024, 11, 11)
      expect(monday_in_2nd_week.week_matches nov_2nd_mon).to eq(true)
    end

    it "마지막 주를 기준으로 주어진 date가 달의 몇번째 주에 속하는지 알 수 있다" do
      monday_in_last_week = DayInMonth.new(1, -1)
      nov_last_week = Date.new(2024, 11, 29)
      expect(monday_in_last_week.week_matches nov_last_week).to eq(true)
    end

    it "주어진 date가 해당 달의 몇번째 날인지 알 수 있다" do
      nov_11 = Date.new(2024, 11, 11)
      expect(nov_11.mday).to eq(11)
    end

    it "주어진 day_num(date는 해당 달에서 day_num번째 날)이 몇번째 주에 속하는지 알 수 있다" do
      ignore1, ignore2 = 1, 1
      day_in_mon = DayInMonth.new(ignore1, ignore2)

      (1..7).each {|day_in_1st_week|
        expect(day_in_mon.week_in_month day_in_1st_week).to eq(1)
      }
      (8..14).each {|day_in_2nd_week|
        expect(day_in_mon.week_in_month day_in_2nd_week).to eq(2)
      }
      (15..21).each {|day_in_3rd_week|
        expect(day_in_mon.week_in_month day_in_3rd_week).to eq(3)
      }
      (22..28).each {|day_in_4th_week|
        expect(day_in_mon.week_in_month day_in_4th_week).to eq(4)
      }
      (29..31).each {|day_in_5th_week|
        expect(day_in_mon.week_in_month day_in_5th_week).to eq(5)
      }
    end

    it "주어진 날짜에서, 해당 달의 마지막 날까지 남은 일수를 알 수 있다" do
      ignore1, ignore2 = 1, 1
      day_in_mon = DayInMonth.new(ignore1, ignore2)
      nov_11 = Date.new(2024, 11, 11)
      expect(day_in_mon.days_left_in_month nov_11).to eq(19)
    end
  end

  context "range every year temporal expr을 정의할 수 있다" do
    # 시작과 끝에 해당하는 day, month를 인자로 받는다

    it "months_include: 정의한 시작월과 끝월이 주어진 날짜의 달을 포함하는지 알 수 있다" do
      mar_to_sep = RangeEachYear.new(3, 9, 14, 12)
      out_of_range = [Date.new(2024, 2, 11), Date.new(2024, 11, 11)]
      out_of_range.each {|d|
        expect(mar_to_sep.months_include d).to eq(false)
      }
      in_range = [Date.new(2024, 4, 15), Date.new(2024, 8, 15)]
      in_range.each {|d|
        expect(mar_to_sep.months_include d).to eq(true)
      }
    end

    it "months_include: 주어진 날짜의 달이 시작월이나 끝월인 경우 포함되지 않았다고 판단한다" do
      mar_to_sep = RangeEachYear.new(3, 9, 14, 12)
      in_boundary = (1..30).inject([]) {|res, day|
        res << Date.new(2024, 3, day)
        res << Date.new(2024, 9, day)
      }
      in_boundary.each {|d|
        expect(mar_to_sep.months_include d).to eq(false)
      }
    end

    it "stt_month_includes: 정의한 시작 월일이 주어진 날짜를 포함하는지 알 수 있다" do
      mar_14_to_sep_12 = RangeEachYear.new(3, 9, 14, 12)

      mon_not_same_with_stt_mon = Date.new(2024, 4, 30)
      expect(mar_14_to_sep_12.stt_month_includes mon_not_same_with_stt_mon).to eq(false)

      day_lt_stt_day = Date.new(2024, 3, 11)
      expect(mar_14_to_sep_12.stt_month_includes day_lt_stt_day).to eq(false)

      days_ge_than_stt_day = [Date.new(2024, 3, 14), Date.new(2024, 3, 30)]
      days_ge_than_stt_day.each {|d|
        expect(mar_14_to_sep_12.stt_month_includes d).to eq(true)
      }
    end

    it "stt_month_includes: 시작일과 끝일이 0인 경우, 주어진 날짜의 시작 월만 같으면 참이다" do
      mar_to_sep = RangeEachYear.new(3, 9)

      mon_same_with_stt_mon = (1..30).inject([]) {|res, day|
        res << Date.new(2024, 3, day)
      }

      mon_same_with_stt_mon.each {|d|
        expect(mar_to_sep.stt_month_includes d).to eq(true)
      }

      mon_diff_with_stt_mon = (1..12).reject {|m| m == 3}
                                     .inject([]) {|res, mon|
                                       res << Date.new(2024, mon, 1)
                                     }

      mon_diff_with_stt_mon.each {|d|
        expect(mar_to_sep.stt_month_includes d).to eq(false)
      }
    end

    it "end_month_includes: 정의한 끝 월이 주어진 날짜를 포함하는지 알 수 있다" do
      mar_14_to_sep_12 = RangeEachYear.new(3, 9, 14, 12)

      mons_not_same_with_end_mon = [Date.new(2024, 8, 11), Date.new(2024, 10, 30)]
      mons_not_same_with_end_mon.each {|d|
        expect(mar_14_to_sep_12.end_month_includes d).to eq(false)
      }

      day_lt_end_day = Date.new(2024, 9, 10)
      expect(mar_14_to_sep_12.end_month_includes day_lt_end_day).to eq(true)

      day_after_end_day = Date.new(2024, 9, 30)
      expect(mar_14_to_sep_12.end_month_includes day_after_end_day).to eq(false)

      mon_after_end_mon = Date.new(2024, 10, 30)
      expect(mar_14_to_sep_12.end_month_includes mon_after_end_mon).to eq(false)
    end

    it "includes: 주어진 날짜가 range every year temporal expr이 정의하는 범위 내에 속하는지 알 수 있다" do
      mar_14_to_sep_12 = RangeEachYear.new(3, 9, 14, 12)

      before_range, after_range = Date.new(2024, 2, 28), Date.new(2024, 10, 10)
      falsy = [before_range, after_range]

      falsy.each do |d|
        expect(mar_14_to_sep_12.includes d).to eq(false)
      end

      in_range = [[3,14], [9,12], [4,1], [8,1]]
      truthy = in_range.inject([]) {|res, m_d|
        res << Date.new(2024, m_d[0], m_d[1])
      }

      truthy.each do |d|
        expect(mar_14_to_sep_12.includes d).to eq(true)
      end
    end
  end
end