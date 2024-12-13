class Event
  attr_reader :occurrences, :desc

  def initialize ocrs, desc
    @occurrences = conv2dates(ocrs)
    @desc = desc
  end

  def conv2dates ocrs
    ocrs
  end
end
