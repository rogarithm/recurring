class ScheduleElem
  def initialize evt, temporal_expr
    @evt = evt
    @temporal_expr = temporal_expr
  end

  def is_occurring evt_arg, date
    if @evt == evt_arg
      return @temporal_expr.includes(date)
    end
    false
  end
end
