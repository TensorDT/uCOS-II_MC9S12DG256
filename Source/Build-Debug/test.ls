   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
4017                     ; 41 static void initHardware(void)
4017                     ; 42 {
4018                     	switch	.text
4019  0000               L3462_initHardware:
4023                     ; 46     INITRG = 0x00;                // Keep registers at default location
4025  0000 c7            	clrb	
4026  0001 5b11          	stab	_INITRG
4027                     ; 48     INITEE = 0x01;                // Keep 4K EEPROM at default location
4029  0003 52            	incb	
4030  0004 5b12          	stab	_INITEE
4031                     ; 51     INITRM = 0x09;                // Keep 12K RAM  at default location
4033  0006 c609          	ldab	#9
4034  0008 5b10          	stab	_INITRM
4035                     ; 53     MODE   = 0x80;                // Normal Single Chip mode
4037  000a c680          	ldab	#128
4038  000c 5b0b          	stab	_MODE
4039                     ; 54     CLKSEL = 0x00;                // SYSCLK derived from OSCCLK,
4041  000e c7            	clrb	
4042  000f 5b39          	stab	_CLKSEL
4043                     ; 56     PLLCTL = 0x80;                // Crystal monitor enabled, PLL off
4045  0011 c680          	ldab	#128
4046  0013 5b3a          	stab	_PLLCTL
4047                     ; 57     RTICTL = 0x00;                // RTI Prescale off
4049  0015 c7            	clrb	
4050  0016 5b3b          	stab	_RTICTL
4051                     ; 58     COPCTL = 0x00;                // Disable the watchdog
4053  0018 5b3c          	stab	_COPCTL
4054                     ; 60     TSCR2 = TSCR2_PRESCALER_BITS; // Disable timer overflow interrupt,
4056  001a c602          	ldab	#2
4057  001c 5b4d          	stab	_TSCR2
4058                     ; 65 }
4061  001e 3d            	rts	
4096                     ; 67 _NEAR void TestTask (void *pdata)
4096                     ; 68 {
4097                     	switch	.text
4098  001f               _TestTask:
4100  001f 3b            	pshd	
4101       00000000      OFST:	set	0
4104                     ; 69     pdata = pdata;
4106  0020 6c80          	std	OFST+0,s
4107  0022               L1072:
4108                     ; 71         OSTimeDly(1);
4110  0022 ce0000        	ldx	#0
4111  0025 cc0001        	ldd	#1
4112  0028 160000        	jsr	_OSTimeDly
4115  002b 20f5          	bra	L1072
4144                     ; 75 _NEAR void main(void)
4144                     ; 76 {
4145                     	switch	.text
4146  002d               _main:
4150                     ; 78     initHardware();
4152  002d 07d1          	jsr	L3462_initHardware
4154                     ; 81     OSInit();
4156  002f 160000        	jsr	_OSInit
4158                     ; 83     OSTaskCreate(
4158                     ; 84         TestTask,                 // task's address
4158                     ; 85         (void *)0,                // ptr to data to pass to task
4158                     ; 86         &TestTaskStk[99],         // task's top of stack
4158                     ; 87         PRIO_TEST_TASK);          // task's priority level
4160  0032 87            	clra	
4161  0033 c7            	clrb	
4162  0034 3b            	pshd	
4163  0035 cc0063        	ldd	#_TestTaskStk+99
4164  0038 3b            	pshd	
4165  0039 87            	clra	
4166  003a c7            	clrb	
4167  003b 3b            	pshd	
4168  003c cc001f        	ldd	#_TestTask
4169  003f 160000        	jsr	_OSTaskCreate
4171  0042 1b86          	leas	6,s
4172                     ; 89     OSStart();
4174  0044 160000        	jsr	_OSStart
4176                     ; 90 }
4179  0047 3d            	rts	
4203                     	xdef	_main
4204                     	xdef	_TestTask
4205                     	switch	.bss
4206  0000               _TestTaskStk:
4207  0000 000000000000  	ds.b	100
4208                     	xdef	_TestTaskStk
4209                     	xref	_OSStart
4210                     	xref	_OSInit
4211                     	xref	_OSTimeDly
4212                     	xref	_OSTaskCreate
4233                     	end
