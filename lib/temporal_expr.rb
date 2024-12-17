class TemporalExpr
  def includes date
    raise 'this method should be overriden'
  end
end

class DayInMonth < TemporalExpr
  def initialize day_idx, cnt
    @day_idx = validate_day_idx day_idx
    @cnt = validate_cnt cnt
  end

  def validate_day_idx arg
    raise "day_idx must be between 1 and 7" if arg < 1 or arg > 7
    arg
  end

  def validate_cnt arg
    raise "cnt must be between 1 and 31" if arg == 0 or arg > 5 or arg < -5
    arg
  end

  def includes date
    day_matches date and week_matches date
  end

  def day_matches date
    date.cwday == @day_idx
  end

  def week_matches date
    if @cnt > 0
      week_from_start_matches date
    else
      week_from_end_matches date
    end
  end

  def week_from_start_matches date
    week_in_month(date.mday) == @cnt
  end

  def week_from_end_matches date
    days_from_month_end = days_left_in_month(date) + 1
    week_in_month(days_from_month_end) == @cnt.abs
  end

  def week_in_month day_num
    ((day_num - 1) / 7) + 1
  end

  def days_left_in_month date
    days_in_month = Date.new(date.year, date.mon, -1).day
    days_in_month - date.mday
  end
end

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
