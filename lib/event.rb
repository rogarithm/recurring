class Event
  attr_reader :occurrences, :desc

  def initialize occurrences, desc
    @occurrences = conv2dates(occurrences)
    @desc = desc
  end

  def conv2dates ocrs
    ocrs
  end
end
