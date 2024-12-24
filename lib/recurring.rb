require_relative "./recurring/schedule"

class Recurring
  attr_reader :schedule

  def initialize
    @schedule = []
  end

  def add_schedule scd
    @schedule << scd
  end
end
