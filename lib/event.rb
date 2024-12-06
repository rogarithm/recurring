class Event
  def initialize occurrences, desc
    @occurrences = conv2dates(occurrences)
    @desc = desc
  end

  def conv2dates ocrs
    ocrs
  end
end
