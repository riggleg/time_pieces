Feature: Time sets can add and subtract from each other.

Scenario: Adding two time sets together that are seperate will make a time set with 4 tds
  Given there is a time duration {11:00am} to {3:00pm} on the stack
  And there is a time duration {4:00pm} to {5:00pm} on the stack
  When the last 2 time durations are added together into a result on the time set stack
  And there is a time duration {6:00pm} to {7:00pm} on the stack
  And there is a time duration {7:30pm} to {8:30pm} on the stack
  And the last 2 time durations are added together into a result on the time set stack
  And the last 2 time sets on the stack are added together and put on the stack
  Then the {2} time set in the stack should have {4} time durations
  And the {0} sorted time duration in {2} time set stack should be {11:00am} to {3:00pm}
  And the {1} sorted time duration in {2} time set stack should be {4:00pm} to {5:00pm}
  And the {2} sorted time duration in {2} time set stack should be {6:00pm} to {7:00pm}
  And the {3} sorted time duration in {2} time set stack should be {7:30pm} to {8:30pm}



Scenario: Adding two time sets together that have a overlapping time duration, will combine the two
  Given there is a time duration {11:00am} to {1:00pm} on the stack
  And there is a time duration {1:30pm} to {2:00pm} on the stack
  When the last 2 time durations are added together into a result on the time set stack
  And there is a time duration {1:45pm} to {3:00pm} on the stack
  And there is a time duration {4:30pm} to {5:30pm} on the stack
  And the last 2 time durations are added together into a result on the time set stack
  And the last 2 time sets on the stack are added together and put on the stack
  Then the {2} time set in the stack should have {3} time durations
  And the {0} sorted time duration in {2} time set stack should be {11:00am} to {1:00pm}
  And the {1} sorted time duration in {2} time set stack should be {1:30pm} to {3:00pm}
  And the {2} sorted time duration in {2} time set stack should be {4:30pm} to {5:30pm}

Scenario: When there are 2 overlapping times in a single timeset, they will combine to 1 duration after a combine call
  Given there is a time duration {11:00am} to {3:00pm} on the stack
  And there is a time duration {2:00pm} to {5:00pm} on the stack
  And there is a time set with the entire time duration stack
  Then the {0} time set in the stack should have {1} time durations
  When I examine the {0} time set in the stack
  Then the {0} sorted time duration in {0} time set stack should be {11:00am} to {5:00pm}

Scenario: Subtracting two sets
  Given there is a time duration {9:00am} to {1:00pm} on the stack
  And there is a time duration {2:00pm} to {7:00pm} on the stack
  And there is a time set with the entire time duration stack
  And I clear the time duration stack
  And there is a time duration {10:30am} to {11:00am} on the stack
  And there is a time duration {3:30pm} to {4:00pm} on the stack
  And there is a time set with the entire time duration stack
  When I subtract time set{1} from time set{0}
  And the {0} sorted time duration in {2} time set stack should be {9:00am} to {10:30am}
  And the {1} sorted time duration in {2} time set stack should be {11:00am} to {1:00pm}
  And the {2} sorted time duration in {2} time set stack should be {2:00pm} to {3:30pm}
  And the {3} sorted time duration in {2} time set stack should be {4:00pm} to {7:00pm}
  
