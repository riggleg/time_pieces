Given(/^I create a new traffic cop with all the time durations$/) do
  @traffic_cops ||= []
  @traffic_cops << TimePieces::TrafficCop.new(@time_duration_stack)
end

Given(/^I run traffic cop calculate$/) do
  @traffic_cops.last.calculate!
end

Then(/^the \{(\d+)\} sorted time duration in the last traffic cop should be "([^"]*)" to "([^"]*)" and should be in lane "([^"]*)" with a lane count of "([^"]*)"$/) do |td_index, td_start_str, td_end_str, td_lane_number, td_lane_count|
  td = @traffic_cops.last.time_durations.sort_by(&:start_at_seconds)[td_index.to_i]
  assert_equal Chronic.parse(td_start_str).seconds_since_midnight, td.start_at_seconds
  assert_equal Chronic.parse(td_end_str).seconds_since_midnight, td.end_at_seconds
  assert_equal td_lane_number.to_i, td.lane_number
  assert_equal td_lane_count.to_i, td.lane_count
end
