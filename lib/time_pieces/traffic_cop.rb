module TimePieces
  class TrafficCop
    attr_accessor :time_durations
    def initialize(time_durations)
      @time_durations = time_durations
    end
    def add_time_durations(time_durations)
      @time_durations += time_durations
    end
    def add_time_set(time_set)
      @time_durations += time_set.time_durations
    end
    def calculate!
      #This handles lane numbers also
      assign_lane_counts!
      
    end
    def assign_lane_numbers!
      lanes = [[], [], [], [], [], [], [], [], [], [], [], [], [], []]
      time_durations.sort_by(&:start_at_seconds).each do |td|
        lanes.each_with_index do |lane, lane_number|
          if lane.count > 0
            if lane.last.overlaps?(td)
              next
            else
              lane << td
              break
            end
          else
            lane << td
            break
          end

        end
      end
      lanes.each_with_index do |lane, lane_number|
        lane.each do |td|
          td.lane_number = lane_number + 1
          puts td.inspect
          puts td.lane_number
        end
      end
      return lanes
    end
    def assign_lane_counts!
      lanes = assign_lane_numbers!
      lanes.reverse.each_with_index do |lane, lane_number_reversed|
        real_lane = lanes.count - lane_number_reversed
        other_lane_recs = []
        lanes.each_with_index do |oth_lane, oth_lane_index|
          break if oth_lane_index >= real_lane
          other_lane_recs += oth_lane
        end
        lane.each do |rec|
          rec.lane_count ||= real_lane
          other_lane_recs.each do |oth_rec|
            if rec.overlaps?(oth_rec)
              oth_rec.lane_count = rec.lane_count if (oth_rec.lane_count.nil?) || (oth_rec.lane_count < rec.lane_count)
            end
          end
        end
      end

    end
  end
end
