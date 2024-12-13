require 'date'
require_relative './helpers/spec_helper'

describe "temporal expression" do
  context "temporal expression 구현 방식을 정의한다" do
    it "주어진 날이 자신(temporal expr)에 속하는지 판단할 수 있다" do

    end

    it "기본 메서드를 갖는 temporal expr이 있고, 더 세부적인 질문에 답할 수 있는 메서드를 갖는 temporal expr의 구현 클래스가 있다" do

    end
  end

  context "day every month temporal expr을 정의할 수 있다" do
    # day of week와 count를 인자로 받는다
    it "주어진 date 객체가 몇요일인지 확인할 수 있다" do
      day_in_mon = DayInMonth.new(1, 1)
      monday = Date.new(2024, 11, 11)
      expect(day_in_mon.day_matches monday).to eq(true)
    end

    it "첫 주를 기준으로 하는 cnt일 때, 주어진 date 객체가 표현하는 날짜가 달의 몇번째 주인지 확인할 수 있다" do
      day_in_mon = DayInMonth.new(1, 2)
      monday = Date.new(2024, 11, 11)
      expect(day_in_mon.week_matches monday).to eq(true)
    end

    it "마지막 주를 기준으로 하는 cnt일 때, 주어진 date 객체가 표현하는 날짜가 달의 몇번째 주인지 확인할 수 있다" do
      day_in_mon = DayInMonth.new(1, -1)
      friday = Date.new(2024, 11, 29)
      expect(day_in_mon.week_matches friday).to eq(true)
    end

    it "Date#mday 주어진 date 객체가 표현하는 날짜가 달의 몇번째 날인지 알 수 있다" do
      monday = Date.new(2024, 11, 11)
      expect(monday.mday).to eq(11)
    end

    it "주어진 day_num(Date 객체가 표현하는 날짜가 해당 달에서 몇번째 날인지를 표현하는 값)이 몇번째 주에 속하는지 알 수 있다" do
      ignore1, ignore2 = 1, 1
      day_in_mon = DayInMonth.new(ignore1, ignore2)

      (1..7).each {|first_week_day|
        expect(day_in_mon.week_in_month first_week_day).to eq(1)
      }
      (8..14).each {|second_week_day|
        expect(day_in_mon.week_in_month second_week_day).to eq(2)
      }
      (15..21).each {|third_week_day|
        expect(day_in_mon.week_in_month third_week_day).to eq(3)
      }
      (22..28).each {|fourth_week_day|
        expect(day_in_mon.week_in_month fourth_week_day).to eq(4)
      }
      (29..31).each {|fifth_week_day|
        expect(day_in_mon.week_in_month fifth_week_day).to eq(5)
      }
    end

    it "주어진 날짜에서, 해당 달의 마지막 날까지 남은 날의 수를 구할 수 있다" do
      ignore1, ignore2 = 1, 1
      day_in_mon = DayInMonth.new(ignore1, ignore2)
      monday = Date.new(2024, 11, 11)
      expect(day_in_mon.days_left_in_month monday).to eq(19)
    end
  end

  context "range every year temporal expr을 정의할 수 있다" do
    # 시작과 끝에 해당하는 day, month를 인자로 받는다
  end
end