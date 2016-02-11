Given(/^there is a time duration \{([^\}]+)\} to \{([^\}]+)\} on the stack$/) do |start_at_str, end_at_str|
  td = TimePieces::TimeDuration.parse_from_time_string(start_at_str, end_at_str)
  @time_duration_stack ||= []
  @time_duration_stack << td
end

Then(/^the \[(\d+)\] time duration on the stack should overlap with \[(\d+)\]$/) do |first, second|
  td1 = @time_duration_stack[first.to_i]
  td2 = @time_duration_stack[second.to_i]
  assert_equal true, td1.overlaps?(td2)
end

Then(/^the \[(\d+)\] time duration on the stack should not overlap with \[(\d+)\]$/) do |first, second|
  td1 = @time_duration_stack[first.to_i]
  td2 = @time_duration_stack[second.to_i]
  # STDOUT.puts "#{td1.start_at_seconds} - #{td1.end_at_seconds}"
  # STDOUT.puts "#{td2.start_at_seconds} - #{td2.end_at_seconds}"
  # STDOUT.puts "Overlaps: #{td1.overlaps?(td2)}"
  # STDOUT.puts "Overlaps End: #{td1.overlaps_end?(td2)}"
  # STDOUT.puts "Overlaps Start: #{td1.overlaps_start?(td2)}"
  # STDOUT.puts "Overlaps Inside: #{td1.overlaps_inside?(td2)}"
  
  assert_equal false, td1.overlaps?(td2)
  

end

Then(/^the \[(\d+)\] time duration on the stack should touch with \[(\d+)\]$/) do |first, second|
  td1 = @time_duration_stack[first.to_i]
  td2 = @time_duration_stack[second.to_i]
  assert_equal true, td1.touches?(td2)
end

Then(/^the \[(\d+)\] time duration on the stack should touch at end with \[(\d+)\]$/) do |first, second|
  td1 = @time_duration_stack[first.to_i]
  td2 = @time_duration_stack[second.to_i]
  assert_equal true, td1.touches_at_end?(td2)

end

Then(/^the \[(\d+)\] time duration on the stack should touch at start with \[(\d+)\]$/) do |first, second|
  td1 = @time_duration_stack[first.to_i]
  td2 = @time_duration_stack[second.to_i]
  assert_equal true, td1.touches_at_start?(td2)
end

Then(/^the \[(\d+)\] time duration on the stack should not touch at end with \[(\d+)\]$/) do |first, second|
  td1 = @time_duration_stack[first.to_i]
  td2 = @time_duration_stack[second.to_i]
  assert_equal false, td1.touches_at_end?(td2)

end

Then(/^the \[(\d+)\] time duration on the stack should not touch at start with \[(\d+)\]$/) do |first, second|
  td1 = @time_duration_stack[first.to_i]
  td2 = @time_duration_stack[second.to_i]
  assert_equal false, td1.touches_at_start?(td2)
end

When(/^the last 2 time durations are added together into a result on the time set stack$/) do 
  td1 = @time_duration_stack[-2]
  td2 = @time_duration_stack[-1]
  @time_set_stack ||= []
  @time_set_stack << (td1 + td2)
  
end

When(/^the \[(\d+)\] time duration is subtracted from \[(\d+)\] time duration$/) do |minuend_index, subtrahend_index|
  td_subtrahend = @time_duration_stack[subtrahend_index.to_i]
  td_minuend = @time_duration_stack[minuend_index.to_i]
  
  @time_set_stack ||= []
  @time_set_stack << (td_subtrahend - td_minuend)
  
end

When(/^the last 2 time sets on the stack are added together and put on the stack$/) do
  ts1 = @time_set_stack[-2]
  ts2 = @time_set_stack[-1]
  @time_set_stack << (ts1 + ts2)
  
end

Given(/^I clear the time duration stack$/) do
  @time_duration_stack = []
end


