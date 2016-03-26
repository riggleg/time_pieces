module TimePieces
  module DurationClassMethods
    def parse(str)
      times = str.split(" - ")
      dur = self.new(Chronic.parse(times[0]).seconds_since_midnight, Chronic.parse(times[1]).seconds_since_midnight -  Chronic.parse(times[0]).seconds_since_midnight)
      return dur
    end
  end
  module Duration
    attr_accessor :start_at_seconds, :duration_seconds
    def self.included(base)
      base.extend(DurationClassMethods)
    end
    def end_at_seconds
      return start_at_seconds + duration_seconds
    end
    def end_at_seconds=(new_end_at_seconds)
      self.duration_seconds = new_end_at_seconds - start_at_seconds
    end
    def update_start_seconds_and_end_seconds(new_start_seconds, new_end_seconds)
      self.start_at_seconds = new_start_seconds
      self.end_at_seconds = new_end_seconds
      return self
    end
    def left_duration_copy
      duration_copy
    end
    def right_duration_copy
      duration_copy
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
    def inside_of?(other_td)
      return true if (other_td.start_at_seconds < start_at_seconds) && (other_td.end_at_seconds > end_at_seconds)
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
    def <=>(other)
      start_at_seconds <=> other.start_at_seconds
    end
    def +(other_td)
      ts_ret = TimeSet.new
      if overlaps?(other_td)
        if overlaps_start?(other_td) && !overlaps_outside?(other_td)
          update_start_seconds_and_end_seconds(other_td.start_at_seconds, end_at_seconds)
          ts_ret << self
          return ts_ret
        end
        if overlaps_end?(other_td) && !overlaps_outside?(other_td)
          
          update_start_seconds_and_end_seconds(start_at_seconds, other_td.end_at_seconds)
          ts_ret << self
          return ts_ret
        end
        if overlaps_inside?(other_td)
          ts_ret << self
          return ts_ret
        end
        if overlaps_outside?(other_td)
          ts_ret << other_td
        end
        return ts_ret
      end
      if touches?(other_td)
        if touches_at_end?(other_td) && other_td.end_at_seconds > end_at_seconds
          update_start_seconds_and_end_seconds(start_at_seconds, other_td.end_at_seconds)
          ts_ret << self
          return ts_ret
        end
        if touches_at_start?(other_td) && other_td.start_at_seconds < start_at_seconds
          update_start_seconds_and_end_seconds(other_td.start_at_seconds, end_at_seconds)
          ts_ret << self
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
      return ts_ret if inside_of?(other_td)
      unless overlaps?(other_td)
        ts_ret << self
        return ts_ret
      end
      if overlaps?(other_td)

        if overlaps_start?(other_td)
          update_start_seconds_and_end_seconds(other_td.end_at_seconds, end_at_seconds)
          ts_ret << self
          return ts_ret
        end
        if overlaps_end?(other_td)
          puts inspect
          update_start_seconds_and_end_seconds(start_at_seconds, other_td.start_at_seconds)
          puts "RUNNING OVERLAPPING END"
          puts inspect
          ts_ret << self
          return ts_ret
        end
        if overlaps_inside?(other_td)
          left_of_break = left_duration_copy.update_start_seconds_and_end_seconds(start_at_seconds, other_td.start_at_seconds)
          right_of_break = right_duration_copy.update_start_seconds_and_end_seconds(other_td.end_at_seconds, end_at_seconds)
          ts_ret << left_of_break
          ts_ret << right_of_break
        end
        return ts_ret
      end
    end

  end
end
