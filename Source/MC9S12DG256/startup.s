;	C STARTUP FOR MC68HC12
;	WITH AUTOMATIC DATA INITIALISATION
;	Copyright (c) 2000 by COSMIC Software
;
	xdef	__reset
	xref	_main, __stack
	
; this is function void _stext(void)
; PIC = position independent code
__reset:
	lds	#__stack	; initialize stack pointer
	jsr	_main	    ; execute main()
	end
