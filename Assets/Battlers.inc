 SECTION "Battlers", ROM0

KrisIdle::
INCBIN "Assets/Kris_Idle0-0.bin"
INCBIN "Assets/Kris_Idle0-1.bin"
INCBIN "Assets/Kris_Idle1-0.bin"
INCBIN "Assets/Kris_Idle1-1.bin"
INCBIN "Assets/Kris_Idle1-2.bin"
INCBIN "Assets/Kris_Idle1-3.bin"
INCBIN "Assets/Kris_Idle1-4.bin"
INCBIN "Assets/Kris_Idle2-0.bin"
INCBIN "Assets/Kris_Idle2-1.bin"
EndOfKris::

KrisPalettes::
INCBIN "Assets/Kris_IdlePal0.pal"
INCBIN "Assets/Kris_IdlePal1.pal"
INCBIN "Assets/Kris_IdlePal2.pal"

KrisRow0::
db KRIS_Y, KRIS_X, $10, 0
db KRIS_Y, KRIS_X+8, $12, 0
db KRIS_Y, KRIS_X+8*2, $14, 0
db KRIS_Y, KRIS_X+8*3, $16, 1
db KRIS_Y, KRIS_X+8*4, $18, 1

KrisRow1::
db KRIS_Y+16, KRIS_X, $1E, 2
db KRIS_Y+16, KRIS_X+8, $20, 2
db KRIS_Y+16, KRIS_X, $1A, 0
db KRIS_Y+16, KRIS_X+8, $1C, 0
db KRIS_Y+16, KRIS_X+8*2, $22, 1
db KRIS_Y+16, KRIS_X+8*3, $24, 1
db KRIS_Y+16, KRIS_X+8*2, $26, 2
db KRIS_Y+16, KRIS_X+8*2, $28, 0

KrisRow2::
db KRIS_Y+8*4, KRIS_X, $2A, 0
db KRIS_Y+8*4, KRIS_X+8, $2C, 0
db KRIS_Y+8*4, KRIS_X+8*2, $2E, 0
db KRIS_Y+8*4, KRIS_X+8, $30, 2
db KRIS_Y+8*4, KRIS_X+8*2, $32, 2
KrisRowEnd::
