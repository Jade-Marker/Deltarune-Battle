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
	
	;Asset includes
	INCLUDE "Assets/Tiles.z80"
	INCLUDE "Assets/BackgroundTiles16.inc"
	INCLUDE "Assets/Window.z80"
	INCLUDE "Assets/Background.z80"
	INCLUDE "Assets/Battlers.inc"

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

KRIS_X EQU 24 + OAM_X_OFS
KRIS_Y EQU 7 + OAM_Y_OFS

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
	call Scrolling
	call UpdateSpriteBuffer
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
	
	ld a, OCPSF_AUTOINC
	ld hl, KrisPal0
	ld b, 3 * PALETTE_SIZE
	LoadSpritePalettes
	
	ld a, LCDCF_ON | LCDCF_WINON | LCDCF_WIN9C00 | LCDCF_BG8000 | LCDCF_BG9800 | LCDCF_OBJON | LCDCF_OBJ16 | LCDCF_BGON
	ld [rLCDC], a
	
	ld a, STATF_LYC
	ld [rSTAT], a
	ld a, KRIS_Y + 16 - OAM_Y_OFS
	ld [rLYC], a				;Set the STAT interrupt to occur once the first row of Kris' sprites have been drawn
	
	ld a, IEF_VBLANK | IEF_STAT
	ld [rIE], a 
	ei
	
Main::
	halt
	jr Main

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
	ld hl, KrisRow0
	ld de, _OAMRAM
	ld bc, SPRITE_SIZE * (KrisRow2 - KrisRow0)/4
	call Memcpy		;Set the first 2 rows in preparation for the next frame
	
	ret

UpdateSpriteMidDraw::
	ld hl, KrisRow2
	ld de, _OAMRAM
	ld b, SPRITE_SIZE * (KrisRowEnd - KrisRow2)/4
	ScanlineMemcpy	;Since the first 5 sprites have been drawn, we can now reset them to draw the last row
	ret

	;Current plan is to allocate 14 sprites to each battler per 2 lines of sprites, and 3 palettes in total (but this could change if needed)
	;Then, you let the first row of sprites draw. While the 2nd row is being drawn, the first row is updated to represent the 3rd row. This continues until the sprite is drawn
	;One issue with this is that if we try to use any sprites for battle effects, they probably wont be drawn (only 10 sprites per line)
	;To get around this, we can treat oam as 3 buffers. The first 2 used for the battlers, and the 3rd used as general purpose
	;The portion of oam allocated to each could change each frame. This way, instead of shuffling sprites, we are shuffling the buffers
	
;*** End Of File ***