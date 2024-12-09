class Schedule
  attr_reader :events, :scd_elems

  def initialize
    @events = []
    @scd_elems = []
  end

  def add_evt evt
    @events << evt
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
