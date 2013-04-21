DECLARE SUB RemoteMode ()
DECLARE SUB ControlMode ()
DECLARE SUB SendNumber (number%)
DECLARE SUB Menu ()
DECLARE FUNCTION GetNumber! ()
DECLARE SUB CloseConnection ()
DECLARE SUB OpenConnection ()
'This program was written by Elias York.
'Date: 08/13/2002
'This is a simple remote control computer program useing
'numbers through a sarial cable connected to COM1.

'------------------ Variables ------------------'
'------------------- Defines -------------------'
'----------------- Main Driver -----------------'
'First of all lets open the connection.
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

SUB ControlMode                                 'Used to play as control mode.
 DO                                             'Start main loop.
  INPUT "Enter command(555,0 to quit,777,0 for help): ", choice%, arg% 'Get choice.
  IF choice% <> 777 AND choice% <> 555 THEN     'If not a command then.
   SendNumber (choice%)                         'Send command.
   SendNumber (arg%)                            'Send value.
  END IF                                        'End of if.
  IF choice% = 777 THEN                         'Help command.
   PRINT "- Command -"; TAB(20); "- Desc -"
   PRINT "- 1,arg% -"; TAB(20); "Changes color to arg."
   PRINT "- 2,arg% -"; TAB(20); "Move box randomly around with power of arg%"
   PRINT "- 555,0 -"; TAB(20); "Exits."
   PRINT "- 777,0 - "; TAB(20); "Shows this."
  END IF                                        'End of if.
 LOOP UNTIL choice% = 555                       'End of loop.
 SendNumber (555)                               'Send end command to remote.
 SendNumber (0)                                 'Send junk number.
 CLS                                            'Clear screen.
END SUB

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
  LOCATE 1, 1                                   'Move to 1,1
  'Draw main menu.
  PRINT "1 - Remote mode."                      'Tell user that pressing 1 will go into remote mode.
  PRINT "2 - Control mode."                     'Tell user that pressing 2 will go into control mode.
  PRINT "Q - Quit program."                     'Tell user that pressing Q will quit.
  'Now look at the keyboard buffer.
  SELECT CASE UCASE$(INKEY$)                    'Look at the keyboard buffer (UCASE$() makes all the letters capital).
   CASE "1":                                    'Remote mode command.
    RemoteMode                                  'Go into remote mode.
    CLS                                         'Clear screen.
   CASE "2":                                    'Control mode command.
    ControlMode                                 'Go into control mode.
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

SUB RemoteMode                                  'Used to play as remote mode.
 SCREEN 12                                      'Set the screen mode.
 col% = 3                                       'Set default box color.
 x% = 270                                       'Set default box x.
 y% = 160                                       'Set default box y.
 DO                                             'Start main remote loop.
  LINE (x% + 1, y% + 1)-(x% + 100, y% + 100), col%, BF      'Draw box.
  cmd% = GetNumber                              'Get control command.
  arg% = GetNumber                              'Get command arg.
  SELECT CASE cmd%                              'Find out what command it is.
   CASE 1:                                      'It is set color command.
    col% = arg%                                 'Change box color to arg.
   CASE 2:                                      'Random move.
    x% = x% + INT(-arg% + (RND * (arg% * 2))) MOD 640  'Move random on x.
    y% = y% + INT(-arg% + (RND * (arg% * 2))) MOD 480  'Move random on y.
   CASE 555:                                    'It is Exit command.
    EXIT DO                                     'Exit the do loop.
  END SELECT                                    'Done looking for commands.
 LOOP UNTIL INKEY$ <> ""                        'End of main remote loop.
END SUB                                         'End of sub.

SUB SendNumber (number%)                        'Used to send a number to connection.
 'Send out the number to the connection.
 PRINT #1, number%                              'Send out number.
END SUB                                         'End of sub.

