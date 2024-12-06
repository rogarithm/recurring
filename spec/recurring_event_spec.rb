describe "recurring event" do
  it "street cleaning outside my old house occurs on the first and third Monday of the month" do
  end

  it "schedule, schedule_element, temporal_expression 객체로 구성된다"

  it "my friend mark" do
    mark = Person.new("mark")
    scd = Schedule.new
    scd.add_evt(Event.new("1st and 3rd mon of month", "gastro clinic"))
    scd.add_evt(Event.new("2nd wed of month", "liver clinic"))
    scd.add_evt(Event.new("every mon", "golf games"))
    mark.add_schedule scd
    p mark.schedule
  end
end

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

class Schedule
  attr_reader :events

  def initialize
    @events = []
  end

  def add_evt evt
    @events << evt
  end
end

class Event
  def initialize occurrences, desc
    @occurrences = conv2dates(occurrences)
    @desc = desc
  end

  def conv2dates ocrs
    ocrs
  end
end