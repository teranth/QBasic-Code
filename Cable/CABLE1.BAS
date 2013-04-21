DECLARE SUB SendNumber (number%)
DECLARE SUB Menu ()
DECLARE FUNCTION GetNumber! ()
DECLARE SUB CloseConnection ()
DECLARE SUB OpenConnection ()
'This program was written by Elias York.
'Date: 08/13/2002
'This is a simple data transfer program for transfering
'numbers through a sarial cable connected to COM1.

'------------------ Variables ------------------'
'------------------- Defines -------------------'
'----------------- Main Driver -----------------'
'First of all lets open the connection.
'We will use the connection just like a file, it
'even has a number just like one the number we used
'in the OpenConnection sub routine was #1 so that
'is the number we can use to access the connection
'later on.
OpenConnection                                  'Open connection.

'Draw the menu and handle controls.
Menu                                            'Call Menu sub.

'Now we are done using the connection lets close it.
CloseConnection                                 'Close the connection.
END                                             'End the program.

SUB CloseConnection                             'Used to close the connection.
 'Yes yes this sub is so short it should most
 'likely not even be used. lol but it make learning
 'easyer so I have included it.
 CLOSE #1                                       'Close the connection called #1.
END SUB                                         'End of sub.

FUNCTION GetNumber                              'Used to get a number from the connection.
 'Get a number and then return it.
 INPUT #1, number%                              'Get a number from connection.
 GetNumber = number%                            'Return the number.
END FUNCTION                                    'End of function.

SUB Menu                                        'Used to draw the main menu and handle program controls.
 'First we need to draw the main menu so the user
 'knows what the heck they are doing.
 CLS                                            'Clear screen.
 DO                                             'Start of main menu loop.
  'Draw main menu.
  LOCATE 1, 1                                   'Move to 1,1
  PRINT "1 - Send a number to connection."      'Tell user that pressing 1 will send a number.
  PRINT "2 - Get a number from connection."     'Tell user that pressing 2 will get a number.
  PRINT "Q - Quit program."                     'Tell user that pressing Q will quit.
  'Now look at the keyboard buffer.
  SELECT CASE UCASE$(INKEY$)                    'Look at the keyboard buffer (UCASE$() makes all the letters capital).
   CASE "1":                                    'Send number command.
    CLS                                         'Clear screen.
    'Tell user how it works.
    PRINT "Make sure that the computer on the"  'Output help 1.
    PRINT "other side is set to get a number "  'Output help 2.
    PRINT "before hitting enter here."          'Output help 3.
    'Get the number to send.
    INPUT "Enter a number to send: ", number%   'Get number.
    'Send the number to connection.
    SendNumber (number%)                        'Send number.
    PRINT "Sent number:"; number%; "to connection."'Tell user whats going on.
    SLEEP 2                                     'Wait 2 seconds so user can read output.
    CLS                                         'Clear screen.
   CASE "2":                                    'Get number command.
    CLS                                         'Clear screen.
    PRINT "Waiting for number....Please send"   'Output help 1.
    PRINT "One from the computer on the other"  'Output help 2.
    PRINT "side now."                           'Output help 3.
    number% = GetNumber                         'Get the number.
    'Output the number we got.
    PRINT "Got the number:"; number%; "from the connection."
    SLEEP 2                                     'Wait for 2 seconds so the user can read the number.
    CLS                                         'Clear screen.
   CASE "Q":                                    'Quit command.
    EXIT DO                                     'New command EXIT use it to get out of a loop. EXIT DO only works on do loops.
  END SELECT                                    'Done looking at buffer.
 LOOP                                           'End of main menu loop.
END SUB

SUB OpenConnection                              'Used to open a connection on COM1.
 'Open the connection.
 OPEN "COM1:9600,N,8,1,CD0,CS0,DS0,OP0,RS,TB2048,RB2048" FOR RANDOM AS #1
END SUB                                         'End of sub. 

SUB SendNumber (number%)                        'Used to send a number to connection.
 'Send out the number to the connection.
 PRINT #1, number%                              'Send out number.
END SUB                                         'End of sub.

