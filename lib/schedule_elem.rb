class ScheduleElem
  def initialize evt, tpr_expr
    @evt = evt
    @tpr_expr = tpr_expr
  end

  def is_occurring evt_arg, date
    if @evt.desc == evt_arg.desc
      return @tpr_expr.includes(date)
    end
    false
  end
end
