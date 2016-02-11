module TimePieces
  class TimeSet
    attr_accessor :time_durations
    def initialize
      @time_durations = []
    end
    #Adds a new time duration.  Removes invalid time durations.
    def <<(new_td)
      if new_td.duration_seconds == 0
        
      else
        new_tds = []
        has_combined = false
        time_durations.each do |td|
          if new_td.overlaps?(td) || new_td.touches?(td)
            combined_td = td + new_td
            combined_td.time_durations.each do |td3|
              new_tds << td3
            end
            has_combined = true
          else
            new_tds << td
          end
        end
        new_tds << new_td unless has_combined
        self.time_durations = new_tds
      end
      return self
    end
    def >>(subtracting_td)
      new_tds = []
      time_durations.each do |td|
        if subtracting_td.overlaps?(td)
          combined_td = td - subtracting_td
          combined_td.time_durations.each do |td3|
            new_tds << td3
          end
        else
          new_tds << td
        end

      end
      self.time_durations = new_tds
      return self
    end
    def +(other_ts)
      ret_ts = TimeSet.new
      ret_ts.time_durations = time_durations.map{|td| td}
      other_ts.time_durations.each do |td|
        ret_ts << td
      end
      return ret_ts
    end
    def -(other_ts)
      ret_ts = TimeSet.new
      ret_ts.time_durations = Array.new(time_durations)
      other_ts.time_durations.each do |td|
        ret_ts >> td
      end
      return ret_ts
      
    end
  end
end
