class Schedule
  attr_reader :events

  def initialize
    @events = []
  end

  def add_evt evt
    @events << evt
  end
end
