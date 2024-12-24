module Recur
  class RangeEachYear < TemporalExpr
    attr_reader :stt_mon, :stt_day

    def initialize stt_mon, end_mon, stt_day=0, end_day=0
      @stt_mon, @end_mon = stt_mon, end_mon
      @stt_day, @end_day = stt_day, end_day
    end

    def includes date
      months_include date or stt_month_includes date or end_month_includes date
    end

    def months_include date
      mon = date.mon
      mon > @stt_mon and mon < @end_mon
    end

    def stt_month_includes date
      if date.mon != @stt_mon
        return false
      end
      if @stt_day == 0
        return true
      end
      date.day >= @stt_day
    end

    def end_month_includes date
      if date.mon != @end_mon
        return false
      end
      if @end_day == 0
        return true
      end
      date.day <= @end_day
    end
  end
end
