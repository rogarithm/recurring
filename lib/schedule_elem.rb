class ScheduleElem
  def initialize evt, tpr_expr
    @evt = evt
    @tpr_expr = tpr_expr
  end

  def occurrences evt_arg, date_range
    stt_date, end_date = date_range[0], date_range[1]
    dates = []
    stt_date.upto(end_date) do |d|
      dates << d if is_occurring evt_arg, d
    end
    dates
  end

  def next_occurrence evt_arg, date

  end

  def is_occurring evt_arg, date
    if @evt.desc == evt_arg.desc
      return @tpr_expr.includes(date)
    end
    false
  end
end
