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
INCBIN "Assets/Maus_IdlePal0.pal"
INCBIN "Assets/Maus_IdlePal1.pal"

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

SusieIdle::
INCBIN "Assets/Susie_Idle0-0.bin"
INCBIN "Assets/Susie_Idle0-1.bin"
INCBIN "Assets/Susie_Idle0-2.bin"
EndOfSusie::

SusiePalettes::
INCBIN "Assets/Susie_IdlePal0.pal"
INCBIN "Assets/Susie_IdlePal1.pal"
INCBIN "Assets/Susie_IdlePal2.pal"

SUSIE_X EQU 24 + OAM_X_OFS
SUSIE_Y EQU 65 + OAM_Y_OFS

SusieRow0::
db SUSIE_Y, SUSIE_X+8*0, $4C, 0
db SUSIE_Y, SUSIE_X+8*1, $4E, 0
db SUSIE_Y, SUSIE_X+8*2, $50, 0
db SUSIE_Y, SUSIE_X+8*3, $52, 0
db SUSIE_Y, SUSIE_X+8*1, $62, 1
db SUSIE_Y, SUSIE_X+8*2+1, $64, 1

db SUSIE_Y+4, SUSIE_X-8*3+2, $74, 2
db SUSIE_Y+10, SUSIE_X-8*2+2, $76, 2
db SUSIE_Y+8, SUSIE_X-8*1+2, $78, 2
db SUSIE_Y, SUSIE_X+8*3, $7C, 2

SusieRow1::
db SUSIE_Y+16, SUSIE_X-8*1+2, $54, 0
db SUSIE_Y+16, SUSIE_X+8*0+2, $56, 0
db SUSIE_Y+16, SUSIE_X+8*1+2, $58, 0
db SUSIE_Y+16, SUSIE_X+8*2+2, $5A, 0
db SUSIE_Y+16, SUSIE_X+8*0+3, $68, 1
db SUSIE_Y+16, SUSIE_X+8*1+3, $6A, 1

SusieRow2::
db SUSIE_Y+16*2, SUSIE_X+8*0-3, $5C, 0
db SUSIE_Y+16*2, SUSIE_X+8*1-3, $5E, 0
db SUSIE_Y+16*2, SUSIE_X+8*2-3, $60, 0
db SUSIE_Y+16*2, SUSIE_X+8*0-1, $6E, 1
db SUSIE_Y+16*2, SUSIE_X+8*1-1, $70, 1
db SUSIE_Y+16*2, SUSIE_X+8*2-1, $72, 1
SusieRowEnd::
