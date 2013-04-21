DECLARE SUB Blur (x%, y%, x2%, y2%)
DECLARE SUB DrawMap (sx%, sy%, sw%, sh%, x%, y%)
SCREEN 13
CLS

RANDOMIZE TIMER

FOR i = 1 TO 32
 PALETTE i, i / 4 + 15
NEXT i

FOR i = 32 TO 64
 PALETTE i, i / 8 + 15
NEXT i

FOR i = 64 TO 128
 PALETTE i, i / 16 + 15
NEXT i

FOR i = 0 TO 1000
 PSET (RND * 50, RND * 50), INT(RND * 255)
NEXT i

FOR i = 1 TO 10
 Blur 1, 1, 51, 51
NEXT i

DrawMap 2, 2, 49, 49, 100, 100

SUB Blur (x%, y%, x2%, y2%)
 FOR lx = x% TO x2%
  FOR ly = y% TO y2%
   pow = POINT(lx, ly) + POINT(lx - 1, ly) + POINT(lx + 1, ly) + POINT(lx, ly - 1) + POINT(lx, ly + 1)
   pow = pow / 5
   PSET (lx, ly), pow
  NEXT ly
 NEXT lx
END SUB

SUB DrawMap (sx%, sy%, sw%, sh%, x%, y%)
 FOR ly = sy% TO sh%
  FOR lx = sx% TO sw%
   c = POINT(lx, ly)
   dy = ly + (-c / 2)
   LINE (x% + lx + ly, y% + ly)-(x% + lx + ly, y% + dy), c, BF
  NEXT lx
 NEXT ly
END SUB

