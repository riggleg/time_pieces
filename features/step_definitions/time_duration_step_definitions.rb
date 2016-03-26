When(/^I parse a time duration of "([^"]*)"$/) do |dur|
  @time_durations ||= []
  @time_durations << TimePieces::SimpleDuration.parse(dur);
end


Then(/^the last time duration should start at "([^"]*)"$/) do |time|
  assert_equal Chronic.parse(time).seconds_since_midnight, @time_durations.last.start_at_seconds
end

Then(/^the last time duration should end at "([^"]*)"$/) do |time|
  puts @time_durations.last.inspect
  assert_equal Chronic.parse(time).seconds_since_midnight, @time_durations.last.end_at_seconds

end
