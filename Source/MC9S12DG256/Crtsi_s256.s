;	C STARTUP FOR MC68HC12
;	WITH AUTOMATIC DATA INITIALISATION
;	Copyright (c) 2000 by COSMIC Software
;
	xdef	__reset
	xdef	_exit, __stext
	xref	_main, __sbss, __memory, __idesc__, __stack
	
; this is function void _stext(void)
; PIC = position independent code
__stext:
__reset:
	lds	#__stack	; initialize stack pointer
ifdef PIC
	leax	__idesc__,pcr	; descriptor address
	tfr	x,d		; compute
	subd	#__idesc__	; code offset
	pshd			; on the stack
else
	ldx	#__idesc__	; descriptor address
endif
	ldy	2,x+		; start address of prom data
ibcl:
	ldaa	5,x+		; test flag byte
	beq	zbss		; no more segment
	bpl	nopg		; page indicator
	leax	2,x		; skip it
nopg:
	bita	#$60		; test for moveable code segment
	beq	ibcl		; yes, skip it
	pshx			; save pointer
	tfr	y,d		; start address
	subd	-2,x		; minus end address
	ldx	-4,x		; destination address
ifdef PIC
	exg	d,y		; adjust
	addd	2,s		; code address
	exg	d,y
endif
dbcl:
	movb	1,y+,1,x+	; copy from prom to ram
	ibne	d,dbcl		; count up and loop
ifdef PIC
	exg	d,y		; restore
	subd	2,s		; code address
	exg	d,y
endif
	pulx			; reload pointer to desc
	bra	ibcl		; and loop
zbss:
	ldx	#__sbss		; start of bss
	clrb			; complete zero
	bra	loop		; start loop
zbcl:
	std	2,x+		; clear byte
loop:
	cpx	#__memory	; end of bss
	blo	zbcl		; no, continue
ifdef PIC
	puld			; clean stack
	lbsr _main	    ; execute main()
else
	jsr	_main	    ; execute main()
endif

; this is function "void _exit(void)"
_exit:
	bra	_exit		; stay here
;
	end