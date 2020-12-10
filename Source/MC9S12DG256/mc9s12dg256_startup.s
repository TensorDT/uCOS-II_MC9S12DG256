;*********************************************************************
;
;  File name:  mc9s12dg256_startup.s
;
;  Purpose:    MC9S12DG256 startup file for use with bootloader code
;
;  Target:     MC9S12DG256-based board
;
;  Revisions:
;   ##  dd mmm yyyy  who  description
;    1  09 Dec 2020  GPM  Initial revision (from COSMIC Software)
;
;  Notes:
;    IMPORTANT!!!
;      This module *MUST* be located at physical address 0xFF600
;      (logical address 0xF600) so that it agrees with the (new)
;      vector table.
;
;  Tensor Drilling Technologies
;  2418 North Frazier St., Suite 100
;  Conroe, TX 77303
;*********************************************************************
;
;	C STARTUP FOR MC68HC12
;	WITH AUTOMATIC DATA INITIALISATION
;	Copyright (c) 2000 by COSMIC Software
;
	xdef	__reset
	xref	_Booting, __stack
	
; this is function void _stext(void)
; PIC = position independent code
__reset:
	lds	#__stack	; initialize stack pointer
	jsr	_Booting    ; execute Booting()
	end
