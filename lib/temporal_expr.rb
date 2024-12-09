class TemporalExpr
  def includes date
    raise 'this method should be overriden'
  end
end

class DayInMonth < TemporalExpr
  def initialize day_idx, cnt
    @day_idx = day_idx
    @cnt = cnt
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
