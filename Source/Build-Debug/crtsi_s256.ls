   2                     ;	C STARTUP FOR MC68HC12
   3                     ;	WITH AUTOMATIC DATA INITIALISATION
   4                     ;	Copyright (c) 2000 by COSMIC Software
   5                     ;
   6                     	xdef	__reset
   7                     	xdef	_exit, __stext
   8                     	xref	_main, __sbss, __memory, __idesc__, __stack
   9                     
  10                     ; this is function void _stext(void)
  11                     ; PIC = position independent code
  12  0000               __stext:
  13  0000               __reset:
  14  0000 cf0000        	lds	#__stack	; initialize stack pointer
  21  0003 ce0000        	ldx	#__idesc__	; descriptor address
  23  0006 ed31          	ldy	2,x+		; start address of prom data
  24  0008               ibcl:
  25  0008 a634          	ldaa	5,x+		; test flag byte
  26  000a 2719          	beq	zbss		; no more segment
  27  000c 2a02          	bpl	nopg		; page indicator
  28  000e 1a02          	leax	2,x		; skip it
  29  0010               nopg:
  30  0010 8560          	bita	#$60		; test for moveable code segment
  31  0012 27f4          	beq	ibcl		; yes, skip it
  32  0014 34            	pshx			; save pointer
  33  0015 b764          	tfr	y,d		; start address
  34  0017 a31e          	subd	-2,x		; minus end address
  35  0019 ee1c          	ldx	-4,x		; destination address
  41  001b               dbcl:
  42  001b 180a7030      	movb	1,y+,1,x+	; copy from prom to ram
  43  001f 04b4f9        	ibne	d,dbcl		; count up and loop
  49  0022 30            	pulx			; reload pointer to desc
  50  0023 20e3          	bra	ibcl		; and loop
  51  0025               zbss:
  52  0025 ce0000        	ldx	#__sbss		; start of bss
  53  0028 c7            	clrb			; complete zero
  54  0029 2002          	bra	loop		; start loop
  55  002b               zbcl:
  56  002b 6c31          	std	2,x+		; clear byte
  57  002d               loop:
  58  002d 8e0000        	cpx	#__memory	; end of bss
  59  0030 25f9          	blo	zbcl		; no, continue
  64  0032 160000        	jsr	_main	    ; execute main()
  66                     
  67                     ; this is function "void _exit(void)"
  68  0035               _exit:
  69  0035 20fe          	bra	_exit		; stay here
  70                     ;
  71                     	end
