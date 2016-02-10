Feature: Overlapping checks on a time duration


Scenario: When two time durations are at the same start/end time.  They would overlap.
  Given there is a time duration {11:00am} to {3:00pm} on the stack
  And there is a time duration {11:00am} to {3:00pm} on the stack
  Then the [1] time duration on the stack should overlap with [0]
  And the [0] time duration on the stack should overlap with [1]

Scenario: When the 2nd time duration starts inside the first one, they should overlap
  Given there is a time duration {11:00am} to {3:00pm} on the stack
  And there is a time duration {2:00pm} to {5:00pm} on the stack
  Then the [1] time duration on the stack should overlap with [0]
  And the [0] time duration on the stack should overlap with [1]

Scenario: When the 2nd time duration ends inside the first one they should overlap
  Given there is a time duration {11:00am} to {3:00pm} on the stack
  And there is a time duration {10:00am} to {11:30am} on the stack
  Then the [1] time duration on the stack should overlap with [0]
  And the [0] time duration on the stack should overlap with [1]

Scenario: When the 2nd time duration is inside the first one they should overlap
  Given there is a time duration {11:00am} to {3:00pm} on the stack
  And there is a time duration {11:30am} to {2:00pm} on the stack
  Then the [1] time duration on the stack should overlap with [0]
  And the [0] time duration on the stack should overlap with [1]

Scenario: When the 1st time duration is inside the first one they should overlap
  Given there is a time duration {11:30am} to {2:00pm} on the stack
  And there is a time duration {11:00am} to {3:00pm} on the stack
  Then the [1] time duration on the stack should overlap with [0]
  And the [0] time duration on the stack should overlap with [1]


Scenario: When the 2nd time duration starts when the first one ends they do not overlap
  Given there is a time duration {11:00am} to {3:00pm} on the stack
  And there is a time duration {3:00pm} to {5:00pm} on the stack
  Then the [1] time duration on the stack should not overlap with [0]
  And the [0] time duration on the stack should not overlap with [1]

Scenario: When the 2nd time duration ends when the first one starts they should touch
  Given there is a time duration {11:00am} to {3:00pm} on the stack
  And there is a time duration {3:00pm} to {5:00pm} on the stack
  Then the [1] time duration on the stack should touch with [0]
  And the [0] time duration on the stack should touch with [1]
  And the [1] time duration on the stack should touch with [0]
  And the [0] time duration on the stack should touch at end with [1]
  And the [1] time duration on the stack should touch at start with [0]
  And the [1] time duration on the stack should not touch at end with [0]
  And the [0] time duration on the stack should not touch at start with [1]



# Scenario: When two appointments overlap they would both overlap (overlap by surrounding the saved appointment)
#   Given no appointments are scheduled
#   And there is an appointment type named "Hearing Review" with 30 for days until and 30 minutes long
#   And there is a consultant named Branch 1
#   And there is a consultant named Branch 2
#   And there is an available schedule with the hours set between h{10} to h{19} that repeats on wd{MTWRFSU} for Branch 1
#   When I schedule one appointment for Branch 1 at datetime{19/08/2015 10:30am} for 30 minutes
#   And I setup one appointment for Branch 1 at datetime{19/08/2015 10:15am} for 60 minutes
#   Then there should be overlap for the last appointment
#   And no saved display appointments should overlap
#   And when I save the last appointment
#   And all display appointments should overlap
