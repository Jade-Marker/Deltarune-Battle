;****************************************************************************************************************************************************
;*	DeltaruneBattle Source File
;*
;****************************************************************************************************************************************************
;*
;*
;****************************************************************************************************************************************************

;****************************************************************************************************************************************************
;*	Includes
;****************************************************************************************************************************************************
	;Program includes
	INCLUDE	"Includes/Hardware.inc"
	INCLUDE "Includes/Subroutines.inc"
	INCLUDE "Includes/Macros.inc"
	INCLUDE "Includes/Wram.inc"
	INCLUDE "Includes/gbt_player.inc"
	
	;Asset includes
	INCLUDE "Assets/Tiles.z80"
	INCLUDE "Assets/BackgroundTiles16.inc"
	INCLUDE "Assets/Window.z80"
	INCLUDE "Assets/Background.z80"
	INCLUDE "Assets/Battlers.inc"
	INCLUDE "Assets/RudeBuster.asm"

;****************************************************************************************************************************************************
;*	Constants
;****************************************************************************************************************************************************
TILE_SIZE EQU 16
PALETTE_SIZE EQU 8

WINDOW_POS EQU 14*8

SCROLLING_WIDTH EQU 2
SCROLLING_HEIGHT EQU 2
SCROLLING_START_SLOT EQU 3
NUM_SCROLLING_FRAMES EQU 16
SCROLLING_DELAY EQU 6

SPRITE_SIZE EQU 4

ANIM_FRAME_DELAY EQU 20

KRIS_X EQU 24 + OAM_X_OFS
KRIS_Y EQU 7 + OAM_Y_OFS
KRIS_NUM_FRAMES EQU 6

MAUS_X EQU 113 + OAM_X_OFS
MAUS_Y EQU 49 + OAM_Y_OFS
MAUS_PAL_START EQU 3
MAUS_TILE_START EQU $7E

SUSIE_X EQU 24 + OAM_X_OFS
SUSIE_Y EQU 65 + OAM_Y_OFS
SUSIE_TILE_START EQU $92

KRIS_LY_INT EQU KRIS_Y + 16 - OAM_Y_OFS
SUSIE_LY_INT_0 EQU KRIS_Y + 16*2 + 6 - OAM_Y_OFS
SUSIE_LY_INT_1 EQU SUSIE_Y + 16 - OAM_Y_OFS

;****************************************************************************************************************************************************
;*	cartridge header
;****************************************************************************************************************************************************

	SECTION	"Org $00",ROM0[$00]
RST_00:	
	jp	$100

	SECTION	"Org $08",ROM0[$08]
RST_08:	
	jp	$100

	SECTION	"Org $10",ROM0[$10]
RST_10:
	jp	$100

	SECTION	"Org $18",ROM0[$18]
RST_18:
	jp	$100

	SECTION	"Org $20",ROM0[$20]
RST_20:
	jp	$100

	SECTION	"Org $28",ROM0[$28]
RST_28:
	jp	$100

	SECTION	"Org $30",ROM0[$30]
RST_30:
	jp	$100

	SECTION	"Org $38",ROM0[$38]
RST_38:
	jp	$100

	SECTION	"V-Blank IRQ Vector",ROM0[$40]
VBL_VECT:
	call VblankInterrupt
	reti
	
	SECTION	"LCD IRQ Vector",ROM0[$48]
LCD_VECT:
	call UpdateSpriteMidDraw
	reti

	SECTION	"Timer IRQ Vector",ROM0[$50]
TIMER_VECT:
	reti

	SECTION	"Serial IRQ Vector",ROM0[$58]
SERIAL_VECT:
	reti

	SECTION	"Joypad IRQ Vector",ROM0[$60]
JOYPAD_VECT:
	reti
	
	SECTION	"Start",ROM0[$100]
	nop
	jp	Start

	; $0104-$0133 (Nintendo logo - do _not_ modify the logo data here or the GB will not run the program)
	DB	$CE,$ED,$66,$66,$CC,$0D,$00,$0B,$03,$73,$00,$83,$00,$0C,$00,$0D
	DB	$00,$08,$11,$1F,$88,$89,$00,$0E,$DC,$CC,$6E,$E6,$DD,$DD,$D9,$99
	DB	$BB,$BB,$67,$63,$6E,$0E,$EC,$CC,$DD,$DC,$99,$9F,$BB,$B9,$33,$3E

	; $0134-$013E (Game title - up to 11 upper case ASCII characters; pad with $00)
	DB	"DELTARUNE",0,0
		;0123456789A

	; $013F-$0142 (Product code - 4 ASCII characters, assigned by Nintendo, just leave blank)
	DB	"    "
		;0123

	; $0143 (Color GameBoy compatibility code)
	DB	$C0	; $00 - DMG 
			; $80 - DMG/GBC
			; $C0 - GBC Only cartridge

	; $0144 (High-nibble of license code - normally $00 if $014B != $33)
	DB	$00

	; $0145 (Low-nibble of license code - normally $00 if $014B != $33)
	DB	$00

	; $0146 (GameBoy/Super GameBoy indicator)
	DB	$00	; $00 - GameBoy

	; $0147 (Cartridge type - all Color GameBoy cartridges are at least $19)
	DB	$19	; $19 - ROM + MBC5

	; $0148 (ROM size)
	DB	$01	; $01 - 512Kbit = 64Kbyte = 4 banks

	; $0149 (RAM size)
	DB	$00	; $00 - None

	; $014A (Destination code)
	DB	$00	; $01 - All others
			; $00 - Japan

	; $014B (Licensee code - this _must_ be $33)
	DB	$33	; $33 - Check $0144/$0145 for Licensee code.

	; $014C (Mask ROM version - handled by RGBFIX)
	DB	$00

	; $014D (Complement check - handled by RGBFIX)
	DB	$00

	; $014E-$014F (Cartridge checksum - handled by RGBFIX)
	DW	$00


;****************************************************************************************************************************************************
;*	Program Start
;****************************************************************************************************************************************************

	SECTION "Program Start",ROM0[$0150]
Start::
	di
	ld sp, $FFFE	;set up stack pointer
	
	xor a
	ldh [rLCDC], a		;turn off the screen
	
	ld a, KEY1F_DBLSPEED | KEY1F_PREPARE
	ld [rKEY1], a
	stop	;Put cpu into double speed
	
	ld de, _RAM
	ld bc, 8192
	ld h, 0
	call Memset		;clear ram
	
	xor a
	ld hl, TilesCGB
	ld b, PaletteLength * PALETTE_SIZE
	call LoadPalettes
	
	ld hl, Tiles
	ld de, _VRAM + TILE_SIZE
	ld bc, TILE_SIZE * TilesLength
	call Memcpy		;Load tiles used for window
	
	ld hl, BackgroundTileset
	ld bc, TILE_SIZE * SCROLLING_WIDTH * SCROLLING_HEIGHT
	call Memcpy		;Load the background tiles into slot 3-6
	
	ld hl, Window
	ld de, _SCRN1
	ld c, WindowHeight
	call LoadMap
	
	ld hl, Background
	ld de, _SCRN0
	ld c, BackgroundHeight
	call LoadMap
	
	ld a, WX_OFS
	ld [rWX], a
	
	ld a, WINDOW_POS
	ld [rWY], a		;Move window to bottom of screen
	
	ld hl, KrisIdle
	ld de, $8100
	ld bc, EndOfKris - KrisIdle
	call Memcpy		;Load all the tiles used for Kris' idle sprite
	
	ld hl, MausIdle
	ld bc, EndOfMaus - MausIdle
	call Memcpy
	
	ld hl, SusieIdle
	ld bc, EndOfSusie - SusieIdle
	call Memcpy
	
	ld hl, KrisRow0
	ld de, Kris_Buffer
	ld bc, KrisRowEnd - KrisRow0
	call Memcpy
	
	ld a, 1
	ld [Kris_frame], a
	
	ld a, OCPSF_AUTOINC
	ld hl, KrisPalettes
	ld b, 3 * PALETTE_SIZE
	call LoadSpritePalettes
	
	ld a, OCPSF_AUTOINC | (MAUS_PAL_START << 3)
	ld hl, MausPalettes
	ld b, 3 * PALETTE_SIZE
	call LoadSpritePalettes
	
	ld a, LCDCF_ON | LCDCF_WINON | LCDCF_WIN9C00 | LCDCF_BG8000 | LCDCF_BG9800 | LCDCF_OBJON | LCDCF_OBJ16 | LCDCF_BGON
	ld [rLCDC], a
	
	ld a, STATF_LYC
	ld [rSTAT], a
	ld a, KRIS_LY_INT
	ld [rLYC], a				;Set the STAT interrupt to occur once the first row of Kris' sprites have been drawn
	
	ld a, 6
	ld bc, BANK(RudeBuster_data)
	ld de, RudeBuster_data
	call gbt_play
	call gbt_loop
	
	ld a, IEF_VBLANK | IEF_STAT
	ld [rIE], a 
	ei
	
Main::
	halt
	jr Main

VblankInterrupt::
	call Scrolling
	call UpdateKris
	call UpdateSpriteBuffer
	call gbt_update
	ret

Scrolling::
	ld a, [scrolling_delay]
	inc a
	ld [scrolling_delay], a
	cp SCROLLING_DELAY					;For SCROLLING_DELAY frames, don't scroll
	ret nz
	
	xor a
	ld [scrolling_delay], a
	
	ld a, [scrolling_tile_index]
	inc a
	cp NUM_SCROLLING_FRAMES					;Make sure scrolling_tile_index is in range
	jr nz, .write_back
	xor a
	
.write_back:
	ld [scrolling_tile_index], a
	
	ld hl, BackgroundTileset	;hl = BackgroundTileset + scrolling_tile_index * TILE_SIZE, or hl = BackgroundTileset[scrolling_tile_index]
	ld b, a
	ld e, TILE_SIZE * SCROLLING_WIDTH * SCROLLING_HEIGHT
	call Multiply
	
	ld de, _VRAM + TILE_SIZE * SCROLLING_START_SLOT
	ld bc, TILE_SIZE * SCROLLING_WIDTH * SCROLLING_HEIGHT
	call Memcpy				;Rewrite current tiles
	ret

UpdateSpriteBuffer::
	ld a, OCPSF_AUTOINC
	ld hl, KrisPalettes
	ld b, 3 * PALETTE_SIZE
	call LoadSpritePalettes

	ld hl, Kris_Buffer
	ld de, _OAMRAM
	ld b, SPRITE_SIZE * (KrisRow2 - KrisRow0)/4
	;call Memcpy		;Set the first 2 rows in preparation for the next frame
	ScanlineMemcpy
	
	;This needs to be scanlineMemcpy, since it sometimes overruns out of vblank
	ld hl, MausRow0
	ld de, $FE34
	ld b, SPRITE_SIZE * (MausRowEnd - MausRow0)/4
	ScanlineMemcpy
	
	ld a, KRIS_LY_INT
	ld [rLYC], a
	
	ret

UpdateSpriteMidDraw::
	ld a, [rLY]
	cp KRIS_LY_INT
	jr z, KrisUpdate
	cp SUSIE_LY_INT_0
	jr z, SusieUpdate0
	cp SUSIE_LY_INT_1
	jp z, SusieUpdate1
	
KrisUpdate::
	ld hl, KrisRow2
	ld de, _OAMRAM
	ld b, SPRITE_SIZE * (KrisRowEnd - KrisRow2)/4
	ScanlineMemcpy	;Since the first 5 sprites have been drawn, we can now reset them to draw the last row
	
	ld a, SUSIE_LY_INT_0
	ld [rLYC], a
	ret

SusieUpdate0::
	ld hl, SusieRow0
	ld de, _OAMRAM
	ld b, SPRITE_SIZE * ((SusieRow1 - SusieRow0)/4)
	ScanlineMemcpy
	push hl
	
	ld a, OCPSF_AUTOINC
	ld hl, SusiePalettes
	ld b, 3 * PALETTE_SIZE
	ScanlineLoadSpritePalettes
	
	pop hl
	ld b, SPRITE_SIZE * ((SusieRow2 - SusieRow1)/4) + 1
	ScanlineMemcpy
	
	ld a, SUSIE_LY_INT_1
	ld [rLYC], a
	ret
	
SusieUpdate1::
	ld hl, SusieRow2
	ld de, $FE40
	ld b, SPRITE_SIZE * (SusieRowEnd - SusieRow2)/4
	ScanlineMemcpy
	ret

UpdateKris::
	ld a, [Kris_counter]
	inc a
	ld [Kris_counter], a
	cp ANIM_FRAME_DELAY - 1
	ret nz
	
	xor a
	ld [Kris_counter], a
	
	ld a, [Kris_frame]
	or a
	jr z, .frame0
	cp 1
	jr z, .frame1
	cp 2
	jr z, .frame2
	cp 3
	jr z, .frame3
	cp 4
	jr z, .frame4
	jr .frame5
	
.frame0:
	ld hl, KrisRow0_0
	jr .updateBuffer
	
.frame1:
	ld hl, KrisRow1_0
	jr .updateBuffer
	
.frame2:
	ld hl, KrisRow2_0
	jr .updateBuffer
	
.frame3:
	ld hl, KrisRow3_0
	jr .updateBuffer

.frame4:
	ld hl, KrisRow4_0
	jr .updateBuffer

.frame5:
	ld hl, KrisRow5_0

.updateBuffer:
	ld de, Kris_Buffer + 2
	ld b, (KrisRowEnd - KrisRow0)/4
	call UpdateWramSpriteBuffer
	
	ld a, [Kris_frame]
	inc a
	
	cp KRIS_NUM_FRAMES
	jr nz, .storeFrame
	xor a
.storeFrame:
	ld [Kris_frame], a
	ret

;*** End Of File ***