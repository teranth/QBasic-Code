DECLARE SUB LearnCommand ()
DECLARE SUB SearchDataFile (Trigger AS STRING, Info AS ANY)
'This program was written by Elias York.
'Date: 04/27/2002 Time: 09:55:03 AM
'This is a E-Prog AI clone.

'-----------------  DataTypes  -----------------'
TYPE ReDat                                      'Make a new data type for variables called ReDat.
 Trigger AS STRING * 20                         'Trigger for message.
 Re1 AS STRING * 60                             'Reply 1 message.
 Re2 AS STRING * 60                             'Reply 2 message.
 Re3 AS STRING * 60                             'Reply 3 message.
 Found AS INTEGER                               'Found trigger.
END TYPE                                        'Done with data type.
'-------------- Global Variables ---------------'
DIM SHARED DataFile AS STRING                   'Make global string for data file.
DIM Temp AS ReDat                               'Make temp redat variable.
DIM Trigger AS STRING                           'Make trigger variable.

'----------------- Main Driver -----------------'
RANDOMIZE TIMER                                 'Make numbers random.
CLS                                             'Clear screen.
DataFile = "epdat.dat"                          'Set datafile name.

COLOR 1                                         'Blue text.
PRINT "Welcome to EPAI!"                        'Print title 1.
PRINT "   A EProg-AI Clone."                    'Print title 2.
DO                                              'Start main loop.
 COLOR 15                                       'Set user color.
 INPUT ">", Trigger                             'Input command from user.
 SearchDataFile Trigger, Temp                   'Look for command in datafile.
 IF Temp.Found <> 0 THEN                        'got something.
  choice = INT(RND * 3)                         'Get a random number up to 2.
  COLOR 2                                       'EPAI text green.
  SELECT CASE choice                            'Look at choice.
   CASE 0:                                      'If random number is 0.
    PRINT "EPAI: "; Temp.Re1                    'Anwser user.
   CASE 1:                                      'If random number is 1.
    PRINT "EPAI: "; Temp.Re2                    'Anwser user.
   CASE 2:                                      'If random number is 2.
    PRINT "EPAI: "; Temp.Re3                    'Anwser user.
  END SELECT                                    'Kill select.
 ELSE                                           'Can't find anything.
  IF UCASE$(Trigger) <> "QUIT" AND UCASE$(Trigger) <> "LEARN" THEN 'If quit command.
   COLOR 2                                      'Set text color.
   PRINT "EPAI: I don't know that."             'Error to user.
  END IF                                        'End if.
 END IF                                         'Done with if.
 IF UCASE$(Trigger) = "LEARN" THEN LearnCommand 'Call Learn command sub.
LOOP UNTIL UCASE$(Trigger) = "QUIT"             'End main loop.
END                                             'End the program.

SUB LearnCommand
 DIM t AS ReDat                                 'Make temp variable.
 DO                                             'Start main loop.
  CLS                                           'Clear the screen.
  PRINT "Welcome to the:"                       'Tell user title 1.
  PRINT "  Learn Command - Editor."             'Tell user title 2.
  PRINT                                         'Break line.
  PRINT "Menu:"                                 'Menu start.
  PRINT "(T) - Edit Trigger."                   'Edit trigger menu.
  PRINT "(1) - Edit Reply 1 Message."           'Edit reply 1 message menu.
  PRINT "(2) - Edit Reply 2 Message."           'Edit reply 2 message menu.
  PRINT "(3) - Edit Reply 3 Message."           'Edit reply 3 message menu.
  PRINT "(S) - Save Command to Datafile and Exit." 'Save command.
  PRINT "(E) - Exit Without Saving."            'Quit.
  INPUT ">", Cmd$                               'Get user command.
  SELECT CASE UCASE$(Cmd$)                      'Look at cmd$
   CASE "T":                                    'Trigger edit.
    INPUT "Enter Trigger(No more then 60 letters): ", t.Trigger 'Get Trigger.
    PRINT "Trigger updated!"                    'Tell user.
    SLEEP 2                                     'Wait 2 soconds.
   CASE "1":                                    'Re1 edit.
    INPUT "Enter Reply Message 1(No more then 60 letters): ", t.Re1'Get message 1.
    PRINT "Message 1 updated!"                  'Tell user.
    SLEEP 2                                     'Wait 2 soconds.
   CASE "2":                                    'Re2 edit.
    INPUT "Enter Reply Message 2(No more then 60 letters): ", t.Re2'Get message 2.
    PRINT "Message 2 updated!"                  'Tell user.
    SLEEP 2                                     'Wait 2 soconds.
   CASE "3":                                    'Re3 edit.
    INPUT "Enter Reply Message 3(No more then 60 letters): ", t.Re3'Get message 3.
    PRINT "Message 3 updated!"                  'Tell user.
    SLEEP 2                                     'Wait 2 soconds.
   CASE "S":                                    'Save edit.
    IF t.Trigger = "" THEN GOTO NeedDat         'If empty then error.
    IF t.Re1 = "" THEN GOTO NeedDat             'If empty then error.
    IF t.Re2 = "" THEN GOTO NeedDat             'If empty then error.
    IF t.Re3 = "" THEN GOTO NeedDat             'If empty then error.
    OPEN DataFile FOR APPEND AS #2              'Open data file.
     PRINT #2, "<=DATA=>"                       'Print header.
      PRINT #2, t.Trigger                       'Output trigger.
      PRINT #2, t.Re1                           'Save message 1.
      PRINT #2, t.Re2                           'Save message 2.
      PRINT #2, t.Re3                           'Save message 3.
     PRINT #2, "<!=DATA=!>"                     'Print ending.
    CLOSE #2                                    'Close datafile.
    PRINT "Saved new trigger."                  'Tell user.
    SLEEP 2                                     'Wait for 2 seconds.
    GOTO EndLearn                               'Jump to Endlearn.
NeedDat:
    PRINT "Some of the Messages or the Trigger are empty." 'Tell error.
    PRINT "Please fill them in before saving."  'Ask to fix.
DoneSave:
    SLEEP 2                                     'Wait 2 seconds.
   CASE "E":                                    'End.
    GOTO EndLearn                               'Jump to exit. (No save)
  END SELECT                                    'Done with select.
 LOOP                                           'End main loop.
EndLearn:
CLS                                             'Clar screen.
COLOR 1                                         'Blue text.
PRINT "Welcome to EPAI!"                        'Print title 1.
PRINT "   A EProg-AI Clone."                    'Print title 2.
END SUB

SUB SearchDataFile (Trigger AS STRING, Info AS ReDat)
 Info.Found = 0                                 'Not found.
 Info.Trigger = ""                              'Clear trigger.
 Info.Re1 = ""                                  'Clear message 1.
 Info.Re2 = ""                                  'Clear message 2.
 Info.Re3 = ""                                  'Clear message 3.
 OPEN DataFile FOR INPUT AS #1                  'Open the data file for input.
  WHILE NOT EOF(1)                              'While not the end of the file number 1.
  INPUT #1, junk$                               'Get some data from the file.
  IF UCASE$(junk$) = "<=DATA=>" THEN            'If this is a entry then.
   INPUT #1, junk$                              'Get the trigger.
   IF UCASE$(junk$) = UCASE$(Trigger) THEN      'If the trigger is right then.
    Info.Found = 1                              'Found it.
    Info.Trigger = junk$                        'Update trigger.
    INPUT #1, Info.Re1                          'Get reply 1.
    INPUT #1, Info.Re2                          'Get reply 2.
    INPUT #1, Info.Re3                          'Get reply 3.
    GOTO EndSearch                              'Jump out of loops.
   END IF                                       'Done with if.
  END IF                                        'Done with if.
  WEND                                          'End of loop.
EndSearch:
 CLOSE #1                                       'Close the data file.
END SUB

