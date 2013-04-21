'This program was written by Elias York.
'Date: 05/10/2002 Time: 08:15:05 PM
'This is a graphics example.

'---------------    Constents    ---------------'
CONST OMAX% = 100                               'Max number of objects.
CONST OUSED = 1                                 'USED flag for objects.
'--------------- New Data Types  ---------------'
TYPE obj                                        'New data type for objects.
 x      AS INTEGER                              'Use to hold x cord.
 y      AS INTEGER                              'Use to hold y cord.
 a      AS INTEGER                              'Use to hold used flag.
 sp     AS INTEGER                              'Use to hold object speed.
 c      AS INTEGER                              'Use to hold object color.
END TYPE
'-------------- Global Variables ---------------'
DIM o(OMAX% + 1) AS obj                         'Make object variables.

'----------------- Main Driver -----------------'
RANDOMIZE TIMER                                 'Make very random numbers.
SCREEN 12                                       'Set screen mode.
DO                                              'Start main loop.
 GOSUB AddFlare                                 'Add a flare to objects.
 GOSUB UpdateObjects                            'Upate all objects.
 GOSUB WriteNumberOut                           'Tell how many flares are out.
 FOR i = 0 TO 10000: NEXT i
LOOP UNTIL INKEY$ <> ""                         'Loop while no keys are pressed.
END                                             'End program.

UpdateObjects:                                  'Use to update all objects.
 FOR i = 0 TO OMAX%                             'Loop through all objects.
  IF o(i).a = OUSED THEN                        'If object is being used then update.
   CIRCLE (o(i).x, o(i).y), 3, 0                'Draw over old object with black.
   o(i).sp = o(i).sp + 1                        'Add one to speed.
   IF o(i).sp > 0 THEN o(i).y = o(i).y + (1 + o(i).sp / 4) ELSE o(i).y = o(i).y - 1'Move object.
   IF o(i).y > 479 THEN o(i).a = 0              'If object hit bottom ofscreen then kill it.
   CIRCLE (o(i).x, o(i).y), 3, o(i).c           'Use color to draw object.
  END IF
 NEXT i                                         'Next object.
RETURN

AddFlare:                                       'Use to add a flare.
 td = 0                                         'Turn done flag not set.
 FOR i = 0 TO OMAX%                             'Loop through all objects.
  IF o(i).a <> OUSED AND td <> 1 THEN           'Object is not being used.
   o(i).a = OUSED                               'Set used flag.
   o(i).x = INT(RND * 639) + 1                  'Set x.
   o(i).y = 479                                 'Set y.
   o(i).c = INT(RND * 15) + 1                   'Set color.
   o(i).sp = -(INT(RND * 480))                  'Set speed.
   td = 1                                       'Set turn done flag.
  END IF
 NEXT i                                         'Next object.
RETURN

WriteNumberOut:                                 'Used to output number of flares out.
count = 0                                       'Reset counter.
FOR i = 0 TO OMAX%                              'Loop through all objects.
 IF o(i).a = OUSED THEN count = count + 1       'If it is used then add to counter.
NEXT i                                          'Next object.
LOCATE 1, 1: PRINT "Flares out:"; count; "/"; OMAX% + 1   'Output number.
RETURN

SUB Blast (x, y)
 FOR i = 0 TO 100
 NEXT i
END SUB

