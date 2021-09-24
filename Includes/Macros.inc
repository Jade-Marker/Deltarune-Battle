;uses a, b, hl
;a = OCPSF_AUTOINC | (initial palette no << 3)
;hl = src
;b = num palettes * PALETTE_SIZE
LoadSpritePalettes: MACRO	;This is a macro instead of a function so that it can be used for scanline stuff, since call and return add overhead
	ld [rOCPS], a
	
.loop\@:
	ld a, [hl+]
	ld [rOCPD], a
	
	dec b
	jr nz, .loop\@


ENDM

;uses a, b, de, hl
;hl = src
;de = dst
;b = count
ScanlineMemcpy: MACRO
	jr .loop\@
	
.check\@:
	ld a, e
	or a
	jr z, .loop\@	;if e = 0, then de = $FE00, so we haven't written any sprites

	dec hl
	dec de

.notFFLoop\@:
	ld a, [de]
	cp $FF
	jr z, .notFFLoop\@	;Wait until [de] isn't $FF, so that we can actually compare values
	
	cp [hl]
	jr z, .incThenLoop\@	;If z, then the last value is fine, so inc to go back
	inc b					;Else, leave hl and de decremented, and inc b since we need to rewrite a byte
	jr .loop\@
	
.incThenLoop\@:
	inc hl
	inc de
	
.loop\@:
	ld a, [rSTAT]
	bit 1, a
	jr nz, .check\@	;If we can't access OAM, then we should check if the last byte wrote okay
	
	ld a, [hl+]
	ld [de], a
	
	inc de
	dec b
	jr nz, .loop\@
	
;At this point, the most of the sprite has written okay, but we need to check if the last byte wrote okay
	
	inc b
	dec hl
	dec de
	
.notFFLoopFinal\@:
	ld a, [de]
	cp $FF
	jr z, .notFFLoopFinal\@	;Loop until we can read
	
	cp [hl]
	jr nz, .loop\@
	
ENDM
