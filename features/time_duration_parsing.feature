Feature: Parsing a duration

Scenario: Parsing a duration in the form '4pm - 6pm' should return the correct duration
  When I parse a time duration of "4pm - 6pm"
  Then the last time duration should start at "4pm"
  And the last time duration should end at "6pm"
