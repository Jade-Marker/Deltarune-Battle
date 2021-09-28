 SECTION "Battlers", ROM0

KrisIdle::
INCBIN "Assets/Kris_Idle0-0.bin"
INCBIN "Assets/Kris_Idle0-1.bin"
INCBIN "Assets/Kris_Idle0-2.bin"
EndOfKris::

KrisPalettes::
INCBIN "Assets/Kris_IdlePal0.pal"
INCBIN "Assets/Kris_IdlePal1.pal"
INCBIN "Assets/Kris_IdlePal2.pal"

KrisRow0::
db KRIS_Y, KRIS_X, $10, 0
db KRIS_Y, KRIS_X+8, $12, 0
db KRIS_Y, KRIS_X+8*2, $14, 0
db KRIS_Y, KRIS_X+8*3, $24, 1
db KRIS_Y, KRIS_X+8*4, $26, 1

KrisRow1::
db KRIS_Y+16, KRIS_X, $16, 0
db KRIS_Y+16, KRIS_X+8, $18, 0
db KRIS_Y+16, KRIS_X+8*2, $1A, 0
db KRIS_Y+16, KRIS_X+8*2, $28, 1
db KRIS_Y+16, KRIS_X+8*3, $2A, 1
db KRIS_Y+16, KRIS_X, $2C, 2
db KRIS_Y+16, KRIS_X+8, $2E, 2
db KRIS_Y+16, KRIS_X+8*2, $30, 2

KrisRow2::
db KRIS_Y+8*4, KRIS_X, $1E, 0
db KRIS_Y+8*4, KRIS_X+8, $20, 0
db KRIS_Y+8*4, KRIS_X+8*2, $22, 0
db KRIS_Y+8*4, KRIS_X+8, $34, 2
db KRIS_Y+8*4, KRIS_X+8*2, $36, 2
KrisRowEnd::

MausIdle::
INCBIN "Assets/Maus_Idle0-0.bin"
INCBIN "Assets/Maus_Idle0-1.bin"
EndOfMaus::

MausPalettes::
INCBIN "Assets/Maus_Idle0-0.pal"
INCBIN "Assets/Maus_Idle0-1.pal"

MausRow0::
db MAUS_Y, MAUS_X+8*0, $38, MAUS_PAL_START + 0
db MAUS_Y, MAUS_X+8*1, $3A, MAUS_PAL_START + 0
db MAUS_Y, MAUS_X+8*2, $3C, MAUS_PAL_START + 0
db MAUS_Y, MAUS_X+8*3, $3E, MAUS_PAL_START + 0
db MAUS_Y, MAUS_X+8*4, $40, MAUS_PAL_START + 0

db MAUS_Y, MAUS_X+8*0, $42, MAUS_PAL_START + 1
db MAUS_Y, MAUS_X+8*1, $44, MAUS_PAL_START + 1
db MAUS_Y, MAUS_X+8*4, $4A, MAUS_PAL_START + 1
MausRowEnd::
