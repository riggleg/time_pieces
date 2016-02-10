class TimeSet
  attr_accessor :time_durations
  def initialize
    @time_durations = []
  end
  #Adds a new time duration.  Removes invalid time durations.
  def <<(td)
    if td.duration_seconds == 0
      
    else
      self.time_durations << td
    end
    return self
  end
end
