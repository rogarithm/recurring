class Schedule
  attr_reader :scd_elems

  def initialize
    @scd_elems = []
  end

  def add_elem(schedule_elem)
    @scd_elems << schedule_elem
  end

  def occurrences evt_arg, date_range

  end

  def nextOccurrence evt_arg, date

  end

  def isOccurring evt_arg, date

  end
end
