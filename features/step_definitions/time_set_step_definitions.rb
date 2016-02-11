Then(/^the \{(\d+)\} time set in the stack should have \{(\d+)\} time durations$/) do |num, count|
  ts = @time_set_stack[num.to_i]
  assert_equal count.to_i, ts.time_durations.count
end

Then(/^the \{(\d+)\} time duration in \{(\d+)\} time set stack should be \{([^\}]*)\} to \{([^\}]*)\}$/) do |td_index, ts_index, start_time_str, end_time_str|
  ts = @time_set_stack[ts_index.to_i]
  td = ts.time_durations[td_index.to_i]
  inp_td = TimePieces::SimpleDuration.parse_from_time_string(start_time_str, end_time_str)
  assert_equal inp_td.start_at_seconds, td.start_at_seconds
  assert_equal inp_td.end_at_seconds, td.end_at_seconds
end

Then(/^the \{(\d+)\} sorted time duration in \{(\d+)\} time set stack should be \{([^\}]*)\} to \{([^\}]*)\}$/) do |td_index, ts_index, start_time_str, end_time_str|
  ts = @time_set_stack[ts_index.to_i]
  td = ts.time_durations.sort[td_index.to_i]
  inp_td = TimePieces::SimpleDuration.parse_from_time_string(start_time_str, end_time_str)
  assert_equal inp_td.start_at_seconds, td.start_at_seconds
  assert_equal inp_td.end_at_seconds, td.end_at_seconds
end

When(/^I examine the \{(\d+)\} time set in the stack$/) do |ts_index|
  ts = @time_set_stack[ts_index.to_i]
  ts.time_durations.each_with_index do |td, index|
    hours_start = td.start_at_seconds / 60 / 60
    hours_end = td.end_at_seconds / 60 / 60
    duration = td.duration_seconds / 60 / 60
  end
end

Given(/^there is a time set with the entire time duration stack$/) do
  @time_set_stack ||= []
  ts = TimePieces::TimeSet.new
  @time_duration_stack.each do |td|
    ts << td
  end
  @time_set_stack ||= []
  @time_set_stack << ts
end

When(/^I subtract time set\{(\d+)\} from time set\{(\d+)\}$/) do |minuend_index, subtrahend_index|
  @time_set_stack ||= []
  @time_set_stack << (@time_set_stack[subtrahend_index.to_i] - @time_set_stack[minuend_index.to_i])
end
