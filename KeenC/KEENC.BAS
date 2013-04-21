CLS
DIM spot AS LONG
DIM SHARED flname AS STRING
DIM FileCount AS LONG
 tc = 0
 DO
  LOCATE 1, 1
  PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
  PRINT "³     Saved Keen games     ³"
  PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
  IF LEN(DIR$("savegam0.ck4")) > 0 THEN PRINT " 1 - Game save one."
  IF LEN(DIR$("savegam1.ck4")) > 0 THEN PRINT " 2 - Game save two."
  IF LEN(DIR$("savegam2.ck4")) > 0 THEN PRINT " 3 - Game save three."
  IF LEN(DIR$("savegam3.ck4")) > 0 THEN PRINT " 4 - Game save four."
  IF LEN(DIR$("savegam4.ck4")) > 0 THEN PRINT " 5 - Game save five."
  IF LEN(DIR$("savegam5.ck4")) > 0 THEN PRINT " 6 - Game save six."
  PRINT " 7 - No save games so exit."
  key$ = INKEY$
  SELECT CASE key$
   CASE "1":
    IF LEN(DIR$("savegam0.ck4")) > 0 THEN
     flname = "savegam0.ck4"
     tc = 1
    END IF
   CASE "2":
    IF LEN(DIR$("savegam1.ck4")) > 0 THEN
     flname = "savegam1.ck4"
     tc = 1
    END IF
   CASE "3":
    IF LEN(DIR$("savegam2.ck4")) > 0 THEN
     flname = "savegam2.ck4"
     tc = 1
    END IF
   CASE "4":
    IF LEN(DIR$("savegam3.ck4")) > 0 THEN
     flname = "savegam3.ck4"
     tc = 1
    END IF
   CASE "5":
    IF LEN(DIR$("savegam4.ck4")) > 0 THEN
     flname = "savegam4.ck4"
     tc = 1
    END IF
   CASE "6":
    IF LEN(DIR$("savegam5.ck4")) > 0 THEN
     flname = "savegam5.ck4"
     tc = 1
    END IF
   CASE "7":
    CLS
    PRINT "Thanks for using Keen Cheat Master By Elias York."
    END
  END SELECT
LOOP UNTIL tc = 1
CLS
DO
 LOCATE 1, 1
 PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
 PRINT "³      Keen cheat master.      ³"
 PRINT "³       By Elias York          ³"
 PRINT "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
 PRINT "³  Editing file:  "; flname
 LOCATE 5, 32: PRINT "³"
 PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
 PRINT "   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
 PRINT "   ³   1 - Set Keen Lives   ³"
 PRINT "   ³   2 - Set Keen Score   ³"
 PRINT "   ³   3 - Set Keen Shots   ³"
 PRINT "   ³   4 - Set Save Name    ³"
 PRINT "   ³   5 - Set Keen Drops   ³"
 PRINT "   ³   6 - Set Dif Level    ³"
 PRINT "   ³   7 - Deck Out Keens   ³"
 PRINT "   ³   8 - Exit Keen Cheat  ³"
 PRINT "   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
 key$ = INKEY$
 SELECT CASE key$
  CASE "1":   'Set lives
   dat% = 0
   OPEN "B", #1, flname
    SEEK #1, 123
    GET #1, , dat%
   CLOSE #1
   PRINT " Current Lives in savefile = "; dat%
   INPUT " Please enter the number of lives you want:> "; num%
   IF num% = 0 OR num% > 255 THEN
    PRINT " Error need a number of lives to set using default 255"
    PRINT " Press any key to go on."
    SLEEP
    num% = 255
    CLS
   ELSE
   END IF
   OPEN "B", #1, flname
    SEEK #1, 123
    data$ = CHR$(num%)
    PUT #1, , data$
   CLOSE #1
   PRINT " Set Keen's lives to "; num%
   PRINT " Press any key to go on."
   SLEEP
   CLS
  CASE "2":        'Set score.
   dat% = 0
   OPEN "B", #1, flname
    SEEK #1, 97
    GET #1, , dat%
   CLOSE #1
   PRINT " Current Score in savefile = "; dat%
   INPUT " Please enter the score you want:> "; num%
   IF num% = 0 OR num% > 255 THEN
    PRINT " Error need a score to set using default 255"
    PRINT " Press any key to go on."
    SLEEP
    num% = 255
    CLS
   ELSE
   END IF
   OPEN "B", #1, flname
    SEEK #1, 97
    data$ = CHR$(num%)
    PUT #1, , data$
   CLOSE #1
   PRINT " Set Keen's score to "; num%
   PRINT " Press any key to go on."
   SLEEP
   CLS
  CASE "3":             'Set shots
   dat% = 0
   OPEN "B", #1, flname
    SEEK #1, 105
    GET #1, , dat%
   CLOSE #1
   PRINT " Current Number of Shots in savefile = "; dat%
   INPUT " Please enter the number of shots you want:> "; num%
   IF num% = 0 OR num% > 255 THEN
    PRINT " Error need a number of shots to set using default 255"
    PRINT " Press any key to go on."
    SLEEP
    num% = 255
    CLS
   ELSE
   END IF
   OPEN "B", #1, flname
    SEEK #1, 105
    data$ = CHR$(num%)
    PUT #1, , data$
   CLOSE #1
   PRINT " Set Keen's shots to "; num%
   PRINT " Press any key to go on."
   SLEEP
   CLS
  CASE "4":        'Set Name.
   INPUT " Enter new name for savegame:> "; data$
   IF data$ = "" THEN data$ = "Game"
   data$ = data$ + CHR$(0)
   OPEN "B", #1, flname
    SEEK #1, 9
    PUT #1, , data$
   CLOSE #1
   PRINT " Set savename to "; data$
   PRINT " Press any key to go on."
   SLEEP
   CLS
  CASE "5":     'Set drops.
   dat% = 0
   OPEN "B", #1, flname
    SEEK #1, 107
    GET #1, , dat%
   CLOSE #1
   PRINT " Current Number of Drops in savefile = "; dat%
   INPUT " Please enter the number of drops you want:> "; num%
   IF num% = 0 OR num% > 255 THEN
    PRINT " Error need a number of drops to set, using default 255"
    PRINT " Press any key to go on."
    SLEEP
    num% = 255
    CLS
   ELSE
   END IF
   OPEN "B", #1, flname
    SEEK #1, 107
    data$ = CHR$(num%)
    PUT #1, , data$
   CLOSE #1
   PRINT " Set Keen drops to "; num%
   PRINT " Press any key to go on."
   SLEEP
   CLS
  CASE "6":     'Set diff.
   CLS
   tc = 0
   dat% = 0
   OPEN "B", #1, flname
    SEEK #1, 125
    GET #1, , dat%
   CLOSE #1
   IF dat% = 1 THEN CLev$ = "Easy."
   IF dat% = 2 THEN CLev$ = "Normal."
   IF dat% = 3 THEN CLev$ = "Hard."
   DO
    LOCATE 1, 1
    PRINT " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
    PRINT " ³   Set Keen Dif Level   ³"
    PRINT " ³   Current Diff "; CLev$
    LOCATE 3, 27: PRINT "³"
    PRINT " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
    PRINT "  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
    PRINT "  ³ 1 - Set Dif To Easy  ³"
    PRINT "  ³ 2 - Set Dif To Normal³"
    PRINT "  ³ 3 - Set Dif To Hard  ³"
    PRINT "  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
    SELECT CASE INKEY$
     CASE "1":
      data$ = CHR$(1)
      tc = 1
     CASE "2":
      data$ = CHR$(2)
      tc = 1
     CASE "3":
      data$ = CHR$(3)
      tc = 1
    END SELECT
   LOOP UNTIL tc = 1
   tc = 0
   OPEN "B", #1, flname
    SEEK #1, 125
    PUT #1, , data$
   CLOSE #1
   IF data$ = CHR$(1) THEN Lev$ = "Easy."
   IF data$ = CHR$(2) THEN Lev$ = "Normal."
   IF data$ = CHR$(3) THEN Lev$ = "Hard."
   PRINT " Set Dif Level to "; Lev$
   PRINT " Press any key to go on."
   SLEEP
   CLS
  CASE "7":     'Deck out.
   OPEN "B", #1, flname
    data$ = CHR$(255)
    SEEK #1, 105
    PUT #1, , data$
    SEEK #1, 97
    PUT #1, , data$
    SEEK #1, 123
    PUT #1, , data$
    SEEK #1, 107
    PUT #1, , data$
   CLOSE #1
   PRINT " All stats set to 255"
   PRINT " Press any key to go on."
   SLEEP
   CLS
  CASE "8":
   CLS
   PRINT "Thanks for using Keen Cheat Master By Elias York."
   END
 END SELECT
LOOP

