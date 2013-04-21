DECLARE FUNCTION ReadByte! (ofs%)
DECLARE SUB StatsEditMenu ()
DECLARE SUB WriteByte (ofs%, dat%)
DECLARE SUB CloseCharacter ()
DECLARE FUNCTION OpenCharacter! (n$)
DECLARE SUB MsgWin (s$, t%, ff%)
DECLARE SUB TitleMenu ()
DECLARE SUB TxtWin (x%, y%, w%, h%, f%)
'This program was written by Elias York.
'Date: 03/10/2003
'This is a Diablo 2 Save Game Editor.

'------------------ Defines --------------------'
CONST MAXVALUE = 255                            'Define biggest value to save in one byte.
CONST VERSION = "V1.0"                          'Define program version.
CONST MSGBOXWAITKEY = 0                         'Define message box wait for key flag.
CONST MSGBOXNOWAIT = -5                         'Define no waiting message box.
CONST YES = -1                                  'Define Yes.
CONST NO = 0                                    'Define No.

'Define HEX Offsets.
CONST PLAYERSTASH = 259                         ' Define player stash offset.
CONST PLAYERSTR = -1                            ' Define player strangth.

'----------------- Variables -------------------'
DIM SHARED CHARACTEROPEN AS INTEGER             'Define open character flag.

'---------------- Main Driver ------------------'

'Set screen mode to 640x480x16
SCREEN 12

'Show title screen.
TitleMenu

'Say good bye to user and thank them.
MsgWin "Good Bye User!~~Thank you for using D2-EDIT " + VERSION + "." + "~~Press any key.", MSGBOXWAITKEY, YES

'Close character file if it has not been done yet.
CloseCharacter

'End of program code here.
END

SUB CloseCharacter                              'Use to close character file.
 'Close file.
 CLOSE #1

 'Turn open flag off.
 CHARACTEROPEN = NO
END SUB

SUB MsgWin (s$, t%, ff%)
 'Set break line counter and other counters to zero.
 lbc% = 0
 l% = 0
 lc% = 0

 'Find linebreaks.
 FOR i = 1 TO LEN(s$)
  'If a line break add to count.
  IF MID$(s$, i, 1) = "~" THEN lbc% = lbc% + 1
 NEXT i

 'Find longest string in message.
 FOR i = 1 TO LEN(s$)
  'If a line break then reset count.
  IF MID$(s$, i, 1) = "~" THEN
    lc% = 0
   ELSE
    'Add to counter.
    lc% = lc% + 1
  END IF

  'If large count if bigger then add to it.
  IF lc% > l% THEN l% = lc%
 NEXT i

 'Create window frame.
 TxtWin 41 - (l% / 2), 13 - (lbc% / 2), 3 + l%, 2 + lbc%, ff%

 'Get starting x and y.
 x% = 43 - (l% / 2)
 y% = 14 - (lbc% / 2)

 'Write out message inside the window.
 FOR i = 1 TO LEN(s$)
  LOCATE y%, x%
  IF MID$(s$, i, 1) = "~" THEN
    y% = y% + 1
    x% = 43 - (l% / 2)
   ELSE
    PRINT MID$(s$, i, 1)
    x% = x% + 1
  END IF
 NEXT i

 'Wait for time of key press.
 IF t% <> MSGBOXNOWAIT THEN SLEEP t%
END SUB

FUNCTION OpenCharacter (n$)                      'Use to open a character file.
 'See if the file is there.
 IF DIR$(n$ + ".d2s") <> "" THEN
  'Open the character for binary access.
  OPEN n$ FOR BINARY AS #1

  'Set character open flag to on.
  CHARACTEROPEN = YES

  'Return yes character was opened.
  OpenCharacter = YES
 ELSE
  'Return no character file is not there.
  OpenCharacter = NO

 'Done checking.
 END IF
END FUNCTION

FUNCTION ReadByte (ofs%)                         'Use to read a byte from a character file.
 'Check to see if a file is open.
 IF CHARACTEROPEN = YES THEN
   'Get data from character save file.
   SEEK #1, ofs%
   GET #1, , dat%

   'Return data from file.
   ReadByte = dat%
  ELSE
   'Tell user there was a error.
   MsgWin "~No character opened to edit!~Open a character before trying to edit one.~~Press any key.", MSGBOXWAITKEY, YES
 END IF
END FUNCTION

SUB StatsEditMenu                               'Use to show the stats editor.
 'Clear screen.
 CLS

 'Start stats editor loop.
 DO

  MsgWin "~Character Stats Editor~~1 - Edit Hp.~2 - Edit Mana.~S - Show Character Stats.~X - Quit Stats Editor.", MSGBOXNOWAIT, NO
  'Look at keyboard.
  SELECT CASE UCASE$(INKEY$)
   CASE "X": EXIT DO
   CASE "S":
    'Get player stash value.
    stash! = ReadByte(259) * ReadByte(260)

    'Make output string.
    oo$ = "~Stash: " + STR$(stash!) + "~"

    'Display character stats,
    MsgWin oo$, MSGBOXWAITKEY, YES

    'Clear screen so menu looks good.
    CLS
  'Done looking.
  END SELECT
 'End of stats editor loop.
 LOOP
END SUB

SUB TitleMenu                                   'Use to show the title window and all options.
 'Clear screen.
 CLS

 'Start menu loop.
 DO

 'Draw Title window.
 TxtWin 34, 8, 14, 2, NO
 LOCATE 9, 36: PRINT "D2-EDIT "; UCASE$(VERSION)

 'Draw menu window and options.
 TxtWin 26, 11, 30, 8, NO
 LOCATE 12, 31: PRINT "1 - Change Class."
 LOCATE 13, 31: PRINT "2 - Change Stats."
 LOCATE 14, 31: PRINT "3 - Change Skill Points."
 LOCATE 15, 31: PRINT "4 - Change Exp."
 LOCATE 16, 31: PRINT "5 - Change Stash."
 LOCATE 17, 31: PRINT "L - Load Character."
 LOCATE 18, 31: PRINT "X - Exit Editor."

 'Watch keyboard controls.
 SELECT CASE UCASE$(INKEY$)
  CASE "X": EXIT DO
  CASE "2":
   'Show stats editor.
   StatsEditMenu

   'Clear screen.
   CLS
  CASE "5":
   IF CHARACTEROPEN = YES THEN
     'Set stash.
     WriteByte PLAYERSTASH, MAXVALUE

     'Tell user that the stash has been set to a lot.
     MsgWin "~Stash has been set to a very very big number enjoy.~~Press any key.", MSGBOXWAITKEY, YES
    ELSE
     MsgWin "~No character opened to edit!~Open a character before trying to edit one.~~Press any key.", MSGBOXWAITKEY, YES
   END IF
   'Clear screen so title menu looks nice.
   CLS
  CASE "L":
   TxtWin 27, 12, 17, 4, YES
   LOCATE 13, 28
   PRINT "Character Name: "
   LOCATE 14, 29
   INPUT "", FileName$
   IF FileName$ <> "" THEN
    MsgWin "Character name entered!~~Trying to open character " + FileName$ + "~~Please wait.", 1, YES
    'Try and open character file.
    IF OpenCharacter(FileName$) = YES THEN
     'Character file is opened.
     MsgWin "Character file " + FileName$ + ".D2S opened!~~Press any key.", MSGBOXWAITKEY, YES
    ELSE
     'Can't open character file.
     MsgWin "Can't open character file " + FileName$ + ".D2S~~Press any key.", MSGBOXWAITKEY, YES
    END IF
   END IF

   'Clear screen so menu looks good.
   CLS
 'Done watching.
 END SELECT

 'End of menu loop.
 LOOP
END SUB

SUB TxtWin (x%, y%, w%, h%, f%)
 'Loop through all.
 FOR ly% = y% TO y% + h%
  FOR lx% = x% TO x% + w%
   'Move text cursor to x and y.
   LOCATE ly%, lx%

   IF ly% = (y%) AND lx% = (x%) THEN
     PRINT "Ú";
    ELSEIF lx% = (x% + w%) AND ly% = y% THEN
     PRINT "¿"
    ELSEIF lx% = (x% + w%) AND ly% = y% + h% THEN
     PRINT "Ù"
    ELSEIF ly% = (y% + h%) AND lx% = (x%) THEN
     PRINT "À";
    ELSEIF lx% = x% OR lx% = x% + w% THEN
     PRINT "³"
    ELSEIF ly% = y% OR ly% = y% + h% THEN
     PRINT "Ä";
    ELSEIF f% = YES THEN PRINT " ";
   END IF
  NEXT lx%
 NEXT ly%
END SUB

SUB WriteByte (ofs%, dat%)                      'Use to write a byte to character files.
 'Check to see if a file is open.
 IF CHARACTEROPEN = YES THEN
    SEEK #1, ofs% - 1
    data$ = CHR$(dat%)
    PUT #1, , data$
  ELSE
   MsgWin "~No character opened to edit!~Open a character before trying to edit one.~~Press any key.", MSGBOXWAITKEY, YES
 END IF
END SUB

