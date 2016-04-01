Feature: Traffic cop will put the time durations in different lanes when they overlap

Scenario: Adding two time sets together that are seperate will make a time set with 4 tds
  Given there is a time duration {11:00am} to {3:00pm} on the stack
  And there is a time duration {2:00pm} to {5:00pm} on the stack
  And there is a time duration {6:00pm} to {7:00pm} on the stack
  And there is a time duration {5:30pm} to {8:30pm} on the stack
  And I create a new traffic cop with all the time durations
  And I run traffic cop calculate
  Then the {0} sorted time duration in the last traffic cop should be "11:00am" to "3:00pm" and should be in lane "1" with a lane count of "2"
  Then the {1} sorted time duration in the last traffic cop should be "2:00pm" to "5:00pm" and should be in lane "2" with a lane count of "2"
  Then the {2} sorted time duration in the last traffic cop should be "5:30pm" to "8:30pm" and should be in lane "1" with a lane count of "2"
  Then the {3} sorted time duration in the last traffic cop should be "6:00pm" to "7:00pm" and should be in lane "2" with a lane count of "2"


