class Person
  attr_reader :schedule

  def initialize name
    @name = name
    @schedule = []
  end

  def add_schedule scd
    @schedule << scd
  end
end
