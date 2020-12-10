   2                     ;*********************************************************************
   3                     ;
   4                     ;  File name:  Crtsi_256.s
   5                     ;
   6                     ;  Purpose:    MC9S12DG256 application startup file (executed before
   7                     ;              jumping to main() subroutine)
   8                     ;
   9                     ;  Target:     MC9S12DG256-based board
  10                     ;
  11                     ;  Revisions:
  12                     ;   ##  dd mmm yyyy  who  description
  13                     ;    1  09 Dec 2020  GPM  Initial revision (from COSMIC Software)
  14                     ;
  15                     ;  Notes:
  16                     ;    IMPORTANT!!!
  17                     ;      This module *MUST* be located at physical address 0xF8000
  18                     ;      (logical address 0x4000) so that it agrees with the
  19                     ;      bootloader.
  20                     ;
  21                     ;  Tensor Drilling Technologies
  22                     ;  2418 North Frazier St., Suite 100
  23                     ;  Conroe, TX 77303
  24                     ;*********************************************************************
  25                     ;
  26                     ;    C STARTUP FOR MC68HC12
  27                     ;    WITH AUTOMATIC DATA INITIALISATION
  28                     ;    Copyright (c) 2000 by COSMIC Software
  29                     ;
  30                         xdef    _exit, __stext
  31                         xref    _main, __sbss, __memory, __idesc__, __stack
  32                     
  33                     ; this is function void _stext(void)
  34                     ; PIC = position independent code
  35  0000               __stext:
  36  0000 cf0000            lds   #__stack           ; initialize stack pointer
  43  0003 ce0000            ldx   #__idesc__         ; descriptor address
  45  0006 ed31              ldy   2,x+               ; start address of prom data
  46  0008               ibcl:
  47  0008 a634              ldaa  5,x+               ; test flag byte
  48  000a 2719              beq   zbss               ; no more segment
  49  000c 2a02              bpl   nopg               ; page indicator
  50  000e 1a02              leax  2,x                ; skip it
  51  0010               nopg:
  52  0010 8560              bita  #$60               ; test for moveable code segment
  53  0012 27f4              beq   ibcl               ; yes, skip it
  54  0014 34                pshx                     ; save pointer
  55  0015 b764              tfr   y,d                ; start address
  56  0017 a31e              subd  -2,x               ; minus end address
  57  0019 ee1c              ldx   -4,x               ; destination address
  63  001b               dbcl:
  64  001b 180a7030          movb  1,y+,1,x+          ; copy from prom to ram
  65  001f 04b4f9            ibne  d,dbcl             ; count up and loop
  71  0022 30                pulx                     ; reload pointer to desc
  72  0023 20e3              bra   ibcl               ; and loop
  73  0025               zbss:
  74  0025 ce0000            ldx   #__sbss            ; start of bss
  75  0028 c7                clrb                     ; complete zero
  76  0029 2002              bra   loop               ; start loop
  77  002b               zbcl:
  78  002b 6c31              std   2,x+               ; clear byte
  79  002d               loop:
  80  002d 8e0000            cpx   #__memory          ; end of bss
  81  0030 25f9              blo   zbcl               ; no, continue
  86  0032 160000            jsr   _main              ; execute main()
  88                     
  89                     ; this is function "void _exit(void)"
  90  0035               _exit:
  91  0035 20fe              bra   _exit              ; stay here
  92                     ;
  93                         end
