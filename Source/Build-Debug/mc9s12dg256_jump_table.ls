   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
  44                     ; 66 void JUMP_TABLE(void) 
  44                     ; 67 {
  45                     	switch	.text
  46  0000               _JUMP_TABLE:
  50                     ; 71     xref  _SoftwareTrap63, _SoftwareTrap62, _SoftwareTrap61, _SoftwareTrap60
  53                     xref  _SoftwareTrap63, _SoftwareTrap62, _SoftwareTrap61, _SoftwareTrap60
  55                     ; 72     xref  _SoftwareTrap59, _SoftwareTrap58, _SoftwareTrap57, _SoftwareTrap56
  58                     xref  _SoftwareTrap59, _SoftwareTrap58, _SoftwareTrap57, _SoftwareTrap56
  60                     ; 73     xref  _SoftwareTrap55, _SoftwareTrap54, _SoftwareTrap53, _SoftwareTrap52
  63                     xref  _SoftwareTrap55, _SoftwareTrap54, _SoftwareTrap53, _SoftwareTrap52
  65                     ; 74     xref  _SoftwareTrap51, _SoftwareTrap50, _SoftwareTrap49, _SoftwareTrap48
  68                     xref  _SoftwareTrap51, _SoftwareTrap50, _SoftwareTrap49, _SoftwareTrap48
  70                     ; 75     xref  _SoftwareTrap47, _SoftwareTrap46, _SoftwareTrap45, _SoftwareTrap44
  73                     xref  _SoftwareTrap47, _SoftwareTrap46, _SoftwareTrap45, _SoftwareTrap44
  75                     ; 76     xref  _SoftwareTrap43, _SoftwareTrap42, _SoftwareTrap41, _SoftwareTrap40
  78                     xref  _SoftwareTrap43, _SoftwareTrap42, _SoftwareTrap41, _SoftwareTrap40
  80                     ; 77     xref  _SoftwareTrap39, _SoftwareTrap38, _SoftwareTrap37, _SoftwareTrap36
  83                     xref  _SoftwareTrap39, _SoftwareTrap38, _SoftwareTrap37, _SoftwareTrap36
  85                     ; 78     xref  _SoftwareTrap35, _SoftwareTrap34, _SoftwareTrap33, _SoftwareTrap32
  88                     xref  _SoftwareTrap35, _SoftwareTrap34, _SoftwareTrap33, _SoftwareTrap32
  90                     ; 79     xref  _SoftwareTrap31, _SoftwareTrap30, _SoftwareTrap29, _SoftwareTrap28
  93                     xref  _SoftwareTrap31, _SoftwareTrap30, _SoftwareTrap29, _SoftwareTrap28
  95                     ; 80     xref  _SoftwareTrap27, _SoftwareTrap26, _SoftwareTrap25, _SoftwareTrap24
  98                     xref  _SoftwareTrap27, _SoftwareTrap26, _SoftwareTrap25, _SoftwareTrap24
 100                     ; 81     xref  _SoftwareTrap23, _SoftwareTrap22, _SoftwareTrap21, _SoftwareTrap20
 103                     xref  _SoftwareTrap23, _SoftwareTrap22, _SoftwareTrap21, _SoftwareTrap20
 105                     ; 82     xref  _SoftwareTrap19, _SoftwareTrap18, _SoftwareTrap17, _SoftwareTrap16
 108                     xref  _SoftwareTrap19, _SoftwareTrap18, _SoftwareTrap17, _SoftwareTrap16
 110                     ; 83     xref  _SoftwareTrap15, _SoftwareTrap14, _SoftwareTrap13, _SoftwareTrap12
 113                     xref  _SoftwareTrap15, _SoftwareTrap14, _SoftwareTrap13, _SoftwareTrap12
 115                     ; 84     xref  _SoftwareTrap11, _SoftwareTrap10, _SoftwareTrap09, _SoftwareTrap08
 118                     xref  _SoftwareTrap11, _SoftwareTrap10, _SoftwareTrap09, _SoftwareTrap08
 120                     ; 85     xref  _SoftwareTrap07, _SoftwareTrap06, _SoftwareTrap05, _SoftwareTrap04
 123                     xref  _SoftwareTrap07, _SoftwareTrap06, _SoftwareTrap05, _SoftwareTrap04
 125                     ; 86     xref  _SoftwareTrap03, _SoftwareTrap02, _SoftwareTrap01
 128                     xref  _SoftwareTrap03, _SoftwareTrap02, _SoftwareTrap01
 130                     ; 87     xref  _OSTickISR, _OSCtxSw
 133                     xref  _OSTickISR, _OSCtxSw
 135                     ; 89     jmp   _SoftwareTrap63    //  0xFF400  INT80 reserved
 138  0000 060000        	jmp	_SoftwareTrap63
 140                     ; 90     jmp   _SoftwareTrap62    //  0xFF403 INT82 reserved
 143  0003 060000        	jmp	_SoftwareTrap62
 145                     ; 91     jmp   _SoftwareTrap61    //  0xFF406 INT84 reserved
 148  0006 060000        	jmp	_SoftwareTrap61
 150                     ; 92     jmp   _SoftwareTrap60    //  0xFF409 INT86 reserved
 153  0009 060000        	jmp	_SoftwareTrap60
 155                     ; 93     jmp   _SoftwareTrap59    //  0xFF40C INT88 reserved
 158  000c 060000        	jmp	_SoftwareTrap59
 160                     ; 94     jmp   _SoftwareTrap58    //  0xFF40F INT8A reserved
 163  000f 060000        	jmp	_SoftwareTrap58
 165                     ; 95     jmp   _SoftwareTrap57    //  0xFF412 PWM Emergency Shutdown
 168  0012 060000        	jmp	_SoftwareTrap57
 170                     ; 96     jmp   _SoftwareTrap56    //  0xFF415 Port P Interrupt
 173  0015 060000        	jmp	_SoftwareTrap56
 175                     ; 97     jmp   _SoftwareTrap55    //  0xFF418 MSCAN 4 transmit
 178  0018 060000        	jmp	_SoftwareTrap55
 180                     ; 98     jmp   _SoftwareTrap54    //  0xFF41B MSCAN 4 receive
 183  001b 060000        	jmp	_SoftwareTrap54
 185                     ; 99     jmp   _SoftwareTrap53    //  0xFF41E MSCAN 4 errors
 188  001e 060000        	jmp	_SoftwareTrap53
 190                     ; 100     jmp   _SoftwareTrap52    //  0xFF421 MSCAN 4 wake-up
 193  0021 060000        	jmp	_SoftwareTrap52
 195                     ; 101     jmp   _SoftwareTrap51    //  0xFF424 MSCAN 3 transmit
 198  0024 060000        	jmp	_SoftwareTrap51
 200                     ; 102     jmp   _SoftwareTrap50    //  0xFF427 MSCAN 3 receive
 203  0027 060000        	jmp	_SoftwareTrap50
 205                     ; 103     jmp   _SoftwareTrap49    //  0xFF42A MSCAN 3 errors
 208  002a 060000        	jmp	_SoftwareTrap49
 210                     ; 104     jmp   _SoftwareTrap48    //  0xFF42D MSCAN 3 wake-up
 213  002d 060000        	jmp	_SoftwareTrap48
 215                     ; 105     jmp   _SoftwareTrap47    //  0xFF430 MSCAN 2 transmit
 218  0030 060000        	jmp	_SoftwareTrap47
 220                     ; 106     jmp   _SoftwareTrap46    //  0xFF433 MSCAN 2 receive
 223  0033 060000        	jmp	_SoftwareTrap46
 225                     ; 107     jmp   _SoftwareTrap45    //  0xFF436 MSCAN 2 errors
 228  0036 060000        	jmp	_SoftwareTrap45
 230                     ; 108     jmp   _SoftwareTrap44    //  0xFF439 MSCAN 2 wake-up
 233  0039 060000        	jmp	_SoftwareTrap44
 235                     ; 109     jmp   _SoftwareTrap43    //  0xFF43C MSCAN 1 transmit
 238  003c 060000        	jmp	_SoftwareTrap43
 240                     ; 110     jmp   _SoftwareTrap42    //  0xFF43F MSCAN 1 receive
 243  003f 060000        	jmp	_SoftwareTrap42
 245                     ; 111     jmp   _SoftwareTrap41    //  0xFF442 MSCAN 1 errors
 248  0042 060000        	jmp	_SoftwareTrap41
 250                     ; 112     jmp   _SoftwareTrap40    //  0xFF445 MSCAN 1 wake-up
 253  0045 060000        	jmp	_SoftwareTrap40
 255                     ; 113     jmp   _SoftwareTrap39    //  0xFF448 MSCAN 0 transmit
 258  0048 060000        	jmp	_SoftwareTrap39
 260                     ; 114     jmp   _SoftwareTrap38    //  0xFF44B MSCAN 0 receive
 263  004b 060000        	jmp	_SoftwareTrap38
 265                     ; 115     jmp   _SoftwareTrap37    //  0xFF44E MSCAN 0 errors
 268  004e 060000        	jmp	_SoftwareTrap37
 270                     ; 116     jmp   _SoftwareTrap36    //  0xFF451 MSCAN 0 wake-up
 273  0051 060000        	jmp	_SoftwareTrap36
 275                     ; 117     jmp   _SoftwareTrap35    //  0xFF454 FLASH
 278  0054 060000        	jmp	_SoftwareTrap35
 280                     ; 118     jmp   _SoftwareTrap34    //  0xFF457 EEPROM
 283  0057 060000        	jmp	_SoftwareTrap34
 285                     ; 119     jmp   _SoftwareTrap33    //  0xFF45A SPI2
 288  005a 060000        	jmp	_SoftwareTrap33
 290                     ; 120     jmp   _SoftwareTrap32    //  0xFF45D SPI1
 293  005d 060000        	jmp	_SoftwareTrap32
 295                     ; 121     jmp   _SoftwareTrap31    //  0xFF460 IIC Bus
 298  0060 060000        	jmp	_SoftwareTrap31
 300                     ; 122     jmp   _SoftwareTrap30    //  0xFF463 DLC
 303  0063 060000        	jmp	_SoftwareTrap30
 305                     ; 123     jmp   _SoftwareTrap29    //  0xFF466 SCME
 308  0066 060000        	jmp	_SoftwareTrap29
 310                     ; 124     jmp   _SoftwareTrap28    //  0xFF469 CRG lock
 313  0069 060000        	jmp	_SoftwareTrap28
 315                     ; 125     jmp   _SoftwareTrap27    //  0xFF46C Pulse Accumulator B Overflow
 318  006c 060000        	jmp	_SoftwareTrap27
 320                     ; 126     jmp   _SoftwareTrap26    //  0xFF46F Modulus Down Counter underflow
 323  006f 060000        	jmp	_SoftwareTrap26
 325                     ; 127     jmp   _SoftwareTrap25    //  0xFF472 Port H
 328  0072 060000        	jmp	_SoftwareTrap25
 330                     ; 128     jmp   _SoftwareTrap24    //  0xFF475 Port J
 333  0075 060000        	jmp	_SoftwareTrap24
 335                     ; 129     jmp   _SoftwareTrap23    //  0xFF478 ATD1
 338  0078 060000        	jmp	_SoftwareTrap23
 340                     ; 130     jmp   _SoftwareTrap22    //  0xFF47B ATD0
 343  007b 060000        	jmp	_SoftwareTrap22
 345                     ; 131     jmp   _SoftwareTrap21    //  0xFF47E SCI 1
 348  007e 060000        	jmp	_SoftwareTrap21
 350                     ; 132     jmp   _SoftwareTrap20    //  0xFF481 SCI 0
 353  0081 060000        	jmp	_SoftwareTrap20
 355                     ; 133     jmp   _SoftwareTrap19    //  0xFF484 SPI0
 358  0084 060000        	jmp	_SoftwareTrap19
 360                     ; 134     jmp   _SoftwareTrap18    //  0xFF487 Pulse accumulator input edge
 363  0087 060000        	jmp	_SoftwareTrap18
 365                     ; 135     jmp   _SoftwareTrap17    //  0xFF48A Pulse accumulator A overflow
 368  008a 060000        	jmp	_SoftwareTrap17
 370                     ; 136     jmp   _SoftwareTrap16    //  0xFF48D Timer overflow
 373  008d 060000        	jmp	_SoftwareTrap16
 375                     ; 137     jmp   _OSTickISR         //  0xFF490 Timer channel 7
 378  0090 060000        	jmp	_OSTickISR
 380                     ; 138     jmp   _SoftwareTrap14    //  0xFF493 Timer channel 6
 383  0093 060000        	jmp	_SoftwareTrap14
 385                     ; 139     jmp   _SoftwareTrap13    //  0xFF496 Timer channel 5
 388  0096 060000        	jmp	_SoftwareTrap13
 390                     ; 140     jmp   _SoftwareTrap12    //  0xFF499 Timer channel 4
 393  0099 060000        	jmp	_SoftwareTrap12
 395                     ; 141     jmp   _SoftwareTrap11    //  0xFF49C Timer channel 3
 398  009c 060000        	jmp	_SoftwareTrap11
 400                     ; 142     jmp   _SoftwareTrap10    //  0xFF49F Timer channel 2
 403  009f 060000        	jmp	_SoftwareTrap10
 405                     ; 143     jmp   _SoftwareTrap09    //  0xFF4A2 Timer channel 1
 408  00a2 060000        	jmp	_SoftwareTrap09
 410                     ; 144     jmp   _SoftwareTrap08    //  0xFF4A5 Timer channel 0
 413  00a5 060000        	jmp	_SoftwareTrap08
 415                     ; 145     jmp   _SoftwareTrap07    //  0xFF4A8 Real Time Interrupt
 418  00a8 060000        	jmp	_SoftwareTrap07
 420                     ; 146     jmp   _SoftwareTrap06    //  0xFF4AB IRQ
 423  00ab 060000        	jmp	_SoftwareTrap06
 425                     ; 147     jmp   _SoftwareTrap05    //  0xFF4AE XIRQ
 428  00ae 060000        	jmp	_SoftwareTrap05
 430                     ; 148     jmp   _OSCtxSw           //  0xFF4B1 SWI
 433  00b1 060000        	jmp	_OSCtxSw
 435                     ; 149     jmp   _SoftwareTrap03    //  0xFF4B4 Unimplemented instruction trap (illegal instruction)
 438  00b4 060000        	jmp	_SoftwareTrap03
 440                     ; 150     jmp   _SoftwareTrap02    //  0xFF4B7 COP failure reset
 443  00b7 060000        	jmp	_SoftwareTrap02
 445                     ; 151     jmp   _SoftwareTrap01    //  0xFF4BA Clock Monitor fail reset
 448  00ba 060000        	jmp	_SoftwareTrap01
 450                     ; 153 }
 464                     	xdef	_JUMP_TABLE
 484                     	end
