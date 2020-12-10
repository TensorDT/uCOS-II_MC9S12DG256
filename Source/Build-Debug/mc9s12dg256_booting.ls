   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
4092                     ; 74 _NEAR static void initHardware(void)
4092                     ; 75 {
4093                     	switch	.text
4094  0000               L3462_initHardware:
4098                     ; 77     INTCR  = 0x00;           // External interrupt is disabled
4100  0000 c7            	clrb	
4101  0001 5b1e          	stab	_INTCR
4102                     ; 78     EBICTL = 0x00;           // NO ECLK stretches
4104  0003 5b0e          	stab	_EBICTL
4105                     ; 85     INITRG = 0x00;           // REGISTERS in default location: 0x0000 to 0x03FF
4107  0005 5b11          	stab	_INITRG
4108                     ; 86     INITEE = 0x01;           // EEPROM (4KB-1KB=3KB) is at 0x0400 to 0x0FFF
4110  0007 52            	incb	
4111  0008 5b12          	stab	_INITEE
4112                     ; 87     INITRM = 0x11;           // RAM is aligned upward; is 12KB block: 0x1000 to 0x3FFF
4114  000a c611          	ldab	#17
4115  000c 5b10          	stab	_INITRM
4116                     ; 93     MISC   = 0x01;           // FLASH enabled in memory map, upper half only.
4118  000e c601          	ldab	#1
4119  0010 5b13          	stab	_MISC
4120                     ; 101     MODE   = 0x80;           // Normal Single Chip mode
4122  0012 c680          	ldab	#128
4123  0014 5b0b          	stab	_MODE
4124                     ; 103     MODRR |= 0x10;           // bit 4 is for re-assigning SPI0 to Port M
4126  0016 1c025710      	bset	_MODRR,16
4127                     ; 106     CRGINT = 0x00;           // All CRG interrupts disabled
4129  001a c7            	clrb	
4130  001b 5b38          	stab	_CRGINT
4131                     ; 117     CLKSEL = 0x00;           // OSCCLK is system clock - nobody stops ever
4133  001d 5b39          	stab	_CLKSEL
4134                     ; 119     PLLCTL = 0x80;           // Clock monitor on, PLL off
4136  001f c680          	ldab	#128
4137  0021 5b3a          	stab	_PLLCTL
4138                     ; 120     RTICTL = 0x00;           // No idea what this does?
4140  0023 c7            	clrb	
4141  0024 5b3b          	stab	_RTICTL
4142                     ; 121     COPCTL = 0x00;           // COP control register - COP disabled
4144  0026 5b3c          	stab	_COPCTL
4145                     ; 125     PUCR   = 0x12;           // PORTB/E pullups enabled
4147  0028 c612          	ldab	#18
4148  002a 5b0c          	stab	_PUCR
4149                     ; 126     RDRIV  = 0x00;           // Full drive capability
4151  002c c7            	clrb	
4152  002d 5b0d          	stab	_RDRIV
4153                     ; 138     DDRA   = 0xFF;  // previously 0x9E
4155  002f c6ff          	ldab	#255
4156  0031 5b02          	stab	_DDRA
4157                     ; 139     PORTA  = 0x0F;  // previously 0x10
4159  0033 c60f          	ldab	#15
4160  0035 5b00          	stab	_PORTA
4161                     ; 151     DDRB  = 0x00;
4163  0037 c7            	clrb	
4164  0038 5b03          	stab	_DDRB
4165                     ; 152     PORTB = 0x00;
4167  003a 5b01          	stab	_PORTB
4168                     ; 163     PEAR   = 0x10;           // PE4 is GPIO, no R/W for PE2
4170  003c c610          	ldab	#16
4171  003e 5b0a          	stab	_PEAR
4172                     ; 175     DDRE = 0x00;             // previously 0x10
4174  0040 c7            	clrb	
4175  0041 5b09          	stab	_DDRE
4176                     ; 176     PORTE = 0x00;
4178  0043 5b08          	stab	_PORTE
4179                     ; 191     DDRS   = 0x02;
4181  0045 c602          	ldab	#2
4182  0047 7b024a        	stab	_DDRS
4183                     ; 192     RDRS   = 0x00;           // Full (0) or reduced (1) drive outputs
4185  004a 79024b        	clr	_RDRS
4186                     ; 193     PERS   = 0x00;           // Pull up/dwn enabled (1) or disabled (0)
4188  004d 79024c        	clr	_PERS
4189                     ; 194     PPSS   = 0x00;           // Pull up (0) or pull down (1) for pins with PERT enabled
4191  0050 79024d        	clr	_PPSS
4192                     ; 195     WOMS   = 0x00;           // Outputs operate open-drain(1), wired-or, or push-pull(0)
4194  0053 79024e        	clr	_WOMS
4195                     ; 196     PTS    = 0x02;
4197  0056 7b0248        	stab	_PTS
4198                     ; 209     DDRT   = 0x6F;
4200  0059 c66f          	ldab	#111
4201  005b 7b0242        	stab	_DDRT
4202                     ; 210     RDRT   = 0x00;           // Full (0) or Reduced (1) drive outputs
4204  005e 790243        	clr	_RDRT
4205                     ; 211     PERT   = 0x00;           // Pull up/dwn enabled (1) or disabled (0)
4207  0061 790244        	clr	_PERT
4208                     ; 212     PPST   = 0x00;           // Pull up (0) or pull down (1) for pins with PERT enabled
4210  0064 790245        	clr	_PPST
4211                     ; 213     PTT    = 0x0F;
4213  0067 c60f          	ldab	#15
4214  0069 7b0240        	stab	_PTT
4215                     ; 224     PACTL = 0x00;
4217  006c c7            	clrb	
4218  006d 5b60          	stab	_PACTL
4219                     ; 238     DDRM  = 0x3A;            // Note SPI, CAN, BDLC registers overide the DDRM
4221  006f c63a          	ldab	#58
4222  0071 7b0252        	stab	_DDRM
4223                     ; 239     PTM   = 0x1A;
4225  0074 c61a          	ldab	#26
4226  0076 7b0250        	stab	_PTM
4227                     ; 240     RDRM  = 0x00;
4229  0079 790253        	clr	_RDRM
4230                     ; 241     PERM  = 0x00;
4232  007c 790254        	clr	_PERM
4233                     ; 242     PPSM  = 0x00;
4235  007f 790255        	clr	_PPSM
4236                     ; 243     WOMM  = 0x00;
4238  0082 790256        	clr	_WOMM
4239                     ; 259     DDRP   = 0x1E;           // Data Direction Register (0)Input, (1) Output
4241  0085 c61e          	ldab	#30
4242  0087 7b025a        	stab	_DDRP
4243                     ; 260     PTP    = 0x0A;           // Port P
4245  008a c60a          	ldab	#10
4246  008c 7b0258        	stab	_PTP
4247                     ; 261     RDRP   = 0x00;           // Full (0) or reduced (1) drive outputs
4249  008f c7            	clrb	
4250  0090 7b025b        	stab	_RDRP
4251                     ; 262     PERP   = 0x00;           // Pull up/down enabled (1) or disabled (0)
4253  0093 7b025c        	stab	_PERP
4254                     ; 263     PPSP   = 0x00;           // Pull up (0) or pull down (1) for pins with PERT enabled
4256  0096 7b025d        	stab	_PPSP
4257                     ; 264     PIEP   = 0x00;           // Enables (1) external int for each pin of Port P
4259  0099 7b025e        	stab	_PIEP
4260                     ; 265     PIFP   = 0x00;           // Ext port P int flag register, reset by writing "1"
4262  009c 7b025f        	stab	_PIFP
4263                     ; 278     DDRJ   = 0x00;           // Data Direction Register (0)Input, (1) Output
4265  009f 7b026a        	stab	_DDRJ
4266                     ; 279     PTJ    = 0x00;
4268  00a2 7b0268        	stab	_PTJ
4269                     ; 280     RDRJ   = 0x00;
4271  00a5 7b026b        	stab	_RDRJ
4272                     ; 281     PERJ   = 0x00;
4274  00a8 7b026c        	stab	_PERJ
4275                     ; 282     PPSJ   = 0x00;
4277  00ab 7b026d        	stab	_PPSJ
4278                     ; 293     ATD0CTL2 = 0x00;
4280  00ae 5b82          	stab	_ATD0CTL2
4281                     ; 305     TSCR1  = 0x80;
4283  00b0 c680          	ldab	#128
4284  00b2 5b46          	stab	_TSCR1
4285                     ; 316     TSCR2  = 0x02;           // tmr clock = BUS CLOCK / 4 = 2457600 / 4 = 614400 HZ
4287  00b4 c602          	ldab	#2
4288  00b6 5b4d          	stab	_TSCR2
4289                     ; 319     TCTL1  = 0x00;
4291  00b8 c7            	clrb	
4292  00b9 5b48          	stab	_TCTL1
4293                     ; 320     TCTL2  = 0x00;
4295  00bb 5b49          	stab	_TCTL2
4296                     ; 321     TCTL3  = 0x00;
4298  00bd 5b4a          	stab	_TCTL3
4299                     ; 322     TCTL4  = 0x00;
4301  00bf 5b4b          	stab	_TCTL4
4302                     ; 325     SCI0BD = BAUD19200;
4304  00c1 cc0008        	ldd	#8
4305  00c4 5cc8          	std	_SCI0BD
4306                     ; 338     SCI0CR1 = 0x00;
4308  00c6 c7            	clrb	
4309  00c7 5bca          	stab	_SCI0CR1
4310                     ; 349     SCI0CR2 = 0x04;          // Enable receiver
4312  00c9 c604          	ldab	#4
4313  00cb 5bcb          	stab	_SCI0CR2
4314                     ; 360     SPI0CR2 = 0x00;          // CHECK ME!!! CTF inits this to 0x08 (output buffer enabled)
4316  00cd c7            	clrb	
4317  00ce 5bd9          	stab	_SPI0CR2
4318                     ; 371     SPI0CR1 = 0x4C;
4320  00d0 c64c          	ldab	#76
4321  00d2 5bd8          	stab	_SPI0CR1
4322                     ; 376     SPI0BR  = 0x01;
4324  00d4 c601          	ldab	#1
4325  00d6 5bda          	stab	_SPI0BR
4326                     ; 379     ByteUpperCase = SPI0SR;
4328  00d8 d6db          	ldab	_SPI0SR
4329                     ; 380     ByteUpperCase = SPI0DR;
4331  00da d6dd          	ldab	_SPI0DR
4332  00dc 7b39e0        	stab	_ByteUpperCase
4333                     ; 382     return;
4336  00df 3d            	rts	
4382                     ; 395 _NEAR static void delayMilliseconds(
4382                     ; 396     UINT16 delay_ms)         // software delay in milliseconds
4382                     ; 397 {
4383                     	switch	.text
4384  00e0               L3662_delayMilliseconds:
4386  00e0 3b            	pshd	
4387  00e1 1b9d          	leas	-3,s
4388       00000003      OFST:	set	3
4391                     ; 401     for (cntr_ms=0; cntr_ms<delay_ms; cntr_ms++) {
4393  00e3 87            	clra	
4394  00e4 c7            	clrb	
4396  00e5 2010          	bra	L1172
4397  00e7               L5072:
4398                     ; 402         for (cntr1msLoop=0; cntr1msLoop<149; cntr1msLoop++) {
4400  00e7 6980          	clr	OFST-3,s
4401  00e9               L5172:
4402                     ; 403             NOP();
4405  00e9 a7            	nop	
4407                     ; 402         for (cntr1msLoop=0; cntr1msLoop<149; cntr1msLoop++) {
4409  00ea 6280          	inc	OFST-3,s
4412  00ec e680          	ldab	OFST-3,s
4413  00ee c195          	cmpb	#149
4414  00f0 25f7          	blo	L5172
4415                     ; 401     for (cntr_ms=0; cntr_ms<delay_ms; cntr_ms++) {
4417  00f2 ec81          	ldd	OFST-2,s
4418  00f4 c30001        	addd	#1
4419  00f7               L1172:
4420  00f7 6c81          	std	OFST-2,s
4423  00f9 ac83          	cpd	OFST+0,s
4424  00fb 25ea          	blo	L5072
4425                     ; 407     return;
4428  00fd 1b85          	leas	5,s
4429  00ff 3d            	rts	
4474                     ; 419 _NEAR static void copyBootloaderToRAM(void)
4474                     ; 420 {
4475                     	switch	.text
4476  0100               L3272_copyBootloaderToRAM:
4478  0100 1b9c          	leas	-4,s
4479       00000004      OFST:	set	4
4482                     ; 424     pROM = (UINT16*)BL_ROM_ADDR_START;  // load start of ROM boot code
4484  0102 ccf800        	ldd	#-2048
4485  0105 6c82          	std	OFST-2,s
4486                     ; 425     pRAM = (UINT16*)BL_RAM_ADDR_START;  // load start of RAM boot code
4488  0107 863a          	ldaa	#58
4490  0109 200c          	bra	L3572
4491  010b               L7472:
4492                     ; 429         *pRAM++ = *pROM++;   
4494  010b ed82          	ldy	OFST-2,s
4495  010d ec71          	ldd	2,y+
4496  010f 6d82          	sty	OFST-2,s
4497  0111 ed80          	ldy	OFST-4,s
4498  0113 6c71          	std	2,y+
4499  0115 b764          	tfr	y,d
4500  0117               L3572:
4501  0117 6c80          	std	OFST-4,s
4502                     ; 427     while(pRAM <= (volatile UINT16*)BL_RAM_ADDR_END) {
4504  0119 8c3eff        	cpd	#16127
4505  011c 23ed          	bls	L7472
4506                     ; 432     return;
4509  011e 1b84          	leas	4,s
4510  0120 3d            	rts	
4546                     ; 440 _NEAR void Booting(void)
4546                     ; 441 {
4547                     	switch	.text
4548  0121               _Booting:
4552                     ; 444     CntrTimeout = 0;
4554  0121 7939e1        	clr	_CntrTimeout
4555                     ; 445     IdxByte = 0;
4557  0124 7939e2        	clr	_IdxByte
4558                     ; 446     DirComparison = DIR_COMP_GREATER_THAN;
4560  0127 7939e3        	clr	_DirComparison
4561                     ; 447     WasBLCmdRcvd = BFALSE;
4563  012a 7939e4        	clr	_WasBLCmdRcvd
4564                     ; 450     INTR_OFF();
4567  012d 1410          	sei	
4569                     ; 454     initHardware();
4571  012f 160000        	jsr	L3462_initHardware
4574  0132 206a          	bra	L1003
4575  0134               L7772:
4576                     ; 458         if (SCI0SR1 & 0x20)  {                    // received a byte?
4578  0134 4fcc2046      	brclr	_SCI0SR1,32,L1103
4579                     ; 460             ByteUpperCase = SCI0DRL;
4581  0138 d6cf          	ldab	_SCI0DRL
4582  013a 7b39e0        	stab	_ByteUpperCase
4583                     ; 462             switch (IdxByte) {
4585  013d f639e2        	ldab	_IdxByte
4587  0140 270b          	beq	L7572
4588  0142 040111        	dbeq	b,L1672
4589  0145 04011a        	dbeq	b,L3672
4590  0148 040125        	dbeq	b,L5672
4591  014b 2031          	bra	L1103
4592  014d               L7572:
4593                     ; 463                 case 0:
4593                     ; 464                      if (ByteUpperCase == 'B') { // don't increment IdxByte until receiving 'B'
4595  014d f639e0        	ldab	_ByteUpperCase
4596  0150 c142          	cmpb	#66
4597  0152 262a          	bne	L1103
4598                     ; 465                          IdxByte++;
4600  0154 2015          	bra	L7103
4601  0156               L1672:
4602                     ; 469                 case 1:
4602                     ; 470                      if (ByteUpperCase != 'L') {
4604  0156 f639e0        	ldab	_ByteUpperCase
4605  0159 c14c          	cmpb	#76
4606  015b 2703          	beq	L5103
4607                     ; 473                              jmp $4000
4610  015d 064000        	jmp	$4000
4612  0160               L5103:
4613                     ; 476                      IdxByte++;
4615                     ; 477                      break;
4617  0160 2009          	bra	L7103
4618  0162               L3672:
4619                     ; 479                 case 2:
4619                     ; 480                      if (ByteUpperCase != '2') {
4621  0162 f639e0        	ldab	_ByteUpperCase
4622  0165 c132          	cmpb	#50
4623  0167 2702          	beq	L7103
4624  0169               L1203:
4625                     ; 484                          while(BTRUE);
4627  0169 20fe          	bra	L1203
4628  016b               L7103:
4629                     ; 486                      IdxByte++;
4631  016b 7239e2        	inc	_IdxByte
4632                     ; 487                      break;
4634  016e 200e          	bra	L1103
4635  0170               L5672:
4636                     ; 489                 case 3:
4636                     ; 490                      if (ByteUpperCase != '0') {
4638  0170 f639e0        	ldab	_ByteUpperCase
4639  0173 c130          	cmpb	#48
4640  0175 2702          	beq	L5203
4641  0177               L7203:
4642                     ; 494                         while(BTRUE);
4644  0177 20fe          	bra	L7203
4645  0179               L5203:
4646                     ; 497                          WasBLCmdRcvd = BTRUE;
4648  0179 c601          	ldab	#1
4649  017b 7b39e4        	stab	_WasBLCmdRcvd
4650  017e               L1103:
4651                     ; 506         if (DirComparison == DIR_COMP_GREATER_THAN) {  // '>' comparison
4653  017e f639e3        	ldab	_DirComparison
4654  0181 2611          	bne	L5303
4655                     ; 507             if (TCNT > 0x8000) {
4657  0183 dc44          	ldd	_TCNT
4658  0185 8c8000        	cpd	#-32768
4659  0188 2314          	bls	L1003
4660                     ; 508                 CntrTimeout++;
4662  018a 7239e1        	inc	_CntrTimeout
4663                     ; 509                 DirComparison = DIR_COMP_LESS_THAN;    // changed to '<'
4665  018d c601          	ldab	#1
4666  018f 7b39e3        	stab	_DirComparison
4667  0192 200a          	bra	L1003
4668  0194               L5303:
4669                     ; 513             if (TCNT < 0x8000) {
4671  0194 dc44          	ldd	_TCNT
4672  0196 8c8000        	cpd	#-32768
4673  0199 2403          	bhs	L1003
4674                     ; 514                 DirComparison = DIR_COMP_GREATER_THAN; // changed to '>'
4676  019b 7939e3        	clr	_DirComparison
4677  019e               L1003:
4678                     ; 456     while ((CntrTimeout < TIMEOUT_20_CENTISEC) && // a timeout of about 2sec
4678                     ; 457             !WasBLCmdRcvd) {                      // no Enq received
4680  019e f639e1        	ldab	_CntrTimeout
4681  01a1 c114          	cmpb	#20
4682  01a3 2405          	bhs	L5403
4684  01a5 f739e4        	tst	_WasBLCmdRcvd
4685  01a8 278a          	beq	L7772
4686  01aa               L5403:
4687                     ; 521     if (!WasBLCmdRcvd) {
4689  01aa f739e4        	tst	_WasBLCmdRcvd
4690  01ad 2603          	bne	L7403
4691                     ; 523             jmp $4000
4694  01af 064000        	jmp	$4000
4696  01b2               L7403:
4697                     ; 528     delayMilliseconds(1);    // Shortened delay due to debugger sluggishness
4699  01b2 cc0001        	ldd	#1
4700  01b5 1600e0        	jsr	L3662_delayMilliseconds
4702                     ; 533     TX_MODE();               // Switch to transmit mode
4704  01b8 1d025002      	bclr	_PTM,2
4707  01bc c608          	ldab	#8
4708  01be 5bcb          	stab	_SCI0CR2
4709                     ; 535     SCI0DRL = ACK;           // Send an ACK
4712  01c0 c606          	ldab	#6
4713  01c2 5bcf          	stab	_SCI0DRL
4715  01c4               L5503:
4716                     ; 537     while (!(SCI0SR1 & 0x40));
4718  01c4 4fcc40fc      	brclr	_SCI0SR1,64,L5503
4719                     ; 539     RX_MODE();               // Return back to receive mode
4721  01c8 1c025002      	bset	_PTM,2
4724  01cc c604          	ldab	#4
4725  01ce 5bcb          	stab	_SCI0CR2
4726                     ; 541     ByteUpperCase = SCI0SR1;
4729  01d0 d6cc          	ldab	_SCI0SR1
4730                     ; 542     ByteUpperCase = SCI0DRL;
4732  01d2 d6cf          	ldab	_SCI0DRL
4733  01d4 7b39e0        	stab	_ByteUpperCase
4734                     ; 546     copyBootloaderToRAM();
4736  01d7 160100        	jsr	L3272_copyBootloaderToRAM
4738                     ; 557         xref __stack
4741                     xref __stack
4743                     ; 558         lds #__stack
4746  01da cf0000        	lds	#__stack
4748                     ; 559         jmp $3A00
4751  01dd 063a00        	jmp	$3A00
4753                     ; 562     return;
4838                     	xdef	_Booting
4858                     	end
