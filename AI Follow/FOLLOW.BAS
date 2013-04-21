DECLARE SUB MoveAI ()
SCREEN 12

'Dim variables.
DIM SHARED px AS INTEGER, py AS INTEGER
DIM SHARED ex AS INTEGER, ey AS INTEGER

'Set variables.
px = 90
py = 90
ex = 20
ey = 20

'Main loop.
DO
 SELECT CASE INKEY$
  CASE "a": 'left
   px = px - 5
  CASE "d": 'right
   px = px + 5
  CASE "w": 'up
   py = py - 5
  CASE "s": 'down
   py = py + 5
  CASE CHR$(27): EXIT DO
 END SELECT
 GOSUB drawit
LOOP
END

drawit:
 CIRCLE (px, py), 5, 2
 MoveAI
 CIRCLE (ex, ey), 3, 1
RETURN

SUB MoveAI
 face = ATN(px / py)

 dx = (ex * COS(face) + SIN(face) * ey) + ex
 dy = (ex * SIN(face) - COS(face) * ey) + ey

 ex = dx
 ey = dy
END SUB

