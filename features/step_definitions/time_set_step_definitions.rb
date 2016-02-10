Then(/^the \{(\d+)\} time set in the stack should have \{(\d+)\} time durations$/) do |num, count|
  ts = @time_set_stack[num.to_i]
  assert_equal count.to_i, ts.time_durations.count
end

Then(/^the \{(\d+)\} time duration in \{(\d+)\} time set stack should be \{([^\}]*)\} to \{([^\}]*)\}$/) do |td_index, ts_index, start_time_str, end_time_str|
  ts = @time_set_stack[ts_index.to_i]
  td = ts.time_durations[td_index.to_i]
  inp_td = TimeDuration.parse_from_time_string(start_time_str, end_time_str)
  assert_equal inp_td.start_at_seconds, td.start_at_seconds
  assert_equal inp_td.end_at_seconds, td.end_at_seconds
end

When(/^I examine the \{(\d+)\} time set in the stack$/) do |ts_index|
  ts = @time_set_stack[ts_index.to_i]
  ts.time_durations.each_with_index do |td, index|
    hours_start = td.start_at_seconds / 60 / 60
    hours_end = td.end_at_seconds / 60 / 60
    duration = td.duration_seconds / 60 / 60
    puts "Index: #{index}"
    puts "TD: #{hours_start} - #{hours_end} time in seconds: #{td.duration_seconds}"
  end
end
