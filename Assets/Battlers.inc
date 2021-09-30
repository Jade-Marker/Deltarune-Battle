 SECTION "Battlers", ROM0

KrisIdle::
INCBIN "Assets/Kris_Idle0-0.bin"
INCBIN "Assets/Kris_Idle0-1.bin"
INCBIN "Assets/Kris_Idle0-2.bin"

INCBIN "Assets/Kris_Idle1-0.bin"
INCBIN "Assets/Kris_Idle1-2.bin"

INCBIN "Assets/Kris_Idle2-0.bin"
INCBIN "Assets/Kris_Idle2-2.bin"

INCBIN "Assets/Kris_Idle3-0.bin"
INCBIN "Assets/Kris_Idle3-2.bin"

INCBIN "Assets/Kris_Idle4-0.bin"
INCBIN "Assets/Kris_Idle4-2.bin"

INCBIN "Assets/Kris_Idle5-0.bin"
INCBIN "Assets/Kris_Idle5-2.bin"
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

KrisRow0_0::
db $10
db $12
db $14
db $24
db $26

db $16
db $18
db $1A
db $28
db $2A
db $2C
db $2E
db $30

db $1E
db $20
db $22
db $34
db $36

KrisRow1_0::
db $38
db $3A
db $3C
db $24
db $26

db $3E
db $40
db $1A
db $28
db $2A
db $42
db $44
db $30

db $1E
db $20
db $22
db $34
db $36

KrisRow2_0::
db $46
db $48
db $4A
db $24
db $26

db $4C
db $4E
db $1A
db $28
db $2A
db $50
db $52
db $30

db $1E
db $20
db $22
db $34
db $36

KrisRow3_0::
db $54
db $56
db $58
db $24
db $26

db $5A
db $5C
db $1A
db $28
db $2A
db $5E
db $60
db $30

db $1E
db $20
db $22
db $34
db $36

KrisRow4_0::
db $62
db $64
db $66
db $24
db $26

db $68
db $6A
db $1A
db $28
db $2A
db $6C
db $6E
db $30

db $1E
db $20
db $22
db $34
db $36

KrisRow5_0::
db $70
db $72
db $74
db $24
db $26

db $76
db $78
db $1A
db $28
db $2A
db $7A
db $7C
db $30

db $1E
db $20
db $22
db $34
db $36

MausIdle::
INCBIN "Assets/Maus_Idle0-0.bin"
INCBIN "Assets/Maus_Idle0-1.bin"
EndOfMaus::

MausPalettes::
INCBIN "Assets/Maus_IdlePal0.pal"
INCBIN "Assets/Maus_IdlePal1.pal"

MausRow0::
db MAUS_Y, MAUS_X+8*0, MAUS_TILE_START+2*0, MAUS_PAL_START + 0
db MAUS_Y, MAUS_X+8*1, MAUS_TILE_START+2*1, MAUS_PAL_START + 0
db MAUS_Y, MAUS_X+8*2, MAUS_TILE_START+2*2, MAUS_PAL_START + 0
db MAUS_Y, MAUS_X+8*3, MAUS_TILE_START+2*3, MAUS_PAL_START + 0
db MAUS_Y, MAUS_X+8*4, MAUS_TILE_START+2*4, MAUS_PAL_START + 0

db MAUS_Y, MAUS_X+8*0, MAUS_TILE_START+2*5, MAUS_PAL_START + 1
db MAUS_Y, MAUS_X+8*1, MAUS_TILE_START+2*6, MAUS_PAL_START + 1
db MAUS_Y, MAUS_X+8*4, MAUS_TILE_START+2*9, MAUS_PAL_START + 1
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

SusieRow0::
db SUSIE_Y, SUSIE_X+8*0, SUSIE_TILE_START+2*0, 0
db SUSIE_Y, SUSIE_X+8*1, SUSIE_TILE_START+2*1, 0
db SUSIE_Y, SUSIE_X+8*2, SUSIE_TILE_START+2*2, 0
db SUSIE_Y, SUSIE_X+8*3, SUSIE_TILE_START+2*3, 0
db SUSIE_Y, SUSIE_X+8*1, SUSIE_TILE_START+2*11, 1
db SUSIE_Y, SUSIE_X+8*2+1, SUSIE_TILE_START+2*12, 1

db SUSIE_Y+4, SUSIE_X-8*3+2, SUSIE_TILE_START+2*20, 2
db SUSIE_Y+10, SUSIE_X-8*2+2, SUSIE_TILE_START+2*21, 2
db SUSIE_Y+8, SUSIE_X-8*1+2, SUSIE_TILE_START+2*22, 2
db SUSIE_Y, SUSIE_X+8*3, SUSIE_TILE_START+2*24, 2

SusieRow1::
db SUSIE_Y+16, SUSIE_X-8*1+2, SUSIE_TILE_START+2*4, 0
db SUSIE_Y+16, SUSIE_X+8*0+2, SUSIE_TILE_START+2*5, 0
db SUSIE_Y+16, SUSIE_X+8*1+2, SUSIE_TILE_START+2*6, 0
db SUSIE_Y+16, SUSIE_X+8*2+2, SUSIE_TILE_START+2*7, 0
db SUSIE_Y+16, SUSIE_X+8*0+3, SUSIE_TILE_START+2*14, 1
db SUSIE_Y+16, SUSIE_X+8*1+3, SUSIE_TILE_START+2*15, 1

SusieRow2::
db SUSIE_Y+16*2, SUSIE_X+8*0-3, SUSIE_TILE_START+2*8, 0
db SUSIE_Y+16*2, SUSIE_X+8*1-3, SUSIE_TILE_START+2*9, 0
db SUSIE_Y+16*2, SUSIE_X+8*2-3, SUSIE_TILE_START+2*10, 0
db SUSIE_Y+16*2, SUSIE_X+8*0-1, SUSIE_TILE_START+2*17, 1
db SUSIE_Y+16*2, SUSIE_X+8*1-1, SUSIE_TILE_START+2*18, 1
db SUSIE_Y+16*2, SUSIE_X+8*2-1, SUSIE_TILE_START+2*19, 1
SusieRowEnd::
