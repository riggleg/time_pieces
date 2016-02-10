Feature: Time durations can be added and subtracted



Scenario: Adding two durations together that do not overlap results in a time set with two time durations
  Given there is a time duration {11:00am} to {3:00pm} on the stack
  And there is a time duration {4:00pm} to {5:00pm} on the stack
  When the last 2 time durations are added together into a result on the time set stack
  Then the {0} time set in the stack should have {2} time durations
  And the {0} time duration in {0} time set stack should be {11:00am} to {3:00pm}
  And the {1} time duration in {0} time set stack should be {4:00pm} to {5:00pm}

Scenario: Adding two durations together that touch will make a time set with 1 duration
  Given there is a time duration {11:00am} to {3:00pm} on the stack
  And there is a time duration {3:00pm} to {5:00pm} on the stack
  When the last 2 time durations are added together into a result on the time set stack
  Then the {0} time set in the stack should have {1} time durations
  And the {0} time duration in {0} time set stack should be {11:00am} to {5:00pm}

Scenario: Adding two durations together that touch will make a time set with 1 duration
  Given there is a time duration {3:00pm} to {6:00pm} on the stack
  And there is a time duration {1:00pm} to {3:00pm} on the stack
  When the last 2 time durations are added together into a result on the time set stack
  Then the {0} time set in the stack should have {1} time durations
  And the {0} time duration in {0} time set stack should be {1:00pm} to {6:00pm}

Scenario: Adding two durations together that overlap will make a time set with 1 duration
  Given there is a time duration {2:00pm} to {6:00pm} on the stack
  And there is a time duration {1:00pm} to {3:00pm} on the stack
  When the last 2 time durations are added together into a result on the time set stack
  Then the {0} time set in the stack should have {1} time durations
  And the {0} time duration in {0} time set stack should be {1:00pm} to {6:00pm}


Scenario: Subtracting two durations together that do not overlap will make a time set with 1 duration which is same as original
  Given there is a time duration {1:00pm} to {2:00pm} on the stack
  And there is a time duration {3:00pm} to {6:00pm} on the stack
  When the [1] time duration is subtracted from [0] time duration
  Then the {0} time set in the stack should have {1} time durations
  And the {0} time duration in {0} time set stack should be {1:00pm} to {2:00pm}


Scenario: Subtracting two durations that overlap will cause the subtrehand to be clipped by the minuend
  Given there is a time duration {1:00pm} to {2:00pm} on the stack
  And there is a time duration {1:30pm} to {4:00pm} on the stack
  When the [1] time duration is subtracted from [0] time duration
  Then the {0} time set in the stack should have {1} time durations
  And the {0} time duration in {0} time set stack should be {1:00pm} to {1:30pm}

Scenario: When a time duration is fully subtracted it will return a time set with no time durations
  Given there is a time duration {1:00pm} to {2:00pm} on the stack
  And there is a time duration {1:00pm} to {2:00pm} on the stack
  When the [1] time duration is subtracted from [0] time duration
  Then the {0} time set in the stack should have {0} time durations

Scenario: Subtracting two durations that overlap will cause the subtrehand to be clipped by the minuend
  Given there is a time duration {1:00pm} to {2:00pm} on the stack
  And there is a time duration {11:00am} to {1:30pm} on the stack
  When the [1] time duration is subtracted from [0] time duration
  Then the {0} time set in the stack should have {1} time durations
  And the {0} time duration in {0} time set stack should be {1:30pm} to {2:00pm}
