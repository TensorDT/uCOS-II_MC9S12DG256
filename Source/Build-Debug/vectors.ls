   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
  14                     .const:	section	.data
  15  0000               __vect:
  17  0000 0000          	dc.w	_SoftwareTrap63
  19  0002 0000          	dc.w	_SoftwareTrap62
  21  0004 0000          	dc.w	_SoftwareTrap61
  23  0006 0000          	dc.w	_SoftwareTrap60
  25  0008 0000          	dc.w	_SoftwareTrap59
  27  000a 0000          	dc.w	_SoftwareTrap58
  29  000c 0000          	dc.w	_SoftwareTrap57
  31  000e 0000          	dc.w	_SoftwareTrap56
  33  0010 0000          	dc.w	_SoftwareTrap55
  35  0012 0000          	dc.w	_SoftwareTrap54
  37  0014 0000          	dc.w	_SoftwareTrap53
  39  0016 0000          	dc.w	_SoftwareTrap52
  41  0018 0000          	dc.w	_SoftwareTrap51
  43  001a 0000          	dc.w	_SoftwareTrap50
  45  001c 0000          	dc.w	_SoftwareTrap49
  47  001e 0000          	dc.w	_SoftwareTrap48
  49  0020 0000          	dc.w	_SoftwareTrap47
  51  0022 0000          	dc.w	_SoftwareTrap46
  53  0024 0000          	dc.w	_SoftwareTrap45
  55  0026 0000          	dc.w	_SoftwareTrap44
  57  0028 0000          	dc.w	_SoftwareTrap43
  59  002a 0000          	dc.w	_SoftwareTrap42
  61  002c 0000          	dc.w	_SoftwareTrap41
  63  002e 0000          	dc.w	_SoftwareTrap40
  65  0030 0000          	dc.w	_SoftwareTrap39
  67  0032 0000          	dc.w	_SoftwareTrap38
  69  0034 0000          	dc.w	_SoftwareTrap37
  71  0036 0000          	dc.w	_SoftwareTrap36
  73  0038 0000          	dc.w	_SoftwareTrap35
  75  003a 0000          	dc.w	_SoftwareTrap34
  77  003c 0000          	dc.w	_SoftwareTrap33
  79  003e 0000          	dc.w	_SoftwareTrap32
  81  0040 0000          	dc.w	_SoftwareTrap31
  83  0042 0000          	dc.w	_SoftwareTrap30
  85  0044 0000          	dc.w	_SoftwareTrap29
  87  0046 0000          	dc.w	_SoftwareTrap28
  89  0048 0000          	dc.w	_SoftwareTrap27
  91  004a 0000          	dc.w	_SoftwareTrap26
  93  004c 0000          	dc.w	_SoftwareTrap25
  95  004e 0000          	dc.w	_SoftwareTrap24
  97  0050 0000          	dc.w	_SoftwareTrap23
  99  0052 0000          	dc.w	_SoftwareTrap22
 101  0054 0000          	dc.w	_SoftwareTrap21
 103  0056 0000          	dc.w	_SoftwareTrap20
 105  0058 0000          	dc.w	_SoftwareTrap19
 107  005a 0000          	dc.w	_SoftwareTrap18
 109  005c 0000          	dc.w	_SoftwareTrap17
 111  005e 0000          	dc.w	_SoftwareTrap16
 113  0060 0000          	dc.w	_OSTickISR
 115  0062 0000          	dc.w	_SoftwareTrap14
 117  0064 0000          	dc.w	_SoftwareTrap13
 119  0066 0000          	dc.w	_SoftwareTrap12
 121  0068 0000          	dc.w	_SoftwareTrap11
 123  006a 0000          	dc.w	_SoftwareTrap10
 125  006c 0000          	dc.w	_SoftwareTrap09
 127  006e 0000          	dc.w	_SoftwareTrap08
 129  0070 0000          	dc.w	_SoftwareTrap07
 131  0072 0000          	dc.w	_SoftwareTrap06
 133  0074 0000          	dc.w	_SoftwareTrap05
 135  0076 0000          	dc.w	_OSCtxSw
 137  0078 0000          	dc.w	_SoftwareTrap03
 139  007a 0000          	dc.w	_SoftwareTrap02
 141  007c 0000          	dc.w	_SoftwareTrap01
 142  007e f800          	dc.w	-2048
 176                     	xdef	__vect
 177                     	xref	_OSCtxSw
 178                     	xref	_OSTickISR
 179                     	xref	_SoftwareTrap01
 180                     	xref	_SoftwareTrap02
 181                     	xref	_SoftwareTrap03
 182                     	xref	_SoftwareTrap05
 183                     	xref	_SoftwareTrap06
 184                     	xref	_SoftwareTrap07
 185                     	xref	_SoftwareTrap08
 186                     	xref	_SoftwareTrap09
 187                     	xref	_SoftwareTrap10
 188                     	xref	_SoftwareTrap11
 189                     	xref	_SoftwareTrap12
 190                     	xref	_SoftwareTrap13
 191                     	xref	_SoftwareTrap14
 192                     	xref	_SoftwareTrap16
 193                     	xref	_SoftwareTrap17
 194                     	xref	_SoftwareTrap18
 195                     	xref	_SoftwareTrap19
 196                     	xref	_SoftwareTrap20
 197                     	xref	_SoftwareTrap21
 198                     	xref	_SoftwareTrap22
 199                     	xref	_SoftwareTrap23
 200                     	xref	_SoftwareTrap24
 201                     	xref	_SoftwareTrap25
 202                     	xref	_SoftwareTrap26
 203                     	xref	_SoftwareTrap27
 204                     	xref	_SoftwareTrap28
 205                     	xref	_SoftwareTrap29
 206                     	xref	_SoftwareTrap30
 207                     	xref	_SoftwareTrap31
 208                     	xref	_SoftwareTrap32
 209                     	xref	_SoftwareTrap33
 210                     	xref	_SoftwareTrap34
 211                     	xref	_SoftwareTrap35
 212                     	xref	_SoftwareTrap36
 213                     	xref	_SoftwareTrap37
 214                     	xref	_SoftwareTrap38
 215                     	xref	_SoftwareTrap39
 216                     	xref	_SoftwareTrap40
 217                     	xref	_SoftwareTrap41
 218                     	xref	_SoftwareTrap42
 219                     	xref	_SoftwareTrap43
 220                     	xref	_SoftwareTrap44
 221                     	xref	_SoftwareTrap45
 222                     	xref	_SoftwareTrap46
 223                     	xref	_SoftwareTrap47
 224                     	xref	_SoftwareTrap48
 225                     	xref	_SoftwareTrap49
 226                     	xref	_SoftwareTrap50
 227                     	xref	_SoftwareTrap51
 228                     	xref	_SoftwareTrap52
 229                     	xref	_SoftwareTrap53
 230                     	xref	_SoftwareTrap54
 231                     	xref	_SoftwareTrap55
 232                     	xref	_SoftwareTrap56
 233                     	xref	_SoftwareTrap57
 234                     	xref	_SoftwareTrap58
 235                     	xref	_SoftwareTrap59
 236                     	xref	_SoftwareTrap60
 237                     	xref	_SoftwareTrap61
 238                     	xref	_SoftwareTrap62
 239                     	xref	_SoftwareTrap63
 259                     	end
