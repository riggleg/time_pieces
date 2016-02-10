class TimeDuration
  #Time is measured as seconds since midnight
  attr_accessor :start_at_seconds, :duration_seconds
  def start_at=(s_at)
    self.start_at_seconds = s_at.seconds_since_midnight
  end
  def initialize(start_at_seconds, duration_seconds)
    self.start_at_seconds = start_at_seconds
    self.duration_seconds = duration_seconds
  end
  def self.parse_from_time_string(start_at_str, end_at_str)
    start_at_seconds = Time.parse(start_at_str).seconds_since_midnight
    end_at_seconds = Time.parse(end_at_str).seconds_since_midnight
    return self.new(start_at_seconds, end_at_seconds - start_at_seconds)
  end
  def self.new_using_seconds_and_end_at(start_at_seconds, end_at_seconds)
    return self.new(start_at_seconds, end_at_seconds - start_at_seconds)
  end
  def end_at_seconds
    return start_at_seconds + duration_seconds
  end
  def overlaps_start?(other_td)
    return true if (start_at_seconds >= other_td.start_at_seconds) && (start_at_seconds < other_td.end_at_seconds)
    return false
  end
  def overlaps_end?(other_td)
    return true if (end_at_seconds <= other_td.end_at_seconds) && (end_at_seconds > other_td.start_at_seconds)
    return false
  end
  def overlaps_inside?(other_td)
    return true if (other_td.end_at_seconds > start_at_seconds) && (other_td.end_at_seconds <= end_at_seconds) && (other_td.start_at_seconds >= start_at_seconds) && (other_td.start_at_seconds < end_at_seconds)
    return false
  end
  def overlaps_outside?(other_td)
    return other_td.overlaps_inside?(self)
  end
  def overlaps?(other_td)
    return true if overlaps_outside?(other_td)
    return true if overlaps_start?(other_td)
    return true if overlaps_end?(other_td)
    return true if overlaps_inside?(other_td)
    return false
  end
  def touches_at_start?(other_td)
    return true if other_td.end_at_seconds == start_at_seconds
    return false
  end
  def touches_at_end?(other_td)
    return true if other_td.start_at_seconds == end_at_seconds
    return false
  end
  def touches?(other_td)
    return (touches_at_start?(other_td) || touches_at_end?(other_td))
    return false
  end
  def +(other_td)
    ts_ret = TimeSet.new
    if overlaps?(other_td)
      if overlaps_start?(other_td) && !overlaps_outside?(other_td)
        new_td = TimeDuration.new_using_seconds_and_end_at(other_td.start_at_seconds, end_at_seconds)
        ts_ret << new_td
        return ts_ret
      end
      if overlaps_start?(other_td) && !overlaps_outside?(other_td)
        new_td = TimeDuration.new_using_seconds_and_end_at(other_td.start_at_seconds, end_at_seconds)
        ts_ret << new_td
        return ts_ret
      end
      if overlaps_inside?(other_td)
        ts_ret << self
        return ts_ret
      end
      if overlaps_outside?(other_td)
        puts "Overlaps outside"
        ts_ret << other_td
      end
      return ts_ret
    end
    if touches?(other_td)
      if touches_at_end?(other_td) && other_td.end_at_seconds > end_at_seconds
        new_td = TimeDuration.new(start_at_seconds, other_td.end_at_seconds - start_at_seconds)
        ts_ret << new_td
        return ts_ret
      end
      if touches_at_start?(other_td) && other_td.start_at_seconds < start_at_seconds
        new_td = TimeDuration.new(other_td.start_at_seconds, end_at_seconds - other_td.start_at_seconds)
        ts_ret << new_td
        return ts_ret
      end
      return false
    end
    ts_ret << self
    ts_ret << other_td
    return ts_ret
  end
  def -(other_td)
    ts_ret = TimeSet.new
    unless overlaps?(other_td)
      ts_ret << self
      return ts_ret
    end
    if overlaps?(other_td)
      if overlaps_start?(other_td)
        ts_ret << TimeDuration.new_using_seconds_and_end_at(other_td.end_at_seconds, end_at_seconds)
      end
      if overlaps_end?(other_td)
        ts_ret << TimeDuration.new_using_seconds_and_end_at(start_at_seconds, other_td.start_at_seconds)
      end
      return ts_ret
    end
  end
end
