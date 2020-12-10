   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
   5                     	pic	on
4057                     ; 143 _NEAR void BootLoaderToRunFromRAM(void)
4057                     ; 144 {
4058                     	switch	.text
4059  0000               _BootLoaderToRunFromRAM:
4061  0000 3b            	pshd	
4062       00000002      OFST:	set	2
4065                     ; 148     ECLKDIV = 0x1A;          // ECLK = OSC/(26+1) = 4915200/27 = 182044 Hz
4067  0001 c61a          	ldab	#26
4068  0003 7b0110        	stab	_ECLKDIV
4069                     ; 150     ECNFG   = 0x00;          // Disable both CBEIE and CCIE
4071  0006 790113        	clr	_ECNFG
4072                     ; 151     EPROT   = 0xFF;          // This value is loaded from an EEPROM byte at 0x4FFD at startup
4074  0009 c6ff          	ldab	#255
4075  000b 7b0114        	stab	_EPROT
4076                     ; 152     ESTAT  |= (ESTAT_PVIOL | // Clear PVIOL and ACCERR flags
4076                     ; 153                ESTAT_ACCERR); 
4078  000e 1c011530      	bset	_ESTAT,48
4079                     ; 156     FCLKDIV = 0x1A;          // ECLK = OSC/(26+1) = 4915200/27 = 182044 Hz
4081  0012 c61a          	ldab	#26
4082  0014 7b0100        	stab	_FCLKDIV
4083                     ; 158     FCNFG   = 0x00;          // Disable related interrupts and security key writing
4085  0017 790103        	clr	_FCNFG
4086                     ; 159     FPROT   = 0xFF;          // No flash protection
4088  001a c6ff          	ldab	#255
4089  001c 7b0104        	stab	_FPROT
4090                     ; 160     FSTAT  |= (FSTAT_PVIOL | // Clear PVIOL and ACCERR flags
4090                     ; 161                FSTAT_ACCERR);
4092  001f 1c010530      	bset	_FSTAT,48
4093                     ; 163     PPAGE   = 0;             // Reset to page 0 (default)
4095  0023 c7            	clrb	
4096  0024 5b30          	stab	_PPAGE
4097                     ; 166     BuffRx[0] = 0;
4099  0026 790000        	clr	_BuffRx
4100                     ; 167     Index = 0;
4102  0029 7939f1        	clr	_Index
4103                     ; 168     WasBTCmdRcvd = BFALSE;
4105  002c 7939f2        	clr	_WasBTCmdRcvd
4106                     ; 169     CntrBytes = 0;
4108  002f 7939f6        	clr	_CntrBytes
4110  0032 182000f3      	lbra	L1762
4111  0036               L5662:
4112                     ; 173         if (SCI0SR1 & 0x20) {     // received a byte?
4114  0036 4fcc204b      	brclr	_SCI0SR1,32,L5762
4115                     ; 175             BuffRx[Index] = SCI0DRL;
4117  003a f639f1        	ldab	_Index
4118  003d 87            	clra	
4119  003e b746          	tfr	d,y
4120  0040 d6cf          	ldab	_SCI0DRL
4121  0042 6bea0000      	stab	_BuffRx,y
4122                     ; 177             if (Index == IDX_FRAMING_BYTE) {
4124  0046 f739f1        	tst	_Index
4125  0049 261f          	bne	L7762
4126                     ; 184                 if ((BuffRx[IDX_FRAMING_BYTE] != STX) &&
4126                     ; 185                     (BuffRx[IDX_FRAMING_BYTE] != ETB)) {
4128  004b f60000        	ldab	_BuffRx
4129  004e c102          	cmpb	#2
4130  0050 2713          	beq	L1072
4132  0052 c117          	cmpb	#23
4133  0054 270f          	beq	L1072
4134                     ; 187                     if (CntrBytes < UINT8_MAX) {
4136  0056 f639f6        	ldab	_CntrBytes
4137  0059 c1ff          	cmpb	#255
4138  005b 2405          	bhs	L3072
4139                     ; 190                         CntrBytes++;
4141  005d 7239f6        	inc	_CntrBytes
4143  0060 2020          	bra	L1172
4144  0062               L3072:
4145                     ; 196                             jmp $4000
4148  0062 064000        	jmp	$4000
4150  0065               L1072:
4151                     ; 203                     CntrBytes = 0;
4153  0065 7939f6        	clr	_CntrBytes
4154  0068 2018          	bra	L1172
4155  006a               L7762:
4156                     ; 206             else if (Index >= CMD_NUM_BYTES_MIN) {
4158  006a f639f1        	ldab	_Index
4159  006d c103          	cmpb	#3
4160  006f 2511          	blo	L1172
4161                     ; 209                 if ((Index-1) == BuffRx[IDX_MSG_LEN_BYTE]) {
4163  0071 b746          	tfr	d,y
4164  0073 03            	dey	
4165  0074 6d80          	sty	OFST-2,s
4166  0076 f60001        	ldab	_BuffRx+1
4167  0079 ac80          	cpd	OFST-2,s
4168  007b 2605          	bne	L1172
4169                     ; 211                     WasBTCmdRcvd = BTRUE;
4171  007d c601          	ldab	#1
4172  007f 7b39f2        	stab	_WasBTCmdRcvd
4173  0082               L1172:
4174                     ; 214             Index++;
4176  0082 7239f1        	inc	_Index
4177  0085               L5762:
4178                     ; 217         if (WasBTCmdRcvd) {
4180  0085 f739f2        	tst	_WasBTCmdRcvd
4181  0088 27a8          	beq	L1762
4182                     ; 225             Checksum = 0;
4184  008a 7939f4        	clr	_Checksum
4185                     ; 226             Index = BuffRx[IDX_MSG_LEN_BYTE]+1; // Get the checksum byte index.
4187  008d f60001        	ldab	_BuffRx+1
4188  0090 52            	incb	
4189  0091 7b39f1        	stab	_Index
4190                     ; 227             for (TempUINT8=IDX_MSG_LEN_BYTE;
4192  0094 c601          	ldab	#1
4193  0096 7b39f0        	stab	_TempUINT8
4195  0099 2012          	bra	L5272
4196  009b               L1272:
4197                     ; 230                 Checksum += BuffRx[TempUINT8];
4199  009b b796          	exg	b,y
4200  009d f639f4        	ldab	_Checksum
4201  00a0 ebea0000      	addb	_BuffRx,y
4202  00a4 7b39f4        	stab	_Checksum
4203                     ; 228                  TempUINT8 < Index;
4203                     ; 229                  TempUINT8++) {
4205  00a7 7239f0        	inc	_TempUINT8
4206  00aa f639f0        	ldab	_TempUINT8
4207  00ad               L5272:
4208                     ; 227             for (TempUINT8=IDX_MSG_LEN_BYTE;
4208                     ; 228                  TempUINT8 < Index;
4210  00ad f139f1        	cmpb	_Index
4211  00b0 25e9          	blo	L1272
4212                     ; 232             Checksum = 0xFF - Checksum;     // One's complement
4214  00b2 c6ff          	ldab	#255
4215  00b4 f039f4        	subb	_Checksum
4216  00b7 7b39f4        	stab	_Checksum
4217                     ; 234             if (Checksum == BuffRx[Index]) {
4219  00ba f639f1        	ldab	_Index
4220  00bd 87            	clra	
4221  00be b746          	tfr	d,y
4222  00c0 e6ea0000      	ldab	_BuffRx,y
4223  00c4 f139f4        	cmpb	_Checksum
4224  00c7 2606          	bne	L1372
4225                     ; 237                 processCommand();
4227  00c9 15fa038f      	lbsr	L5462_processCommand
4230  00cd 2005          	bra	L3372
4231  00cf               L1372:
4232                     ; 241                 ErrorNum = CHECKSUM_ERR;
4234  00cf c6ff          	ldab	#255
4235  00d1 7b39f3        	stab	_ErrorNum
4236  00d4               L3372:
4237                     ; 244             TX_MODE();             // Switch to transmit mode
4239  00d4 1d025002      	bclr	_PTM,2
4242  00d8 c608          	ldab	#8
4243  00da 5bcb          	stab	_SCI0CR2
4244                     ; 249             delayMilliseconds(20); // Delay 20ms before sending an ACK or NACK.
4247  00dc cc0014        	ldd	#20
4248  00df 0754          	lbsr	L3462_delayMilliseconds
4250                     ; 252             if (ErrorNum == NO_ERROR) {
4252  00e1 f739f3        	tst	_ErrorNum
4253  00e4 2622          	bne	L5372
4254                     ; 256                 SCI0DRL = ACK;
4256  00e6 c606          	ldab	#6
4257  00e8 5bcf          	stab	_SCI0DRL
4259  00ea               L3472:
4260                     ; 257                 while (!(SCI0SR1 & SCISCR1_SCISWAI)) {;}
4262  00ea 4fcc40fc      	brclr	_SCI0SR1,64,L3472
4263                     ; 261                 RX_MODE();
4265  00ee 1c025002      	bset	_PTM,2
4268  00f2 c604          	ldab	#4
4269  00f4 5bcb          	stab	_SCI0CR2
4270                     ; 262                 TempUINT8 = SCI0SR1;
4273  00f6 d6cc          	ldab	_SCI0SR1
4274                     ; 263                 TempUINT8 = SCI0DRL;
4276  00f8 d6cf          	ldab	_SCI0DRL
4277  00fa 7b39f0        	stab	_TempUINT8
4279  00fd               L7472:
4280                     ; 289             BuffRx[0] = 0;
4282  00fd 790000        	clr	_BuffRx
4283                     ; 290             Index = 0;
4285  0100 7939f1        	clr	_Index
4286                     ; 291             WasBTCmdRcvd = BFALSE;
4288  0103 7939f2        	clr	_WasBTCmdRcvd
4289  0106 2021          	bra	L1762
4290  0108               L5372:
4291                     ; 270                 SCI0DRL = NAK;
4293  0108 c615          	ldab	#21
4294  010a 5bcf          	stab	_SCI0DRL
4296  010c               L5572:
4297                     ; 271                 while (!(SCI0SR1 & SCISCR1_SCISWAI)) {;}
4299  010c 4fcc40fc      	brclr	_SCI0SR1,64,L5572
4300                     ; 275                 RX_MODE();
4302  0110 1c025002      	bset	_PTM,2
4305  0114 c604          	ldab	#4
4306  0116 5bcb          	stab	_SCI0CR2
4307                     ; 276                 TempUINT8 = SCI0SR1;
4310  0118 d6cc          	ldab	_SCI0SR1
4311                     ; 277                 TempUINT8 = SCI0DRL;
4313  011a d6cf          	ldab	_SCI0DRL
4314  011c 7b39f0        	stab	_TempUINT8
4315                     ; 281                 if (ErrorNum != CHECKSUM_ERR) {
4317  011f f639f3        	ldab	_ErrorNum
4318  0122 c1ff          	cmpb	#255
4319  0124 27d7          	beq	L7472
4320                     ; 283                         jmp $4000
4323  0126 064000        	jmp	$4000
4325  0129               L1762:
4326                     ; 171     while (BuffRx[IDX_FRAMING_BYTE] != ETB) {
4328  0129 f60000        	ldab	_BuffRx
4329  012c c117          	cmpb	#23
4330  012e 1826ff04      	bne	L5662
4331                     ; 297         jmp $4000
4334  0132 064000        	jmp	$4000
4336                     ; 300     return;
4384                     ; 313 _NEAR static void delayMilliseconds(
4384                     ; 314     UINT16 delay_ms)         // software delay in milliseconds
4384                     ; 315 {
4385                     	switch	.text
4386  0135               L3462_delayMilliseconds:
4388  0135 3b            	pshd	
4389  0136 1b9d          	leas	-3,s
4390       00000003      OFST:	set	3
4393                     ; 319     for (cntr_ms = 0;
4395  0138 87            	clra	
4396  0139 c7            	clrb	
4398  013a 2010          	bra	L7003
4399  013c               L3003:
4400                     ; 323         for (cntr1msLp = 0; cntr1msLp < 221; cntr1msLp++) {
4402  013c 6980          	clr	OFST-3,s
4403  013e               L3103:
4404                     ; 324             NOP();
4407  013e a7            	nop	
4409                     ; 323         for (cntr1msLp = 0; cntr1msLp < 221; cntr1msLp++) {
4411  013f 6280          	inc	OFST-3,s
4414  0141 e680          	ldab	OFST-3,s
4415  0143 c1dd          	cmpb	#221
4416  0145 25f7          	blo	L3103
4417                     ; 320          cntr_ms < delay_ms;
4417                     ; 321          cntr_ms++) {
4419  0147 ec81          	ldd	OFST-2,s
4420  0149 c30001        	addd	#1
4421  014c               L7003:
4422  014c 6c81          	std	OFST-2,s
4423                     ; 319     for (cntr_ms = 0;
4423                     ; 320          cntr_ms < delay_ms;
4425  014e ac83          	cpd	OFST+0,s
4426  0150 25ea          	blo	L3003
4427                     ; 328     return;
4430  0152 1b85          	leas	5,s
4431  0154 3d            	rts	
4460                     ; 414 _NEAR static UINT8 eraseFlash(void)
4460                     ; 415 {
4461                     	switch	.text
4462  0155               L1203_eraseFlash:
4466                     ; 419     FSTAT |= (FSTAT_PVIOL | FSTAT_ACCERR);
4468  0155 1c010530      	bset	_FSTAT,48
4470  0159               L5303:
4471                     ; 422     while (!(FSTAT & FSTAT_CBEIF)) {;}
4473  0159 1f010580fb    	brclr	_FSTAT,128,L5303
4474                     ; 425     for (TempUINT8=1; TempUINT8 <= 3; TempUINT8++) {
4476  015e c601          	ldab	#1
4477  0160 7b39f0        	stab	_TempUINT8
4478  0163               L1403:
4479                     ; 429         FCNFG = TempUINT8;
4481  0163 7b0103        	stab	_FCNFG
4482                     ; 433         PPAGE = CALC_BLK_START_PG(TempUINT8);
4484  0166 58            	lslb	
4485  0167 58            	lslb	
4486  0168 c03c          	subb	#60
4487  016a 50            	negb	
4488  016b 5b30          	stab	_PPAGE
4489                     ; 436         if ((FSTAT & FSTAT_CBEIF) == 0) {
4491  016d 1e01058003    	brset	_FSTAT,128,L7403
4492                     ; 437             return (ERASE_MEM_BUFF_NOT_EMPTY);
4494  0172 c602          	ldab	#2
4497  0174 3d            	rts	
4498  0175               L7403:
4499                     ; 444         *((volatile UINT16 *)FLASH_PAGE_START_ADDR) = 0xFFFF;
4501  0175 ccffff        	ldd	#-1
4502  0178 7c8000        	std	32768
4503                     ; 445         FCMD  = FLASH_MASS_ERASE;
4505  017b c641          	ldab	#65
4506  017d 7b0106        	stab	_FCMD
4507                     ; 446         FSTAT|= FSTAT_CBEIF;
4509  0180 1c010580      	bset	_FSTAT,128
4510                     ; 449         NOP();
4513  0184 a7            	nop	
4515                     ; 450         NOP();
4518  0185 a7            	nop	
4520                     ; 454         if (FSTAT & (FSTAT_PVIOL | FSTAT_ACCERR)) {
4522  0186 1f01053015    	brclr	_FSTAT,48,L1603
4523                     ; 455             if (FSTAT & FSTAT_PVIOL)  { FSTAT |= FSTAT_PVIOL;  }
4525  018b 1f01052004    	brclr	_FSTAT,32,L3503
4528  0190 1c010520      	bset	_FSTAT,32
4529  0194               L3503:
4530                     ; 456             if (FSTAT & FSTAT_ACCERR) { FSTAT |= FSTAT_ACCERR; }
4532  0194 1f01051004    	brclr	_FSTAT,16,L5503
4535  0199 1c010510      	bset	_FSTAT,16
4536  019d               L5503:
4537                     ; 457             return (ERASE_MEM_PVIOL_ACCERR_ERR);
4539  019d c601          	ldab	#1
4542  019f 3d            	rts	
4543  01a0               L1603:
4544                     ; 462         while (!(FSTAT & FSTAT_CBEIF));
4546  01a0 1f010580fb    	brclr	_FSTAT,128,L1603
4547                     ; 425     for (TempUINT8=1; TempUINT8 <= 3; TempUINT8++) {
4549  01a5 7239f0        	inc	_TempUINT8
4552  01a8 f639f0        	ldab	_TempUINT8
4553  01ab c103          	cmpb	#3
4554  01ad 23b4          	bls	L1403
4555                     ; 469     for (PageFlash = 0x3C; PageFlash <= 0x3F; PageFlash++) {
4557  01af c63c          	ldab	#60
4558  01b1 7b39f5        	stab	_PageFlash
4559  01b4               L5603:
4560                     ; 473         FCNFG = 0;
4562  01b4 790103        	clr	_FCNFG
4563                     ; 476         PPAGE = PageFlash;
4565  01b7 5b30          	stab	_PPAGE
4566                     ; 479         if ((FSTAT & FSTAT_CBEIF) == 0) {
4568  01b9 1e01058003    	brset	_FSTAT,128,L3703
4569                     ; 480             return (ERASE_MEM_BUFF_NOT_EMPTY);
4571  01be c602          	ldab	#2
4574  01c0 3d            	rts	
4575  01c1               L3703:
4576                     ; 490         for (Addr1 = FLASH_PAGE_START_ADDR;
4578  01c1 cc8000        	ldd	#-32768
4579  01c4 7c39fa        	std	_Addr1
4580  01c7               L5703:
4581                     ; 495             if ((PageFlash == 0x3F) && (Addr1 >= BT_PAGE_ST_ADDR_BNKD)) {
4583  01c7 f639f5        	ldab	_PageFlash
4584  01ca c13f          	cmpb	#63
4585  01cc 2608          	bne	L3013
4587  01ce fc39fa        	ldd	_Addr1
4588  01d1 8cb600        	cpd	#-18944
4589  01d4 2440          	bhs	L1013
4590                     ; 496                 break;
4592  01d6               L3013:
4593                     ; 503             *((volatile UINT16 *)Addr1) = 0xFFFF;
4595  01d6 ccffff        	ldd	#-1
4596  01d9 fd39fa        	ldy	_Addr1
4597  01dc 6c40          	std	0,y
4598                     ; 504             FCMD   = FLASH_SECTOR_ERASE;
4600  01de c640          	ldab	#64
4601  01e0 7b0106        	stab	_FCMD
4602                     ; 505             FSTAT |= FSTAT_CBEIF;
4604  01e3 1c010580      	bset	_FSTAT,128
4605                     ; 508             NOP();
4608  01e7 a7            	nop	
4610                     ; 509             NOP();
4613  01e8 a7            	nop	
4615                     ; 513             if (FSTAT & (FSTAT_PVIOL | FSTAT_ACCERR)) {
4617  01e9 1f01053015    	brclr	_FSTAT,48,L5113
4618                     ; 514                 if (FSTAT & FSTAT_PVIOL)  { FSTAT |= FSTAT_PVIOL;  }
4620  01ee 1f01052004    	brclr	_FSTAT,32,L7013
4623  01f3 1c010520      	bset	_FSTAT,32
4624  01f7               L7013:
4625                     ; 515                 if (FSTAT & FSTAT_ACCERR) { FSTAT |= FSTAT_ACCERR; }
4627  01f7 1f01051004    	brclr	_FSTAT,16,L1113
4630  01fc 1c010510      	bset	_FSTAT,16
4631  0200               L1113:
4632                     ; 516                 return (ERASE_MEM_PVIOL_ACCERR_ERR);
4634  0200 c601          	ldab	#1
4637  0202 3d            	rts	
4638  0203               L5113:
4639                     ; 521             while (!(FSTAT & FSTAT_CBEIF)) {;}
4641  0203 1f010580fb    	brclr	_FSTAT,128,L5113
4642                     ; 491              Addr1 < FLASH_PAGE_END_ADDR;
4642                     ; 492              Addr1 += NUM_FLASH_BYTES_PER_SECTOR) {
4644  0208 fc39fa        	ldd	_Addr1
4645  020b c30200        	addd	#512
4646  020e 7c39fa        	std	_Addr1
4647                     ; 490         for (Addr1 = FLASH_PAGE_START_ADDR;
4647                     ; 491              Addr1 < FLASH_PAGE_END_ADDR;
4649  0211 8cbfff        	cpd	#-16385
4650  0214 25b1          	blo	L5703
4651  0216               L1013:
4652                     ; 469     for (PageFlash = 0x3C; PageFlash <= 0x3F; PageFlash++) {
4654  0216 7239f5        	inc	_PageFlash
4657  0219 f639f5        	ldab	_PageFlash
4658  021c c13f          	cmpb	#63
4659  021e 2394          	bls	L5603
4661  0220               L3213:
4662                     ; 526     while (!(FSTAT & FSTAT_CCIF));
4664  0220 1f010540fb    	brclr	_FSTAT,64,L3213
4665                     ; 528     return (ERASE_MEM_NO_ERROR);
4667  0225 c7            	clrb	
4670  0226 3d            	rts	
4694                     ; 544 _NEAR static UINT8 eraseEEPROM(void)
4694                     ; 545 {
4695                     	switch	.text
4696  0227               L7213_eraseEEPROM:
4700                     ; 547     ESTAT |= (ESTAT_PVIOL | ESTAT_ACCERR);
4702  0227 1c011530      	bset	_ESTAT,48
4704  022b               L3413:
4705                     ; 550     while (!(ESTAT & ESTAT_CBEIF)) {;}
4707  022b 1f011580fb    	brclr	_ESTAT,128,L3413
4708                     ; 556     *((volatile UINT16 *)EE_START_ADDR) = 0xFFFF;
4710  0230 ccffff        	ldd	#-1
4711  0233 7c0400        	std	1024
4712                     ; 557     ECMD   = EE_MASS_ERASE;
4714  0236 c641          	ldab	#65
4715  0238 7b0116        	stab	_ECMD
4716                     ; 558     ESTAT |= ESTAT_CBEIF;
4718  023b 1c011580      	bset	_ESTAT,128
4719                     ; 561     NOP();
4722  023f a7            	nop	
4724                     ; 562     NOP();
4727  0240 a7            	nop	
4729                     ; 566     if (ESTAT & (ESTAT_PVIOL | ESTAT_ACCERR)) {
4731  0241 1f01153015    	brclr	_ESTAT,48,L7513
4732                     ; 567         if (ESTAT & ESTAT_PVIOL)  { ESTAT |= ESTAT_PVIOL;  }
4734  0246 1f01152004    	brclr	_ESTAT,32,L1513
4737  024b 1c011520      	bset	_ESTAT,32
4738  024f               L1513:
4739                     ; 568         if (ESTAT & ESTAT_ACCERR) { ESTAT |= ESTAT_ACCERR; }
4741  024f 1f01151004    	brclr	_ESTAT,16,L3513
4744  0254 1c011510      	bset	_ESTAT,16
4745  0258               L3513:
4746                     ; 569         return (ERASE_MEM_PVIOL_ACCERR_ERR);
4748  0258 c601          	ldab	#1
4751  025a 3d            	rts	
4752  025b               L7513:
4753                     ; 573     while (!(ESTAT & ESTAT_CCIF));
4755  025b 1f011540fb    	brclr	_ESTAT,64,L7513
4756                     ; 575     return (ERASE_MEM_NO_ERROR);
4758  0260 c7            	clrb	
4761  0261 3d            	rts	
4793                     ; 590 _NEAR static UINT8 programThenVerifyFlash(void)
4793                     ; 591 {
4794                     	switch	.text
4795  0262               L3613_programThenVerifyFlash:
4799                     ; 594 	TempUINT16 =
4799                     ; 595         ((UINT16)BuffRx[IDX_ADDR_START_BYTE_2] << 8) +
4799                     ; 596         BuffRx[IDX_ADDR_START_BYTE_1];
4801  0262 b60003        	ldaa	_BuffRx+3
4802  0265 f60004        	ldab	_BuffRx+4
4803  0268 7c39f8        	std	_TempUINT16
4804                     ; 597     TempUINT8 = (UINT8)(TempUINT16 >> 6);
4806  026b 49            	lsrd	
4807  026c 49            	lsrd	
4808  026d 49            	lsrd	
4809  026e 49            	lsrd	
4810  026f 49            	lsrd	
4811  0270 49            	lsrd	
4812  0271 7b39f0        	stab	_TempUINT8
4813                     ; 600     if ((TempUINT8 < 0x30) || (TempUINT8 > 0x3F)) {
4815  0274 c130          	cmpb	#48
4816  0276 2504          	blo	L7713
4818  0278 c13f          	cmpb	#63
4819  027a 2303          	bls	L5713
4820  027c               L7713:
4821                     ; 601         return(WRITE_MEM_RANGE_ERR);
4823  027c c603          	ldab	#3
4826  027e 3d            	rts	
4827  027f               L5713:
4828                     ; 612 	BuffRx[IDX_ADDR_START_BYTE_1] &= 0x3F;
4830  027f 1d0004c0      	bclr	_BuffRx+4,192
4831                     ; 613 	Addr1 = *((UINT16 *)&BuffRx[IDX_ADDR_START_BYTE_1]) + 0x8000; 
4833  0283 fc0004        	ldd	_BuffRx+4
4834  0286 c38000        	addd	#-32768
4835  0289 7c39fa        	std	_Addr1
4836                     ; 620     Addr2 = Addr1 + BuffRx[IDX_MSG_LEN_BYTE] - NUM_MSG_HDR_BYTES_FLASH;
4838  028c f60001        	ldab	_BuffRx+1
4839  028f 87            	clra	
4840  0290 f339fa        	addd	_Addr1
4841  0293 c3fffa        	addd	#-6
4842  0296 7c39fc        	std	_Addr2
4843                     ; 623 	if ((Addr1 < FLASH_PAGE_START_ADDR) ||
4843                     ; 624 		(Addr2 > FLASH_PAGE_END_ADDR)) {
4845  0299 fc39fa        	ldd	_Addr1
4846  029c 8c8000        	cpd	#-32768
4847  029f 2508          	blo	L3023
4849  02a1 fc39fc        	ldd	_Addr2
4850  02a4 8cbfff        	cpd	#-16385
4851  02a7 2303          	bls	L1023
4852  02a9               L3023:
4853                     ; 625         return(WRITE_MEM_RANGE_ERR);
4855  02a9 c603          	ldab	#3
4858  02ab 3d            	rts	
4859  02ac               L1023:
4860                     ; 630     if ((TempUINT8 == 0x3F) && (Addr2 >= BT_PAGE_ST_ADDR_BNKD)) {
4862  02ac f639f0        	ldab	_TempUINT8
4863  02af c13f          	cmpb	#63
4864  02b1 260a          	bne	L5023
4866  02b3 fc39fc        	ldd	_Addr2
4867  02b6 8cb600        	cpd	#-18944
4868  02b9 2502          	blo	L5023
4869                     ; 631         return (WRITE_MEM_NO_ERROR);
4871  02bb c7            	clrb	
4874  02bc 3d            	rts	
4875  02bd               L5023:
4876                     ; 637     if      (TempUINT8 < 0x34) { FCNFG = 3; } // flash block 3
4878  02bd f639f0        	ldab	_TempUINT8
4879  02c0 c134          	cmpb	#52
4880  02c2 2404          	bhs	L7023
4883  02c4 c603          	ldab	#3
4885  02c6 200e          	bra	LC001
4886  02c8               L7023:
4887                     ; 638     else if (TempUINT8 < 0x38) { FCNFG = 2; } // flash block 2
4889  02c8 c138          	cmpb	#56
4890  02ca 2404          	bhs	L3123
4893  02cc c602          	ldab	#2
4895  02ce 2006          	bra	LC001
4896  02d0               L3123:
4897                     ; 639     else if (TempUINT8 < 0x3C) { FCNFG = 1; } // flash block 1
4899  02d0 c13c          	cmpb	#60
4900  02d2 240a          	bhs	L7123
4903  02d4 c601          	ldab	#1
4904  02d6               LC001:
4905  02d6 7b0103        	stab	_FCNFG
4907  02d9 f639f0        	ldab	_TempUINT8
4908  02dc 2003          	bra	L1123
4909  02de               L7123:
4910                     ; 640     else                       { FCNFG = 0; } // flash block 0
4912  02de 790103        	clr	_FCNFG
4913  02e1               L1123:
4914                     ; 645     PPAGE = TempUINT8;
4916  02e1 5b30          	stab	_PPAGE
4917                     ; 656     if (Addr1 & 0x0001) {
4919  02e3 1f39fb0116    	brclr	_Addr1+1,1,L3223
4920                     ; 657         TempUINT8 = NUM_MSG_HDR_BYTES_FLASH - 1;
4922  02e8 c605          	ldab	#5
4923  02ea 7b39f0        	stab	_TempUINT8
4924                     ; 658         Addr1--;
4926  02ed fd39fa        	ldy	_Addr1
4927  02f0 03            	dey	
4928  02f1 7d39fa        	sty	_Addr1
4929                     ; 659         BuffRx[TempUINT8] = *((volatile UINT8 *)Addr1);
4931  02f4 fd39fa        	ldy	_Addr1
4932  02f7 e640          	ldab	0,y
4933  02f9 7b0005        	stab	_BuffRx+5
4935  02fc 2005          	bra	L5223
4936  02fe               L3223:
4937                     ; 662         TempUINT8 = NUM_MSG_HDR_BYTES_FLASH;
4939  02fe c606          	ldab	#6
4940  0300 7b39f0        	stab	_TempUINT8
4941  0303               L5223:
4942                     ; 670     if (!(Addr2 & 0x0001)) {
4944  0303 fc39fc        	ldd	_Addr2
4945  0306 c501          	bitb	#1
4946  0308 2614          	bne	L3323
4947                     ; 671         Addr2++;
4949  030a b746          	tfr	d,y
4950  030c 02            	iny	
4951  030d 7d39fc        	sty	_Addr2
4952                     ; 672         BuffRx[BuffRx[IDX_MSG_LEN_BYTE]+1] = *((volatile UINT8*)Addr2);
4954  0310 f60001        	ldab	_BuffRx+1
4955  0313 b796          	exg	b,y
4956  0315 fe39fc        	ldx	_Addr2
4957  0318 e600          	ldab	0,x
4958  031a 6bea0001      	stab	_BuffRx+1,y
4959  031e               L3323:
4960                     ; 676     while (!(FSTAT & FSTAT_CCIF));
4962  031e 1f010540fb    	brclr	_FSTAT,64,L3323
4964  0323 205c          	bra	L1423
4965  0325               L7323:
4966                     ; 683 		TempUINT16 = ((UINT16)BuffRx[TempUINT8] << 8) + BuffRx[TempUINT8+1];
4968  0325 f639f0        	ldab	_TempUINT8
4969  0328 87            	clra	
4970  0329 b746          	tfr	d,y
4971  032b b745          	tfr	d,x
4972  032d a6e20000      	ldaa	_BuffRx,x
4973  0331 e6ea0001      	ldab	_BuffRx+1,y
4974  0335 7c39f8        	std	_TempUINT16
4975                     ; 689         *((volatile UINT16 *)Addr1) = TempUINT16;
4977  0338 fd39fa        	ldy	_Addr1
4978  033b 6c40          	std	0,y
4979                     ; 690         FCMD   = FLASH_PROGRAM_WORD; // start command
4981  033d c620          	ldab	#32
4982  033f 7b0106        	stab	_FCMD
4983                     ; 691         FSTAT |= FSTAT_CBEIF;        // Launch command by setting CBEIF
4985  0342 1c010580      	bset	_FSTAT,128
4986                     ; 694         NOP();
4989  0346 a7            	nop	
4991                     ; 695         NOP();
4994  0347 a7            	nop	
4996                     ; 699         if (FSTAT & (FSTAT_PVIOL | FSTAT_ACCERR)) {
4998  0348 1f01053015    	brclr	_FSTAT,48,L5523
4999                     ; 700             if (FSTAT & FSTAT_PVIOL)  { FSTAT |= FSTAT_PVIOL;  }
5001  034d 1f01052004    	brclr	_FSTAT,32,L7423
5004  0352 1c010520      	bset	_FSTAT,32
5005  0356               L7423:
5006                     ; 701             if (FSTAT & FSTAT_ACCERR) { FSTAT |= FSTAT_ACCERR; }
5008  0356 1f01051004    	brclr	_FSTAT,16,L1523
5011  035b 1c010510      	bset	_FSTAT,16
5012  035f               L1523:
5013                     ; 702             return (ERASE_MEM_PVIOL_ACCERR_ERR);
5015  035f c601          	ldab	#1
5018  0361 3d            	rts	
5019  0362               L5523:
5020                     ; 706         while (!(FSTAT & FSTAT_CCIF));
5022  0362 1f010540fb    	brclr	_FSTAT,64,L5523
5023                     ; 709         if (*((volatile UINT16*)Addr1) != TempUINT16) {
5025  0367 fd39fa        	ldy	_Addr1
5026  036a ec40          	ldd	0,y
5027  036c bc39f8        	cpd	_TempUINT16
5028  036f 2703          	beq	L1623
5029                     ; 710             return (WRITE_MEM_VERIFY_ERR);
5031  0371 c604          	ldab	#4
5034  0373 3d            	rts	
5035  0374               L1623:
5036                     ; 714         TempUINT8 += BYTES_PER_WORD;
5038  0374 f639f0        	ldab	_TempUINT8
5039  0377 cb02          	addb	#2
5040  0379 7b39f0        	stab	_TempUINT8
5041                     ; 715         Addr1     += BYTES_PER_WORD;
5043  037c 1942          	leay	2,y
5044  037e 7d39fa        	sty	_Addr1
5045  0381               L1423:
5046                     ; 680     while (Addr1 < Addr2) {
5048  0381 fc39fa        	ldd	_Addr1
5049  0384 bc39fc        	cpd	_Addr2
5050  0387 259c          	blo	L7323
5051                     ; 719     return (WRITE_MEM_NO_ERROR);
5053  0389 c7            	clrb	
5056  038a 3d            	rts	
5086                     ; 734 _NEAR static UINT8 programThenVerifyEEPROM(void)
5086                     ; 735 {
5087                     	switch	.text
5088  038b               L3623_programThenVerifyEEPROM:
5092                     ; 738     Addr1 = ((UINT16)BuffRx[IDX_ADDR_START_BYTE_2] << 8) +
5092                     ; 739             BuffRx[IDX_ADDR_START_BYTE_1];
5094  038b b60003        	ldaa	_BuffRx+3
5095  038e f60004        	ldab	_BuffRx+4
5096  0391 7c39fa        	std	_Addr1
5097                     ; 742     Addr2 = Addr1 + BuffRx[IDX_MSG_LEN_BYTE] - NUM_MSG_HDR_BYTES_EEPROM;
5099  0394 f60001        	ldab	_BuffRx+1
5100  0397 87            	clra	
5101  0398 f339fa        	addd	_Addr1
5102  039b c3fffb        	addd	#-5
5103  039e 7c39fc        	std	_Addr2
5104                     ; 745     if ((Addr1 < EE_START_ADDR) ||
5104                     ; 746         (Addr2 > EE_END_ADDR)) {
5106  03a1 fc39fa        	ldd	_Addr1
5107  03a4 8c0400        	cpd	#1024
5108  03a7 2508          	blo	L7723
5110  03a9 fc39fc        	ldd	_Addr2
5111  03ac 8c0fef        	cpd	#4079
5112  03af 2303          	bls	L5723
5113  03b1               L7723:
5114                     ; 747         return (WRITE_MEM_RANGE_ERR);
5116  03b1 c603          	ldab	#3
5119  03b3 3d            	rts	
5120  03b4               L5723:
5121                     ; 759     if (Addr1 & 0x0001) {
5123  03b4 1f39fb0116    	brclr	_Addr1+1,1,L1033
5124                     ; 760         TempUINT8 = NUM_MSG_HDR_BYTES_EEPROM - 1;
5126  03b9 c604          	ldab	#4
5127  03bb 7b39f0        	stab	_TempUINT8
5128                     ; 761         Addr1--;
5130  03be fd39fa        	ldy	_Addr1
5131  03c1 03            	dey	
5132  03c2 7d39fa        	sty	_Addr1
5133                     ; 762         BuffRx[TempUINT8] = *((volatile UINT8*)Addr1);
5135  03c5 fd39fa        	ldy	_Addr1
5136  03c8 e640          	ldab	0,y
5137  03ca 7b0004        	stab	_BuffRx+4
5139  03cd 2005          	bra	L3033
5140  03cf               L1033:
5141                     ; 765         TempUINT8 = NUM_MSG_HDR_BYTES_EEPROM;
5143  03cf c605          	ldab	#5
5144  03d1 7b39f0        	stab	_TempUINT8
5145  03d4               L3033:
5146                     ; 773     if (!(Addr2 & 0x0001)) {
5148  03d4 fc39fc        	ldd	_Addr2
5149  03d7 c501          	bitb	#1
5150  03d9 2614          	bne	L1133
5151                     ; 774         Addr2++;
5153  03db b746          	tfr	d,y
5154  03dd 02            	iny	
5155  03de 7d39fc        	sty	_Addr2
5156                     ; 775         BuffRx[BuffRx[IDX_MSG_LEN_BYTE]+1] = *((volatile UINT8*)Addr2);
5158  03e1 f60001        	ldab	_BuffRx+1
5159  03e4 b796          	exg	b,y
5160  03e6 fe39fc        	ldx	_Addr2
5161  03e9 e600          	ldab	0,x
5162  03eb 6bea0001      	stab	_BuffRx+1,y
5163  03ef               L1133:
5164                     ; 779     while (!(ESTAT & ESTAT_CCIF));
5166  03ef 1f011540fb    	brclr	_ESTAT,64,L1133
5168  03f4 205c          	bra	L7133
5169  03f6               L5133:
5170                     ; 786         TempUINT16 = ((UINT16)BuffRx[TempUINT8] << 8) + BuffRx[TempUINT8+1];
5172  03f6 f639f0        	ldab	_TempUINT8
5173  03f9 87            	clra	
5174  03fa b746          	tfr	d,y
5175  03fc b745          	tfr	d,x
5176  03fe a6e20000      	ldaa	_BuffRx,x
5177  0402 e6ea0001      	ldab	_BuffRx+1,y
5178  0406 7c39f8        	std	_TempUINT16
5179                     ; 792         *((volatile UINT16*)Addr1) = TempUINT16;
5181  0409 fd39fa        	ldy	_Addr1
5182  040c 6c40          	std	0,y
5183                     ; 793         ECMD   = EE_PROGRAM_WORD;
5185  040e c620          	ldab	#32
5186  0410 7b0116        	stab	_ECMD
5187                     ; 794         ESTAT |= ESTAT_CBEIF;
5189  0413 1c011580      	bset	_ESTAT,128
5190                     ; 797         NOP();
5193  0417 a7            	nop	
5195                     ; 798         NOP();
5198  0418 a7            	nop	
5200                     ; 802         if (ESTAT & (ESTAT_PVIOL | ESTAT_ACCERR)) {
5202  0419 1f01153015    	brclr	_ESTAT,48,L3333
5203                     ; 803             if (ESTAT & ESTAT_PVIOL)  { ESTAT |= ESTAT_PVIOL;  }
5205  041e 1f01152004    	brclr	_ESTAT,32,L5233
5208  0423 1c011520      	bset	_ESTAT,32
5209  0427               L5233:
5210                     ; 804             if (ESTAT & ESTAT_ACCERR) { ESTAT |= ESTAT_ACCERR; }
5212  0427 1f01151004    	brclr	_ESTAT,16,L7233
5215  042c 1c011510      	bset	_ESTAT,16
5216  0430               L7233:
5217                     ; 805             return (ERASE_MEM_PVIOL_ACCERR_ERR);
5219  0430 c601          	ldab	#1
5222  0432 3d            	rts	
5223  0433               L3333:
5224                     ; 809         while (!(ESTAT & ESTAT_CCIF));
5226  0433 1f011540fb    	brclr	_ESTAT,64,L3333
5227                     ; 812         if (*((volatile UINT16*)Addr1) != TempUINT16) {
5229  0438 fd39fa        	ldy	_Addr1
5230  043b ec40          	ldd	0,y
5231  043d bc39f8        	cpd	_TempUINT16
5232  0440 2703          	beq	L7333
5233                     ; 813             return (WRITE_MEM_VERIFY_ERR);
5235  0442 c604          	ldab	#4
5238  0444 3d            	rts	
5239  0445               L7333:
5240                     ; 817         TempUINT8 += BYTES_PER_WORD;
5242  0445 f639f0        	ldab	_TempUINT8
5243  0448 cb02          	addb	#2
5244  044a 7b39f0        	stab	_TempUINT8
5245                     ; 818         Addr1     += BYTES_PER_WORD;
5247  044d 1942          	leay	2,y
5248  044f 7d39fa        	sty	_Addr1
5249  0452               L7133:
5250                     ; 783     while (Addr1 < Addr2) {
5252  0452 fc39fa        	ldd	_Addr1
5253  0455 bc39fc        	cpd	_Addr2
5254  0458 259c          	blo	L5133
5255                     ; 821     return (WRITE_MEM_NO_ERROR);
5257  045a c7            	clrb	
5260  045b 3d            	rts	
5290                     ; 830 _NEAR static void processCommand(void)
5290                     ; 831 {
5291                     	switch	.text
5292  045c               L5462_processCommand:
5296                     ; 832     switch (BuffRx[IDX_CMD_BYTE]) {
5298  045c f60002        	ldab	_BuffRx+2
5300  045f c055          	subb	#85
5301  0461 2710          	beq	L1433
5302  0463 c011          	subb	#17
5303  0465 2718          	beq	L5433
5304  0467 c033          	subb	#51
5305  0469 271a          	beq	L7433
5306  046b c011          	subb	#17
5307  046d 270a          	beq	L3433
5308                     ; 849         default: // wrong command received
5308                     ; 850              ErrorNum = 1;
5310  046f c601          	ldab	#1
5311                     ; 851              break;
5313  0471 2015          	bra	L5633
5314  0473               L1433:
5315                     ; 833         case BT_CMD_FLASH_ERASE:
5315                     ; 834              ErrorNum = eraseFlash();
5317  0473 15fafcde      	lbsr	L1203_eraseFlash
5319                     ; 835              break;
5321  0477 200f          	bra	L5633
5322  0479               L3433:
5323                     ; 837         case BT_CMD_EEPROM_ERASE:
5323                     ; 838              ErrorNum = eraseEEPROM();
5325  0479 15fafdaa      	lbsr	L7213_eraseEEPROM
5327                     ; 839              break;
5329  047d 2009          	bra	L5633
5330  047f               L5433:
5331                     ; 841         case BT_CMD_FLASH_PGM_VER:
5331                     ; 842              ErrorNum = programThenVerifyFlash();
5333  047f 15fafddf      	lbsr	L3613_programThenVerifyFlash
5335                     ; 843              break;
5337  0483 2003          	bra	L5633
5338  0485               L7433:
5339                     ; 845         case BT_CMD_EEPROM_PGM_VER:
5339                     ; 846              ErrorNum = programThenVerifyEEPROM();
5341  0485 15f903        	lbsr	L3623_programThenVerifyEEPROM
5343                     ; 847              break;
5345  0488               L5633:
5346  0488 7b39f3        	stab	_ErrorNum
5347                     ; 854     PPAGE = 0; // reset to page 0 (default)
5349  048b c7            	clrb	
5350  048c 5b30          	stab	_PPAGE
5351                     ; 855     FCNFG = 0; // reset to block 0
5353  048e 790103        	clr	_FCNFG
5354                     ; 857     return;
5357  0491 3d            	rts	
5441                     	xdef	_BootLoaderToRunFromRAM
5442                     	xref	_BuffRx
5462                     	end
