module TimePieces
  class SimpleDuration
    include TimePieces::Duration
    #Time is measured as seconds since midnight
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
    def inspect
      hours_start = start_at_seconds / 60 / 60
      hours_end = end_at_seconds / 60 / 60
      duration = duration_seconds / 60 / 60
      return "TD: #{hours_start} - #{hours_end} time in seconds: #{duration_seconds}"
    end
    def duration_copy
      return TimePieces::SimpleDuration.new(1,10)
    end
  end
end
