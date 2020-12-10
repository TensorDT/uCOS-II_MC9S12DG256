   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
3982                     .eeprom:	section	.data
3983  0000               L5462_EETest32:
3984  0000 deadbeef      	dc.l	-559038737
3985                     	bsct
3986  0000               L7462_ZeroPage16:
3987  0000 fade          	dc.w	-1314
4024                     ; 47 _NEAR static void initHardware(void)
4024                     ; 48 {
4025                     	switch	.text
4026  0000               L1562_initHardware:
4030                     ; 52     INITRG = 0x00;                // Keep registers at default location
4032  0000 c7            	clrb	
4033  0001 5b11          	stab	_INITRG
4034                     ; 54     INITEE = 0x01;                // Keep 4K EEPROM at default location
4036  0003 52            	incb	
4037  0004 5b12          	stab	_INITEE
4038                     ; 57     INITRM = 0x11;                // Move 12K RAM to 0x1000-0x3FFF
4040  0006 c611          	ldab	#17
4041  0008 5b10          	stab	_INITRM
4042                     ; 59     MODE   = 0x80;                // Normal Single Chip mode
4044  000a c680          	ldab	#128
4045  000c 5b0b          	stab	_MODE
4046                     ; 60     CLKSEL = 0x00;                // SYSCLK derived from OSCCLK,
4048  000e c7            	clrb	
4049  000f 5b39          	stab	_CLKSEL
4050                     ; 62     PLLCTL = 0x80;                // Crystal monitor enabled, PLL off
4052  0011 c680          	ldab	#128
4053  0013 5b3a          	stab	_PLLCTL
4054                     ; 63     RTICTL = 0x00;                // RTI Prescale off
4056  0015 c7            	clrb	
4057  0016 5b3b          	stab	_RTICTL
4058                     ; 64     COPCTL = 0x00;                // Disable the watchdog
4060  0018 5b3c          	stab	_COPCTL
4061                     ; 66     return;
4064  001a 3d            	rts	
4096                     ; 69 _NEAR static void initClockTimer(void)
4096                     ; 70 {
4097                     	switch	.text
4098  001b               L1762_initClockTimer:
4102                     ; 72     TCTL1  = 0x00;
4104  001b c7            	clrb	
4105  001c 5b48          	stab	_TCTL1
4106                     ; 73     TCTL2  = 0x00;
4108  001e 5b49          	stab	_TCTL2
4109                     ; 74     TCTL3  = 0x00;
4111  0020 5b4a          	stab	_TCTL3
4112                     ; 75     TCTL4  = 0x00;
4114  0022 5b4b          	stab	_TCTL4
4115                     ; 79     TIE    = TIE_C7I;
4117  0024 c680          	ldab	#128
4118  0026 5b4c          	stab	_TIE
4119                     ; 82     TSCR2  = TSCR2_PRESCALER_BITS; 
4121  0028 c601          	ldab	#1
4122  002a 5b4d          	stab	_TSCR2
4123                     ; 88     TIOS  |= TIOS_IOS7;
4125  002c 4c4080        	bset	_TIOS,128
4126                     ; 89     OC7M  &= ~(OC7M_OC7M7);
4128  002f 4d4280        	bclr	_OC7M,128
4129                     ; 90     TC7    = TMR_TICKS_PER_TMR_INT;
4131  0032 cc5ff0        	ldd	#24560
4132  0035 5c5e          	std	_TC7
4133                     ; 93     TSCR1 |= TSCR1_TEN;
4135  0037 4c4680        	bset	_TSCR1,128
4136                     ; 95     return;
4139  003a 3d            	rts	
4177                     ; 98 _NEAR void TestTask (void *pdata)
4177                     ; 99 {
4178                     	switch	.text
4179  003b               _TestTask:
4181  003b 3b            	pshd	
4182       00000000      OFST:	set	0
4185                     ; 101     pdata = pdata;
4187  003c 6c80          	std	OFST+0,s
4188                     ; 104     initClockTimer();
4190  003e 07db          	jsr	L1762_initClockTimer
4192                     ; 107     EETest16 = 0x0000;
4194  0040 87            	clra	
4195  0041 c7            	clrb	
4196  0042 cd0004        	ldy	#L3462_EETest16
4197  0045 160000        	jsr	c_eewrw
4199                     ; 110     ENABLE_INTS();
4202  0048 10ef          	cli	
4204  004a               L1272:
4205                     ; 113         OSTimeDly(1);
4207  004a ce0000        	ldx	#0
4208  004d cc0001        	ldd	#1
4209  0050 160000        	jsr	_OSTimeDly
4212  0053 20f5          	bra	L1272
4241                     ; 117 _NEAR void main(void)
4241                     ; 118 {
4242                     	switch	.text
4243  0055               _main:
4247                     ; 120     initHardware();
4249  0055 07a9          	jsr	L1562_initHardware
4251                     ; 123     OSInit();
4253  0057 160000        	jsr	_OSInit
4255                     ; 125     OSTaskCreate(
4255                     ; 126         TestTask,                 // task's address
4255                     ; 127         (void *)0,                // ptr to data to pass to task
4255                     ; 128         &TestTaskStk[99],         // task's top of stack
4255                     ; 129         PRIO_TEST_TASK);          // task's priority level
4257  005a 87            	clra	
4258  005b c7            	clrb	
4259  005c 3b            	pshd	
4260  005d cc0063        	ldd	#_TestTaskStk+99
4261  0060 3b            	pshd	
4262  0061 87            	clra	
4263  0062 c7            	clrb	
4264  0063 3b            	pshd	
4265  0064 cc003b        	ldd	#_TestTask
4266  0067 160000        	jsr	_OSTaskCreate
4268  006a 1b86          	leas	6,s
4269                     ; 131     OSStart();
4271  006c 160000        	jsr	_OSStart
4273                     ; 132 }
4276  006f 3d            	rts	
4327                     	xdef	_main
4328                     	xdef	_TestTask
4329                     	switch	.eeprom
4330  0004               L3462_EETest16:
4331  0004 0000          	ds.b	2
4332                     	switch	.bss
4333  0000               _TestTaskStk:
4334  0000 000000000000  	ds.b	100
4335                     	xdef	_TestTaskStk
4336                     	xref	_OSStart
4337                     	xref	_OSInit
4338                     	xref	_OSTimeDly
4339                     	xref	_OSTaskCreate
4360                     	xref	c_eewrw
4361                     	end
