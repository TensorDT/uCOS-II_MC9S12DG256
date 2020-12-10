   2                     ;*********************************************************************
   3                     ;
   4                     ;  File name:  mc9s12dg256_startup.s
   5                     ;
   6                     ;  Purpose:    MC9S12DG256 startup file for use with bootloader code
   7                     ;
   8                     ;  Target:     MC9S12DG256-based board
   9                     ;
  10                     ;  Revisions:
  11                     ;   ##  dd mmm yyyy  who  description
  12                     ;    1  09 Dec 2020  GPM  Initial revision (from COSMIC Software)
  13                     ;
  14                     ;  Notes:
  15                     ;    IMPORTANT!!!
  16                     ;      This module *MUST* be located at physical address 0xFF600
  17                     ;      (logical address 0xF600) so that it agrees with the (new)
  18                     ;      vector table.
  19                     ;
  20                     ;  Tensor Drilling Technologies
  21                     ;  2418 North Frazier St., Suite 100
  22                     ;  Conroe, TX 77303
  23                     ;*********************************************************************
  24                     ;
  25                     ;	C STARTUP FOR MC68HC12
  26                     ;	WITH AUTOMATIC DATA INITIALISATION
  27                     ;	Copyright (c) 2000 by COSMIC Software
  28                     ;
  29                     	xdef	__reset
  30                     	xref	_Booting, __stack
  31                     
  32                     ; this is function void _stext(void)
  33                     ; PIC = position independent code
  34  0000               __reset:
  35  0000 cf0000        	lds	#__stack	; initialize stack pointer
  36  0003 160000        	jsr	_Booting    ; execute Booting()
  37                     	end
