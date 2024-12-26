require_relative "./recurring/schedule"

class Recurring
  attr_reader :schedules

  def initialize
    @schedules = []
  end

  def add_schedule scd
    @schedules << scd
  end
end
