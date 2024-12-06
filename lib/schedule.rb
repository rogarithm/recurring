class Schedule
  attr_reader :events

  def initialize
    @events = []
  end

  def add_evt evt
    @events << evt
  end

  def occurrences(evt_arg, date_range)
  end

  def nextOccurrence(evt_arg, a_date)
  end

  def isOccurring(evt_arg, a_date)
  end
end
