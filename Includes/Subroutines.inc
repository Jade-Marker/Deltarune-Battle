	SECTION "Subroutines",ROM0
	
;uses a, bc, de, hl
;hl = src
;de = dst
;bc = count
Memcpy::
	ld a, [hl+]
	ld [de], a
	
	inc de
	dec bc
	
	ld a, b
	or c
	jr nz, Memcpy
	
	ret

;uses a, bc, de, hl
;h = value
;de = dst
;bc = count
Memset::
	ld a, h
	ld [de], a
	
	inc de
	dec bc
	
	ld a, b
	or c
	jr nz, Memset
	ret

;uses bc, de, hl
;b = multiplicand
;e = multiplier
;hl = result + inital hl value
Multiply::
	ld d, 0
	ld c, 8

loop:
	bit 0, b
	jr z, add_skip
	
	add hl, de
	
add_skip:
	srl b
	
	sla e
	rl d
	
	dec c
	jr nz, loop
	
	ret

;uses a, b, hl
;a = initial palette
;hl = src
;b = num palettes * PALETTE_SIZE
LoadPalettes::
	sla a
	sla a
	sla a
	or a, BCPSF_AUTOINC
	ld [rBCPS], a
	
.loop:
	ld a, [hl+]
	ld [rBCPD], a
	
	dec b
	jr nz, .loop
	ret

;uses a, bc, de, hl
;hl = src
;c = map height
;de = dst
LoadMap::
	ld b, 20
	
	push bc
	push de

	xor a
	ld [rVBK], a
	call LoadPlane
	
	pop de
	pop bc
	
	ld a, 1
	ld [rVBK], a
	call LoadPlane
	
	xor a
	ld [rVBK], a
	ret

LoadPlane::
.start:
	push bc
	
.loop:
	ld a, [hl+]
	ld [de], a
	inc de
	
	dec b
	jr nz, .loop
	
	pop bc
	
	ld a, e		;de += 12 to skip over the rest of the line
	add 12
	ld e, a
	
	ld a, d
	adc 0
	ld d, a
	
	dec c
	jr nz, .start
	ret
	
;uses a, b, hl
;a = OCPSF_AUTOINC | (initial palette no << 3)
;hl = src
;b = num palettes * PALETTE_SIZE
LoadSpritePalettes::
	ld [rOCPS], a
	
.loop:
	ld a, [hl+]
	ld [rOCPD], a
	
	dec b
	jr nz, .loop
	
	ret

;uses a, b, de, hl
;hl = src
;de = dst
;b = Num tiles to update
UpdateWramSpriteBuffer::
	ld a, [hl+]
	ld [de], a
	
	inc de
	inc de
	inc de
	inc de
	
	dec b
	jr nz, UpdateWramSpriteBuffer
	ret
	
	