   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
1065                     .const:	section	.data
1066  0000               _OSUnMapTbl:
1067  0000 00            	dc.b	0
1068  0001 00            	dc.b	0
1069  0002 01            	dc.b	1
1070  0003 00            	dc.b	0
1071  0004 02            	dc.b	2
1072  0005 00            	dc.b	0
1073  0006 01            	dc.b	1
1074  0007 00            	dc.b	0
1075  0008 03            	dc.b	3
1076  0009 00            	dc.b	0
1077  000a 01            	dc.b	1
1078  000b 00            	dc.b	0
1079  000c 02            	dc.b	2
1080  000d 00            	dc.b	0
1081  000e 01            	dc.b	1
1082  000f 00            	dc.b	0
1083  0010 04            	dc.b	4
1084  0011 00            	dc.b	0
1085  0012 01            	dc.b	1
1086  0013 00            	dc.b	0
1087  0014 02            	dc.b	2
1088  0015 00            	dc.b	0
1089  0016 01            	dc.b	1
1090  0017 00            	dc.b	0
1091  0018 03            	dc.b	3
1092  0019 00            	dc.b	0
1093  001a 01            	dc.b	1
1094  001b 00            	dc.b	0
1095  001c 02            	dc.b	2
1096  001d 00            	dc.b	0
1097  001e 01            	dc.b	1
1098  001f 00            	dc.b	0
1099  0020 05            	dc.b	5
1100  0021 00            	dc.b	0
1101  0022 01            	dc.b	1
1102  0023 00            	dc.b	0
1103  0024 02            	dc.b	2
1104  0025 00            	dc.b	0
1105  0026 01            	dc.b	1
1106  0027 00            	dc.b	0
1107  0028 03            	dc.b	3
1108  0029 00            	dc.b	0
1109  002a 01            	dc.b	1
1110  002b 00            	dc.b	0
1111  002c 02            	dc.b	2
1112  002d 00            	dc.b	0
1113  002e 01            	dc.b	1
1114  002f 00            	dc.b	0
1115  0030 04            	dc.b	4
1116  0031 00            	dc.b	0
1117  0032 01            	dc.b	1
1118  0033 00            	dc.b	0
1119  0034 02            	dc.b	2
1120  0035 00            	dc.b	0
1121  0036 01            	dc.b	1
1122  0037 00            	dc.b	0
1123  0038 03            	dc.b	3
1124  0039 00            	dc.b	0
1125  003a 01            	dc.b	1
1126  003b 00            	dc.b	0
1127  003c 02            	dc.b	2
1128  003d 00            	dc.b	0
1129  003e 01            	dc.b	1
1130  003f 00            	dc.b	0
1131  0040 06            	dc.b	6
1132  0041 00            	dc.b	0
1133  0042 01            	dc.b	1
1134  0043 00            	dc.b	0
1135  0044 02            	dc.b	2
1136  0045 00            	dc.b	0
1137  0046 01            	dc.b	1
1138  0047 00            	dc.b	0
1139  0048 03            	dc.b	3
1140  0049 00            	dc.b	0
1141  004a 01            	dc.b	1
1142  004b 00            	dc.b	0
1143  004c 02            	dc.b	2
1144  004d 00            	dc.b	0
1145  004e 01            	dc.b	1
1146  004f 00            	dc.b	0
1147  0050 04            	dc.b	4
1148  0051 00            	dc.b	0
1149  0052 01            	dc.b	1
1150  0053 00            	dc.b	0
1151  0054 02            	dc.b	2
1152  0055 00            	dc.b	0
1153  0056 01            	dc.b	1
1154  0057 00            	dc.b	0
1155  0058 03            	dc.b	3
1156  0059 00            	dc.b	0
1157  005a 01            	dc.b	1
1158  005b 00            	dc.b	0
1159  005c 02            	dc.b	2
1160  005d 00            	dc.b	0
1161  005e 01            	dc.b	1
1162  005f 00            	dc.b	0
1163  0060 05            	dc.b	5
1164  0061 00            	dc.b	0
1165  0062 01            	dc.b	1
1166  0063 00            	dc.b	0
1167  0064 02            	dc.b	2
1168  0065 00            	dc.b	0
1169  0066 01            	dc.b	1
1170  0067 00            	dc.b	0
1171  0068 03            	dc.b	3
1172  0069 00            	dc.b	0
1173  006a 01            	dc.b	1
1174  006b 00            	dc.b	0
1175  006c 02            	dc.b	2
1176  006d 00            	dc.b	0
1177  006e 01            	dc.b	1
1178  006f 00            	dc.b	0
1179  0070 04            	dc.b	4
1180  0071 00            	dc.b	0
1181  0072 01            	dc.b	1
1182  0073 00            	dc.b	0
1183  0074 02            	dc.b	2
1184  0075 00            	dc.b	0
1185  0076 01            	dc.b	1
1186  0077 00            	dc.b	0
1187  0078 03            	dc.b	3
1188  0079 00            	dc.b	0
1189  007a 01            	dc.b	1
1190  007b 00            	dc.b	0
1191  007c 02            	dc.b	2
1192  007d 00            	dc.b	0
1193  007e 01            	dc.b	1
1194  007f 00            	dc.b	0
1195  0080 07            	dc.b	7
1196  0081 00            	dc.b	0
1197  0082 01            	dc.b	1
1198  0083 00            	dc.b	0
1199  0084 02            	dc.b	2
1200  0085 00            	dc.b	0
1201  0086 01            	dc.b	1
1202  0087 00            	dc.b	0
1203  0088 03            	dc.b	3
1204  0089 00            	dc.b	0
1205  008a 01            	dc.b	1
1206  008b 00            	dc.b	0
1207  008c 02            	dc.b	2
1208  008d 00            	dc.b	0
1209  008e 01            	dc.b	1
1210  008f 00            	dc.b	0
1211  0090 04            	dc.b	4
1212  0091 00            	dc.b	0
1213  0092 01            	dc.b	1
1214  0093 00            	dc.b	0
1215  0094 02            	dc.b	2
1216  0095 00            	dc.b	0
1217  0096 01            	dc.b	1
1218  0097 00            	dc.b	0
1219  0098 03            	dc.b	3
1220  0099 00            	dc.b	0
1221  009a 01            	dc.b	1
1222  009b 00            	dc.b	0
1223  009c 02            	dc.b	2
1224  009d 00            	dc.b	0
1225  009e 01            	dc.b	1
1226  009f 00            	dc.b	0
1227  00a0 05            	dc.b	5
1228  00a1 00            	dc.b	0
1229  00a2 01            	dc.b	1
1230  00a3 00            	dc.b	0
1231  00a4 02            	dc.b	2
1232  00a5 00            	dc.b	0
1233  00a6 01            	dc.b	1
1234  00a7 00            	dc.b	0
1235  00a8 03            	dc.b	3
1236  00a9 00            	dc.b	0
1237  00aa 01            	dc.b	1
1238  00ab 00            	dc.b	0
1239  00ac 02            	dc.b	2
1240  00ad 00            	dc.b	0
1241  00ae 01            	dc.b	1
1242  00af 00            	dc.b	0
1243  00b0 04            	dc.b	4
1244  00b1 00            	dc.b	0
1245  00b2 01            	dc.b	1
1246  00b3 00            	dc.b	0
1247  00b4 02            	dc.b	2
1248  00b5 00            	dc.b	0
1249  00b6 01            	dc.b	1
1250  00b7 00            	dc.b	0
1251  00b8 03            	dc.b	3
1252  00b9 00            	dc.b	0
1253  00ba 01            	dc.b	1
1254  00bb 00            	dc.b	0
1255  00bc 02            	dc.b	2
1256  00bd 00            	dc.b	0
1257  00be 01            	dc.b	1
1258  00bf 00            	dc.b	0
1259  00c0 06            	dc.b	6
1260  00c1 00            	dc.b	0
1261  00c2 01            	dc.b	1
1262  00c3 00            	dc.b	0
1263  00c4 02            	dc.b	2
1264  00c5 00            	dc.b	0
1265  00c6 01            	dc.b	1
1266  00c7 00            	dc.b	0
1267  00c8 03            	dc.b	3
1268  00c9 00            	dc.b	0
1269  00ca 01            	dc.b	1
1270  00cb 00            	dc.b	0
1271  00cc 02            	dc.b	2
1272  00cd 00            	dc.b	0
1273  00ce 01            	dc.b	1
1274  00cf 00            	dc.b	0
1275  00d0 04            	dc.b	4
1276  00d1 00            	dc.b	0
1277  00d2 01            	dc.b	1
1278  00d3 00            	dc.b	0
1279  00d4 02            	dc.b	2
1280  00d5 00            	dc.b	0
1281  00d6 01            	dc.b	1
1282  00d7 00            	dc.b	0
1283  00d8 03            	dc.b	3
1284  00d9 00            	dc.b	0
1285  00da 01            	dc.b	1
1286  00db 00            	dc.b	0
1287  00dc 02            	dc.b	2
1288  00dd 00            	dc.b	0
1289  00de 01            	dc.b	1
1290  00df 00            	dc.b	0
1291  00e0 05            	dc.b	5
1292  00e1 00            	dc.b	0
1293  00e2 01            	dc.b	1
1294  00e3 00            	dc.b	0
1295  00e4 02            	dc.b	2
1296  00e5 00            	dc.b	0
1297  00e6 01            	dc.b	1
1298  00e7 00            	dc.b	0
1299  00e8 03            	dc.b	3
1300  00e9 00            	dc.b	0
1301  00ea 01            	dc.b	1
1302  00eb 00            	dc.b	0
1303  00ec 02            	dc.b	2
1304  00ed 00            	dc.b	0
1305  00ee 01            	dc.b	1
1306  00ef 00            	dc.b	0
1307  00f0 04            	dc.b	4
1308  00f1 00            	dc.b	0
1309  00f2 01            	dc.b	1
1310  00f3 00            	dc.b	0
1311  00f4 02            	dc.b	2
1312  00f5 00            	dc.b	0
1313  00f6 01            	dc.b	1
1314  00f7 00            	dc.b	0
1315  00f8 03            	dc.b	3
1316  00f9 00            	dc.b	0
1317  00fa 01            	dc.b	1
1318  00fb 00            	dc.b	0
1319  00fc 02            	dc.b	2
1320  00fd 00            	dc.b	0
1321  00fe 01            	dc.b	1
1322  00ff 00            	dc.b	0
1462                     ; 117 _NEAR INT8U  OSEventNameGet (OS_EVENT   *pevent,
1462                     ; 118                             INT8U     **pname,
1462                     ; 119                             INT8U      *perr)
1462                     ; 120 {
1463                     	switch	.text
1464  0000               _OSEventNameGet:
1466  0000 3b            	pshd	
1467       00000002      OFST:	set	2
1470                     ; 123     OS_CPU_SR  cpu_sr = 0u;
1472                     ; 136     if (pevent == (OS_EVENT *)0) {               /* Is 'pevent' a NULL pointer?                        */
1474  0001 6cae          	std	2,-s
1475  0003 2604          	bne	L167
1476                     ; 137         *perr = OS_ERR_PEVENT_NULL;
1478  0005 c604          	ldab	#4
1479                     ; 138         return (0u);
1482  0007 2006          	bra	LC001
1483  0009               L167:
1484                     ; 140     if (pname == (INT8U **)0) {                   /* Is 'pname' a NULL pointer?                         */
1486  0009 ec86          	ldd	OFST+4,s
1487  000b 260a          	bne	L367
1488                     ; 141         *perr = OS_ERR_PNAME_NULL;
1490  000d c60c          	ldab	#12
1491                     ; 142         return (0u);
1493  000f               LC001:
1494  000f 6bf30008      	stab	[OFST+6,s]
1495  0013 c7            	clrb	
1497  0014               L6:
1499  0014 1b84          	leas	4,s
1500  0016 3d            	rts	
1501  0017               L367:
1502                     ; 145     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
1504  0017 f604cd        	ldab	_OSIntNesting
1505  001a 2704          	beq	L567
1506                     ; 146         *perr  = OS_ERR_NAME_GET_ISR;
1508  001c c611          	ldab	#17
1509                     ; 147         return (0u);
1512  001e 20ef          	bra	LC001
1513  0020               L567:
1514                     ; 149     switch (pevent->OSEventType) {
1516  0020 e6f30002      	ldab	[OFST+0,s]
1518  0024 04010d        	dbeq	b,L177
1519  0027 04010a        	dbeq	b,L177
1520  002a 040107        	dbeq	b,L177
1521  002d 040104        	dbeq	b,L177
1522                     ; 156         default:
1522                     ; 157              *perr = OS_ERR_EVENT_TYPE;
1524  0030 c601          	ldab	#1
1525                     ; 158              return (0u);
1528  0032 20db          	bra	LC001
1529                     ; 150         case OS_EVENT_TYPE_SEM:
1529                     ; 151         case OS_EVENT_TYPE_MUTEX:
1529                     ; 152         case OS_EVENT_TYPE_MBOX:
1529                     ; 153         case OS_EVENT_TYPE_Q:
1529                     ; 154              break;
1531  0034               L177:
1532                     ; 160     OS_ENTER_CRITICAL();
1534  0034 160000        	jsr	_OS_CPU_SR_Save
1536  0037 6b80          	stab	OFST-2,s
1537                     ; 161     *pname = pevent->OSEventName;
1539  0039 ee82          	ldx	OFST+0,s
1540  003b ec0e          	ldd	14,x
1541  003d ee86          	ldx	OFST+4,s
1542  003f 6c00          	std	0,x
1543                     ; 162     len    = OS_StrLen(*pname);
1545  0041 160888        	jsr	_OS_StrLen
1547  0044 6b81          	stab	OFST-1,s
1548                     ; 163     OS_EXIT_CRITICAL();
1550  0046 e680          	ldab	OFST-2,s
1551  0048 87            	clra	
1552  0049 160000        	jsr	_OS_CPU_SR_Restore
1554                     ; 164     *perr  = OS_ERR_NONE;
1556  004c 69f30008      	clr	[OFST+6,s]
1557                     ; 165     return (len);
1559  0050 e681          	ldab	OFST-1,s
1561  0052 20c0          	bra	L6
1627                     ; 197 _NEAR void  OSEventNameSet (OS_EVENT  *pevent,
1627                     ; 198                            INT8U     *pname,
1627                     ; 199                            INT8U     *perr)
1627                     ; 200 {
1628                     	switch	.text
1629  0054               _OSEventNameSet:
1631  0054 3b            	pshd	
1632  0055 37            	pshb	
1633       00000001      OFST:	set	1
1636                     ; 202     OS_CPU_SR  cpu_sr = 0u;
1638                     ; 215     if (pevent == (OS_EVENT *)0) {               /* Is 'pevent' a NULL pointer?                        */
1640  0056 046404        	tbne	d,L1301
1641                     ; 216         *perr = OS_ERR_PEVENT_NULL;
1643  0059 c604          	ldab	#4
1644                     ; 217         return;
1646  005b 2006          	bra	LC002
1647  005d               L1301:
1648                     ; 219     if (pname == (INT8U *)0) {                   /* Is 'pname' a NULL pointer?                         */
1650  005d ec85          	ldd	OFST+4,s
1651  005f 2609          	bne	L3301
1652                     ; 220         *perr = OS_ERR_PNAME_NULL;
1654  0061 c60c          	ldab	#12
1655  0063               LC002:
1656  0063 6bf30007      	stab	[OFST+6,s]
1657                     ; 221         return;
1658  0067               L21:
1661  0067 1b83          	leas	3,s
1662  0069 3d            	rts	
1663  006a               L3301:
1664                     ; 224     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
1666  006a f604cd        	ldab	_OSIntNesting
1667  006d 2704          	beq	L5301
1668                     ; 225         *perr = OS_ERR_NAME_SET_ISR;
1670  006f c612          	ldab	#18
1671                     ; 226         return;
1673  0071 20f0          	bra	LC002
1674  0073               L5301:
1675                     ; 228     switch (pevent->OSEventType) {
1677  0073 e6f30001      	ldab	[OFST+0,s]
1679  0077 04010d        	dbeq	b,L1401
1680  007a 04010a        	dbeq	b,L1401
1681  007d 040107        	dbeq	b,L1401
1682  0080 040104        	dbeq	b,L1401
1683                     ; 235         default:
1683                     ; 236              *perr = OS_ERR_EVENT_TYPE;
1685  0083 c601          	ldab	#1
1686                     ; 237              return;
1688  0085 20dc          	bra	LC002
1689                     ; 229         case OS_EVENT_TYPE_SEM:
1689                     ; 230         case OS_EVENT_TYPE_MUTEX:
1689                     ; 231         case OS_EVENT_TYPE_MBOX:
1689                     ; 232         case OS_EVENT_TYPE_Q:
1689                     ; 233              break;
1691  0087               L1401:
1692                     ; 239     OS_ENTER_CRITICAL();
1694  0087 160000        	jsr	_OS_CPU_SR_Save
1696  008a 6b80          	stab	OFST-1,s
1697                     ; 240     pevent->OSEventName = pname;
1699  008c ed81          	ldy	OFST+0,s
1700  008e 1802854e      	movw	OFST+4,s,14,y
1701                     ; 241     OS_EXIT_CRITICAL();
1703  0092 87            	clra	
1704  0093 160000        	jsr	_OS_CPU_SR_Restore
1706                     ; 243     *perr = OS_ERR_NONE;
1709  0096 69f30007      	clr	[OFST+6,s]
1710                     ; 244 }
1712  009a 20cb          	bra	L21
1940                     ; 320 _NEAR INT16U  OSEventPendMulti (OS_EVENT  **pevents_pend,
1940                     ; 321                                OS_EVENT  **pevents_rdy,
1940                     ; 322                                void      **pmsgs_rdy,
1940                     ; 323                                INT32U      timeout,
1940                     ; 324                                INT8U      *perr)
1940                     ; 325 {
1941                     	switch	.text
1942  009c               _OSEventPendMulti:
1944  009c 3b            	pshd	
1945  009d 1b95          	leas	-11,s
1946       0000000b      OFST:	set	11
1949                     ; 335     OS_CPU_SR   cpu_sr = 0u;
1951                     ; 348     if (pevents_pend == (OS_EVENT **)0) {               /* Validate 'pevents_pend'                     */
1953  009f 046402        	tbne	d,L3321
1954                     ; 349        *perr =  OS_ERR_PEVENT_NULL;
1956                     ; 350         return (0u);
1959  00a2 2006          	bra	LC003
1960  00a4               L3321:
1961                     ; 352     if (*pevents_pend  == (OS_EVENT *)0) {              /* Validate 'pevents_pend'                     */
1963  00a4 ecf3000b      	ldd	[OFST+0,s]
1964  00a8 260b          	bne	L5321
1965                     ; 353        *perr =  OS_ERR_PEVENT_NULL;
1967  00aa               LC003:
1968  00aa c604          	ldab	#4
1969                     ; 354         return (0u);
1972  00ac               L61:
1973  00ac 6bf30017      	stab	[OFST+12,s]
1974  00b0 87            	clra	
1975  00b1 c7            	clrb	
1977  00b2 1b8d          	leas	13,s
1978  00b4 3d            	rts	
1979  00b5               L5321:
1980                     ; 356     if (pevents_rdy  == (OS_EVENT **)0) {               /* Validate 'pevents_rdy'                      */
1982  00b5 ec8f          	ldd	OFST+4,s
1983                     ; 357        *perr =  OS_ERR_PEVENT_NULL;
1985                     ; 358         return (0u);
1988  00b7 27f1          	beq	LC003
1989                     ; 360     if (pmsgs_rdy == (void **)0) {                      /* Validate 'pmsgs_rdy'                        */
1991  00b9 ecf011        	ldd	OFST+6,s
1992                     ; 361        *perr =  OS_ERR_PEVENT_NULL;
1994                     ; 362         return (0u);
1997  00bc 27ec          	beq	LC003
1998                     ; 366    *pevents_rdy = (OS_EVENT *)0;                        /* Init array to NULL in case of errors        */
2000  00be 87            	clra	
2001  00bf c7            	clrb	
2002  00c0 6cf3000f      	std	[OFST+4,s]
2003                     ; 368     pevents     =  pevents_pend;
2005  00c4 18028b86      	movw	OFST+0,s,OFST-5,s
2006                     ; 369     pevent      = *pevents;
2008  00c8 ecf30006      	ldd	[OFST-5,s]
2010  00cc 201b          	bra	L5421
2011  00ce               L3421:
2012                     ; 371         switch (pevent->OSEventType) {                  /* Validate event block types                  */
2014  00ce e6f30000      	ldab	[OFST-11,s]
2016  00d2 04010e        	dbeq	b,L3521
2017  00d5 04010b        	dbeq	b,L3521
2018  00d8 040108        	dbeq	b,L3521
2019  00db 040101        	dbeq	b,L1501
2020  00de 53            	decb	
2021  00df               L1501:
2022                     ; 385             case OS_EVENT_TYPE_MUTEX:
2022                     ; 386             case OS_EVENT_TYPE_FLAG:
2022                     ; 387             default:
2022                     ; 388                 *perr = OS_ERR_EVENT_TYPE;
2024  00df c601          	ldab	#1
2025                     ; 389                  return (0u);
2028  00e1 20c9          	bra	L61
2029  00e3               L3521:
2030                     ; 391         pevents++;
2032  00e3 ed86          	ldy	OFST-5,s
2033                     ; 392         pevent = *pevents;
2035  00e5 ec61          	ldd	2,+y
2036  00e7 6d86          	sty	OFST-5,s
2037  00e9               L5421:
2038  00e9 6c80          	std	OFST-11,s
2039                     ; 370     while  (pevent != (OS_EVENT *)0) {
2041  00eb 26e1          	bne	L3421
2042                     ; 395     if (OSIntNesting  > 0u) {                           /* See if called from ISR ...                  */
2044  00ed f604cd        	ldab	_OSIntNesting
2045  00f0 2704          	beq	L5521
2046                     ; 396        *perr =  OS_ERR_PEND_ISR;                        /* ... can't PEND from an ISR                  */
2048  00f2 c602          	ldab	#2
2049                     ; 397         return (0u);
2052  00f4 2007          	bra	L02
2053  00f6               L5521:
2054                     ; 399     if (OSLockNesting > 0u) {                           /* See if called with scheduler locked ...     */
2056  00f6 f604cc        	ldab	_OSLockNesting
2057  00f9 270b          	beq	L7521
2058                     ; 400        *perr =  OS_ERR_PEND_LOCKED;                     /* ... can't PEND when locked                  */
2060  00fb c60d          	ldab	#13
2061                     ; 401         return (0u);
2064  00fd               L02:
2065  00fd 6bf30017      	stab	[OFST+12,s]
2066  0101 87            	clra	
2067  0102 c7            	clrb	
2069  0103 1b8d          	leas	13,s
2070  0105 3d            	rts	
2071  0106               L7521:
2072                     ; 404     events_rdy     =  OS_FALSE;
2074  0106 87            	clra	
2075  0107 6a88          	staa	OFST-3,s
2076                     ; 405     events_rdy_nbr =  0u;
2078  0109 6c84          	std	OFST-7,s
2079                     ; 406     events_stat    =  OS_STAT_RDY;
2081  010b 6989          	clr	OFST-2,s
2082                     ; 407     pevents        =  pevents_pend;
2084  010d ed8b          	ldy	OFST+0,s
2085  010f 6d86          	sty	OFST-5,s
2086                     ; 408     pevent         = *pevents;
2088  0111 18024080      	movw	0,y,OFST-11,s
2089                     ; 409     OS_ENTER_CRITICAL();
2091  0115 160000        	jsr	_OS_CPU_SR_Save
2093  0118 6b8a          	stab	OFST-1,s
2095  011a ec80          	ldd	OFST-11,s
2096  011c 0601e7        	bra	L3621
2097  011f               L1621:
2098                     ; 411         switch (pevent->OSEventType) {
2100  011f b746          	tfr	d,y
2101  0121 e640          	ldab	0,y
2103  0123 04013d        	dbeq	b,L5501
2104  0126 040164        	dbeq	b,L7501
2105  0129 04010d        	dbeq	b,L3501
2106  012c 53            	decb	
2107  012d 1827009b      	beq	L1601
2108  0131 53            	decb	
2109  0132 18270096      	beq	L1601
2110  0136 0601cc        	bra	L1601
2111  0139               L3501:
2112                     ; 413             case OS_EVENT_TYPE_SEM:
2112                     ; 414                  if (pevent->OSEventCnt > 0u) {         /* If semaphore count > 0, resource available; */
2114  0139 ee43          	ldx	3,y
2115  013b 2721          	beq	L3721
2116                     ; 415                      pevent->OSEventCnt--;              /* ... decrement semaphore,                ... */
2118  013d 09            	dex	
2119  013e 6e43          	stx	3,y
2120                     ; 416                     *pevents_rdy++ =  pevent;           /* ... and return available semaphore event    */
2122  0140 ed8f          	ldy	OFST+4,s
2123  0142 18028071      	movw	OFST-11,s,2,y+
2124  0146 6d8f          	sty	OFST+4,s
2125                     ; 417                       events_rdy   =  OS_TRUE;
2127  0148 c601          	ldab	#1
2128  014a 6b88          	stab	OFST-3,s
2129                     ; 418                     *pmsgs_rdy++   = (void *)0;         /* NO message returned  for semaphores         */
2131  014c 87            	clra	
2132  014d c7            	clrb	
2133  014e edf011        	ldy	OFST+6,s
2134  0151 6c71          	std	2,y+
2135  0153 6df011        	sty	OFST+6,s
2136                     ; 419                       events_rdy_nbr++;
2138  0156 ed84          	ldy	OFST-7,s
2139  0158 02            	iny	
2140  0159 6d84          	sty	OFST-7,s
2142  015b 0601df        	bra	L1721
2143  015e               L3721:
2144                     ; 422                       events_stat |=  OS_STAT_SEM;      /* Configure multi-pend for semaphore events   */
2146  015e 0c8901        	bset	OFST-2,s,1
2147  0161 207c          	bra	L1721
2148  0163               L5501:
2149                     ; 428             case OS_EVENT_TYPE_MBOX:
2149                     ; 429                  if (pevent->OSEventPtr != (void *)0) { /* If mailbox NOT empty;                   ... */
2151  0163 ec41          	ldd	1,y
2152  0165 2721          	beq	L7721
2153                     ; 431                     *pmsgs_rdy++         = (void *)pevent->OSEventPtr;
2155  0167 edf011        	ldy	OFST+6,s
2156  016a 6c71          	std	2,y+
2157  016c 6df011        	sty	OFST+6,s
2158                     ; 432                      pevent->OSEventPtr  = (void *)0;
2160  016f 87            	clra	
2161  0170 c7            	clrb	
2162  0171 ed80          	ldy	OFST-11,s
2163  0173 6c41          	std	1,y
2164                     ; 433                     *pevents_rdy++       =  pevent;     /* ... and return available mailbox event      */
2166  0175 b764          	tfr	y,d
2167  0177 ed8f          	ldy	OFST+4,s
2168  0179 6c71          	std	2,y+
2169  017b 6d8f          	sty	OFST+4,s
2170                     ; 434                       events_rdy         =  OS_TRUE;
2172  017d c601          	ldab	#1
2173  017f 6b88          	stab	OFST-3,s
2174                     ; 435                       events_rdy_nbr++;
2176  0181 ed84          	ldy	OFST-7,s
2177  0183 02            	iny	
2178  0184 6d84          	sty	OFST-7,s
2180  0186 2057          	bra	L1721
2181  0188               L7721:
2182                     ; 438                       events_stat |= OS_STAT_MBOX;      /* Configure multi-pend for mailbox events     */
2184  0188 0c8902        	bset	OFST-2,s,2
2185  018b 2052          	bra	L1721
2186  018d               L7501:
2187                     ; 444             case OS_EVENT_TYPE_Q:
2187                     ; 445                  pq = (OS_Q *)pevent->OSEventPtr;
2189  018d ed41          	ldy	1,y
2190  018f 6d82          	sty	OFST-9,s
2191                     ; 446                  if (pq->OSQEntries > 0u) {             /* If queue NOT empty;                     ... */
2193  0191 ec4c          	ldd	12,y
2194  0193 2732          	beq	L3031
2195                     ; 448                     *pmsgs_rdy++ = (void *)*pq->OSQOut++;
2197  0195 ee48          	ldx	8,y
2198  0197 ec31          	ldd	2,x+
2199  0199 6e48          	stx	8,y
2200  019b edf011        	ldy	OFST+6,s
2201  019e 6c71          	std	2,y+
2202  01a0 6df011        	sty	OFST+6,s
2203                     ; 449                      if (pq->OSQOut == pq->OSQEnd) {    /* If OUT ptr at queue end, ...                */
2205  01a3 ed82          	ldy	OFST-9,s
2206  01a5 ec48          	ldd	8,y
2207  01a7 ac44          	cpd	4,y
2208  01a9 2604          	bne	L5031
2209                     ; 450                          pq->OSQOut  = pq->OSQStart;    /* ... wrap   to queue start                   */
2211  01ab 18024248      	movw	2,y,8,y
2212  01af               L5031:
2213                     ; 452                      pq->OSQEntries--;                  /* Update number of queue entries              */
2215  01af ee4c          	ldx	12,y
2216  01b1 09            	dex	
2217  01b2 6e4c          	stx	12,y
2218                     ; 453                     *pevents_rdy++ = pevent;            /* ... and return available queue event        */
2220  01b4 ed8f          	ldy	OFST+4,s
2221  01b6 18028071      	movw	OFST-11,s,2,y+
2222  01ba 6d8f          	sty	OFST+4,s
2223                     ; 454                       events_rdy   = OS_TRUE;
2225  01bc c601          	ldab	#1
2226  01be 6b88          	stab	OFST-3,s
2227                     ; 455                       events_rdy_nbr++;
2229  01c0 ed84          	ldy	OFST-7,s
2230  01c2 02            	iny	
2231  01c3 6d84          	sty	OFST-7,s
2233  01c5 2018          	bra	L1721
2234  01c7               L3031:
2235                     ; 458                       events_stat |= OS_STAT_Q;         /* Configure multi-pend for queue events       */
2237  01c7 0c8904        	bset	OFST-2,s,4
2238  01ca 2013          	bra	L1721
2239  01cc               L1601:
2240                     ; 463             case OS_EVENT_TYPE_MUTEX:
2240                     ; 464             case OS_EVENT_TYPE_FLAG:
2240                     ; 465             default:
2240                     ; 466                  OS_EXIT_CRITICAL();
2242  01cc e68a          	ldab	OFST-1,s
2243  01ce 87            	clra	
2244  01cf 160000        	jsr	_OS_CPU_SR_Restore
2246                     ; 467                 *pevents_rdy = (OS_EVENT *)0;           /* NULL terminate return event array           */
2248  01d2 87            	clra	
2249  01d3 c7            	clrb	
2250  01d4 6cf3000f      	std	[OFST+4,s]
2251                     ; 468                 *perr        =  OS_ERR_EVENT_TYPE;
2253  01d8 52            	incb	
2254  01d9 6bf30017      	stab	[OFST+12,s]
2255                     ; 469                  return (events_rdy_nbr);
2258  01dd 201f          	bra	L22
2259  01df               L1721:
2260                     ; 471         pevents++;
2262  01df ed86          	ldy	OFST-5,s
2263                     ; 472         pevent = *pevents;
2265  01e1 ec61          	ldd	2,+y
2266  01e3 6d86          	sty	OFST-5,s
2267  01e5 6c80          	std	OFST-11,s
2268  01e7               L3621:
2269                     ; 410     while (pevent != (OS_EVENT *)0) {                   /* See if any events already available         */
2271  01e7 1826ff34      	bne	L1621
2272                     ; 475     if ( events_rdy == OS_TRUE) {                       /* Return any events already available         */
2274  01eb e688          	ldab	OFST-3,s
2275  01ed 042113        	dbne	b,L1131
2276                     ; 476        *pevents_rdy = (OS_EVENT *)0;                    /* NULL terminate return event array           */
2278  01f0 87            	clra	
2279  01f1 6cf3000f      	std	[OFST+4,s]
2280                     ; 477         OS_EXIT_CRITICAL();
2282  01f5 e68a          	ldab	OFST-1,s
2283  01f7 160000        	jsr	_OS_CPU_SR_Restore
2285                     ; 478        *perr        =  OS_ERR_NONE;
2287  01fa 69f30017      	clr	[OFST+12,s]
2288                     ; 479         return (events_rdy_nbr);
2291  01fe               L22:
2292  01fe ec84          	ldd	OFST-7,s
2294  0200 1b8d          	leas	13,s
2295  0202 3d            	rts	
2296  0203               L1131:
2297                     ; 483     OSTCBCur->OSTCBStat     |= events_stat  |           /* Resource not available, ...                 */
2297                     ; 484                                OS_STAT_MULTI;           /* ... pend on multiple events                 */
2299  0203 fd0419        	ldy	_OSTCBCur
2300  0206 e689          	ldab	OFST-2,s
2301  0208 ca80          	orab	#128
2302  020a eae822        	orab	34,y
2303  020d 6be822        	stab	34,y
2304                     ; 485     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
2306  0210 69e823        	clr	35,y
2307                     ; 486     OSTCBCur->OSTCBDly       = timeout;                 /* Store pend timeout in TCB                   */
2309  0213 ecf015        	ldd	OFST+10,s
2310  0216 6ce820        	std	32,y
2311  0219 ecf013        	ldd	OFST+8,s
2312  021c 6ce81e        	std	30,y
2313                     ; 487     OS_EventTaskWaitMulti(pevents_pend);                /* Suspend task until events or timeout occurs */
2315  021f ec8b          	ldd	OFST+0,s
2316  0221 1605ad        	jsr	_OS_EventTaskWaitMulti
2318                     ; 489     OS_EXIT_CRITICAL();
2320  0224 e68a          	ldab	OFST-1,s
2321  0226 87            	clra	
2322  0227 160000        	jsr	_OS_CPU_SR_Restore
2324                     ; 490     OS_Sched();                                         /* Find next highest priority task ready       */
2326  022a 16080c        	jsr	_OS_Sched
2328                     ; 491     OS_ENTER_CRITICAL();
2330  022d 160000        	jsr	_OS_CPU_SR_Save
2332  0230 6b8a          	stab	OFST-1,s
2333                     ; 493     switch (OSTCBCur->OSTCBStatPend) {                  /* Handle event posted, aborted, or timed-out  */
2335  0232 fd0419        	ldy	_OSTCBCur
2336  0235 e6e823        	ldab	35,y
2338  0238 2706          	beq	L3601
2339  023a 04011e        	dbeq	b,L5601
2340  023d 04211b        	dbne	b,L5601
2341  0240               L3601:
2342                     ; 494         case OS_STAT_PEND_OK:
2342                     ; 495         case OS_STAT_PEND_ABORT:
2342                     ; 496              pevent = OSTCBCur->OSTCBEventMultiRdy;
2344  0240 ece816        	ldd	22,y
2345  0243 6c80          	std	OFST-11,s
2346                     ; 497              if (pevent != (OS_EVENT *)0) {             /* If task event ptr != NULL, ...              */
2348  0245 270f          	beq	L7131
2349                     ; 498                 *pevents_rdy++   =  pevent;             /* ... return available event ...              */
2351  0247 ed8f          	ldy	OFST+4,s
2352  0249 6c71          	std	2,y+
2353  024b 6d8f          	sty	OFST+4,s
2354                     ; 499                 *pevents_rdy     = (OS_EVENT *)0;       /* ... & NULL terminate return event array     */
2356  024d 87            	clra	
2357  024e c7            	clrb	
2358  024f 6c40          	std	0,y
2359                     ; 500                   events_rdy_nbr =  1;
2361  0251 52            	incb	
2362  0252 6c84          	std	OFST-7,s
2364  0254 200f          	bra	L5131
2365  0256               L7131:
2366                     ; 503                  OSTCBCur->OSTCBStatPend = OS_STAT_PEND_TO;
2368  0256 c601          	ldab	#1
2369  0258 6be823        	stab	35,y
2370                     ; 504                  OS_EventTaskRemoveMulti(OSTCBCur, pevents_pend);
2373  025b               L5601:
2374                     ; 508         case OS_STAT_PEND_TO:                           /* If events timed out, ...                    */
2374                     ; 509         default:                                        /* ... remove task from events' wait lists     */
2374                     ; 510              OS_EventTaskRemoveMulti(OSTCBCur, pevents_pend);
2377  025b ec8b          	ldd	OFST+0,s
2378  025d 3b            	pshd	
2379  025e b764          	tfr	y,d
2380  0260 16063d        	jsr	_OS_EventTaskRemoveMulti
2381  0263 1b82          	leas	2,s
2382                     ; 511              break;
2384  0265               L5131:
2385                     ; 514     switch (OSTCBCur->OSTCBStatPend) {
2387  0265 fd0419        	ldy	_OSTCBCur
2388  0268 e6e823        	ldab	35,y
2390  026b 2708          	beq	L7601
2391  026d 040150        	dbeq	b,L1011
2392  0270 040140        	dbeq	b,L7701
2393  0273 204b          	bra	L1011
2394  0275               L7601:
2395                     ; 515         case OS_STAT_PEND_OK:
2395                     ; 516              switch (pevent->OSEventType) {             /* Return event's message                      */
2397  0275 e6f30000      	ldab	[OFST-11,s]
2399  0279 040111        	dbeq	b,L3701
2400  027c 04010e        	dbeq	b,L3701
2401  027f 040108        	dbeq	b,L1701
2402  0282 04010d        	dbeq	b,L5701
2403  0285 04010a        	dbeq	b,L5701
2404  0288 2008          	bra	L5701
2405  028a               L1701:
2406                     ; 518                  case OS_EVENT_TYPE_SEM:
2406                     ; 519                      *pmsgs_rdy++ = (void *)0;          /* NO message returned for semaphores          */
2408  028a 87            	clra	
2409                     ; 520                       break;
2411  028b 2018          	bra	L1331
2412  028d               L3701:
2413                     ; 525                  case OS_EVENT_TYPE_MBOX:
2413                     ; 526                  case OS_EVENT_TYPE_Q:
2413                     ; 527                      *pmsgs_rdy++ = (void *)OSTCBCur->OSTCBMsg;     /* Return received message         */
2415  028d ece818        	ldd	24,y
2416                     ; 528                       break;
2418  0290 2013          	bra	L1331
2419  0292               L5701:
2420                     ; 531                  case OS_EVENT_TYPE_MUTEX:
2420                     ; 532                  case OS_EVENT_TYPE_FLAG:
2420                     ; 533                  default:
2420                     ; 534                       OS_EXIT_CRITICAL();
2422  0292 e68a          	ldab	OFST-1,s
2423  0294 87            	clra	
2424  0295 160000        	jsr	_OS_CPU_SR_Restore
2426                     ; 535                      *pevents_rdy = (OS_EVENT *)0;      /* NULL terminate return event array           */
2428  0298 87            	clra	
2429  0299 c7            	clrb	
2430  029a 6cf3000f      	std	[OFST+4,s]
2431                     ; 536                      *perr        =  OS_ERR_EVENT_TYPE;
2433  029e 52            	incb	
2434  029f 6bf30017      	stab	[OFST+12,s]
2435                     ; 537                       return (events_rdy_nbr);
2438  02a3 2044          	bra	L42
2439  02a5               L1331:
2440  02a5 edf011        	ldy	OFST+6,s
2441  02a8 6c71          	std	2,y+
2442  02aa 6df011        	sty	OFST+6,s
2443                     ; 539             *perr = OS_ERR_NONE;
2445  02ad 69f30017      	clr	[OFST+12,s]
2446                     ; 540              break;
2448  02b1 201d          	bra	L5231
2449  02b3               L7701:
2450                     ; 542         case OS_STAT_PEND_ABORT:
2450                     ; 543             *pmsgs_rdy++ = (void *)0;                   /* NO message returned for abort               */
2452  02b3 87            	clra	
2453  02b4 edf011        	ldy	OFST+6,s
2454  02b7 6c71          	std	2,y+
2455  02b9 6df011        	sty	OFST+6,s
2456                     ; 544             *perr        =  OS_ERR_PEND_ABORT;          /* Indicate that event  aborted                */
2458  02bc c60e          	ldab	#14
2459                     ; 545              break;
2461  02be 200c          	bra	LC005
2462  02c0               L1011:
2463                     ; 547         case OS_STAT_PEND_TO:
2463                     ; 548         default:
2463                     ; 549             *pmsgs_rdy++ = (void *)0;                   /* NO message returned for timeout             */
2465  02c0 87            	clra	
2466  02c1 c7            	clrb	
2467  02c2 edf011        	ldy	OFST+6,s
2468  02c5 6c71          	std	2,y+
2469  02c7 6df011        	sty	OFST+6,s
2470                     ; 550             *perr        =  OS_ERR_TIMEOUT;             /* Indicate that events timed out              */
2472  02ca c60a          	ldab	#10
2473  02cc               LC005:
2474  02cc 6bf30017      	stab	[OFST+12,s]
2475                     ; 551              break;
2477  02d0               L5231:
2478                     ; 554     OSTCBCur->OSTCBStat          =  OS_STAT_RDY;        /* Set   task  status to ready                 */
2480  02d0 fd0419        	ldy	_OSTCBCur
2481  02d3 c7            	clrb	
2482  02d4 6be822        	stab	34,y
2483                     ; 555     OSTCBCur->OSTCBStatPend      =  OS_STAT_PEND_OK;    /* Clear pend  status                          */
2485  02d7 87            	clra	
2486  02d8 6ae823        	staa	35,y
2487                     ; 556     OSTCBCur->OSTCBEventMultiPtr = (OS_EVENT **)0;      /* Clear event pointers                        */
2489  02db 6ce814        	std	20,y
2490                     ; 557     OSTCBCur->OSTCBEventMultiRdy = (OS_EVENT  *)0;
2492  02de 6ce816        	std	22,y
2493                     ; 560     OSTCBCur->OSTCBMsg           = (void      *)0;      /* Clear task  message                         */
2495  02e1 6ce818        	std	24,y
2496                     ; 562     OS_EXIT_CRITICAL();
2498  02e4 e68a          	ldab	OFST-1,s
2499  02e6 160000        	jsr	_OS_CPU_SR_Restore
2501                     ; 564     return (events_rdy_nbr);
2504  02e9               L42:
2505  02e9 ec84          	ldd	OFST-7,s
2507  02eb 1b8d          	leas	13,s
2508  02ed 3d            	rts	
2542                     ; 582 _NEAR void  OSInit (void)
2542                     ; 583 {
2543                     	switch	.text
2544  02ee               _OSInit:
2548                     ; 590     OSInitHookBegin();                                           /* Call port specific initialization code   */
2550  02ee 160000        	jsr	_OSInitHookBegin
2552                     ; 592     OS_InitMisc();                                               /* Initialize miscellaneous variables       */
2554  02f1 1606fc        	jsr	L356_OS_InitMisc
2556                     ; 594     OS_InitRdyList();                                            /* Initialize the Ready List                */
2558  02f4 16071d        	jsr	L556_OS_InitRdyList
2560                     ; 596     OS_InitTCBList();                                            /* Initialize the free list of OS_TCBs      */
2562  02f7 16077b        	jsr	L166_OS_InitTCBList
2564                     ; 598     OS_InitEventList();                                          /* Initialize the free list of OS_EVENTs    */
2566  02fa 16069d        	jsr	L156_OS_InitEventList
2568                     ; 601     OS_FlagInit();                                               /* Initialize the event flag structures     */
2570  02fd 160000        	jsr	_OS_FlagInit
2572                     ; 605     OS_MemInit();                                                /* Initialize the memory manager            */
2574  0300 160000        	jsr	_OS_MemInit
2576                     ; 609     OS_QInit();                                                  /* Initialize the message queue structures  */
2578  0303 160000        	jsr	_OS_QInit
2580                     ; 621     OS_InitTaskIdle();                                           /* Create the Idle Task                     */
2582  0306 160743        	jsr	L756_OS_InitTaskIdle
2584                     ; 627     OSTmr_Init();                                                /* Initialize the Timer Manager             */
2586  0309 160000        	jsr	_OSTmr_Init
2588                     ; 630     OSInitHookEnd();                                             /* Call port specific init. code            */
2590  030c 160000        	jsr	_OSInitHookEnd
2592                     ; 633     OSDebugInit();
2594  030f 160000        	jsr	_OSDebugInit
2596                     ; 635 }
2599  0312 3d            	rts	
2623                     ; 663 _NEAR void  OSIntEnter (void)
2623                     ; 664 {
2624                     	switch	.text
2625  0313               _OSIntEnter:
2629                     ; 665     if (OSRunning == OS_TRUE) {
2631  0313 f604c0        	ldab	_OSRunning
2632  0316 04210a        	dbne	b,L3531
2633                     ; 666         if (OSIntNesting < 255u) {
2635  0319 f604cd        	ldab	_OSIntNesting
2636  031c c1ff          	cmpb	#255
2637  031e 2403          	bhs	L3531
2638                     ; 667             OSIntNesting++;                      /* Increment ISR nesting level                        */
2640  0320 7204cd        	inc	_OSIntNesting
2641  0323               L3531:
2642                     ; 671 }
2645  0323 3d            	rts	
2647                     	xref	_OSIntCtxSw
2689                     ; 693 _NEAR void  OSIntExit (void)
2689                     ; 694 {
2690                     	switch	.text
2691  0324               _OSIntExit:
2693  0324 37            	pshb	
2694       00000001      OFST:	set	1
2697                     ; 696     OS_CPU_SR  cpu_sr = 0u;
2699                     ; 701     if (OSRunning == OS_TRUE) {
2701  0325 f604c0        	ldab	_OSRunning
2702  0328 04215f        	dbne	b,L3731
2703                     ; 702         OS_ENTER_CRITICAL();
2705  032b 160000        	jsr	_OS_CPU_SR_Save
2707  032e 6b80          	stab	OFST-1,s
2708                     ; 703         if (OSIntNesting > 0u) {                           /* Prevent OSIntNesting from wrapping       */
2710  0330 f704cd        	tst	_OSIntNesting
2711  0333 2703          	beq	L5731
2712                     ; 704             OSIntNesting--;
2714  0335 7304cd        	dec	_OSIntNesting
2715  0338               L5731:
2716                     ; 706         if (OSIntNesting == 0u) {                          /* Reschedule only if all ISRs complete ... */
2718  0338 f604cd        	ldab	_OSIntNesting
2719  033b 2647          	bne	L1141
2720                     ; 707             if (OSLockNesting == 0u) {                     /* ... and not locked.                      */
2722  033d f604cc        	ldab	_OSLockNesting
2723  0340 2642          	bne	L1141
2724                     ; 708                 OS_SchedNew();
2726  0342 160864        	jsr	L366_OS_SchedNew
2728                     ; 709                 OSTCBHighRdy = OSTCBPrioTbl[OSPrioHighRdy];
2730  0345 f604ca        	ldab	_OSPrioHighRdy
2731  0348 87            	clra	
2732  0349 59            	lsld	
2733  034a b746          	tfr	d,y
2734  034c edea0393      	ldy	_OSTCBPrioTbl,y
2735  0350 7d0415        	sty	_OSTCBHighRdy
2736                     ; 710                 if (OSPrioHighRdy != OSPrioCur) {          /* No Ctx Sw if current task is highest rdy */
2738  0353 f604ca        	ldab	_OSPrioHighRdy
2739  0356 f104cb        	cmpb	_OSPrioCur
2740  0359 2729          	beq	L1141
2741                     ; 712                     OSTCBHighRdy->OSTCBCtxSwCtr++;         /* Inc. # of context switches to this task  */
2743  035b ece82c        	ldd	44,y
2744  035e c30001        	addd	#1
2745  0361 6ce82c        	std	44,y
2746  0364 2408          	bcc	L43
2747  0366 62e82b        	inc	43,y
2748  0369 2603          	bne	L43
2749  036b 62e82a        	inc	42,y
2750  036e               L43:
2751                     ; 714                     OSCtxSwCtr++;                          /* Keep track of the number of ctx switches */
2753  036e fc0597        	ldd	_OSCtxSwCtr+2
2754  0371 c30001        	addd	#1
2755  0374 7c0597        	std	_OSCtxSwCtr+2
2756  0377 2408          	bcc	L63
2757  0379 720596        	inc	_OSCtxSwCtr+1
2758  037c 2603          	bne	L63
2759  037e 720595        	inc	_OSCtxSwCtr
2760  0381               L63:
2761                     ; 723                     OSIntCtxSw();                          /* Perform interrupt level ctx switch       */
2764  0381 160000        	jsr	_OSIntCtxSw
2767  0384               L1141:
2768                     ; 734         OS_EXIT_CRITICAL();
2770  0384 e680          	ldab	OFST-1,s
2771  0386 87            	clra	
2772  0387 160000        	jsr	_OS_CPU_SR_Restore
2774  038a               L3731:
2775                     ; 736 }
2778  038a 1b81          	leas	1,s
2779  038c 3d            	rts	
2815                     ; 782 _NEAR void  OSSchedLock (void)
2815                     ; 783 {
2816                     	switch	.text
2817  038d               _OSSchedLock:
2819  038d 37            	pshb	
2820       00000001      OFST:	set	1
2823                     ; 785     OS_CPU_SR  cpu_sr = 0u;
2825                     ; 790     if (OSRunning == OS_TRUE) {                  /* Make sure multitasking is running                  */
2827  038e f604c0        	ldab	_OSRunning
2828  0391 04211a        	dbne	b,L7241
2829                     ; 791         OS_ENTER_CRITICAL();
2831  0394 160000        	jsr	_OS_CPU_SR_Save
2833  0397 6b80          	stab	OFST-1,s
2834                     ; 792         if (OSIntNesting == 0u) {                /* Can't call from an ISR                             */
2836  0399 f604cd        	ldab	_OSIntNesting
2837  039c 260a          	bne	L1341
2838                     ; 793             if (OSLockNesting < 255u) {          /* Prevent OSLockNesting from wrapping back to 0      */
2840  039e f604cc        	ldab	_OSLockNesting
2841  03a1 c1ff          	cmpb	#255
2842  03a3 2403          	bhs	L1341
2843                     ; 794                 OSLockNesting++;                 /* Increment lock nesting level                       */
2845  03a5 7204cc        	inc	_OSLockNesting
2846  03a8               L1341:
2847                     ; 797         OS_EXIT_CRITICAL();
2849  03a8 e680          	ldab	OFST-1,s
2850  03aa 87            	clra	
2851  03ab 160000        	jsr	_OS_CPU_SR_Restore
2853  03ae               L7241:
2854                     ; 799 }
2857  03ae 1b81          	leas	1,s
2858  03b0 3d            	rts	
2895                     ; 819 _NEAR void  OSSchedUnlock (void)
2895                     ; 820 {
2896                     	switch	.text
2897  03b1               _OSSchedUnlock:
2899  03b1 37            	pshb	
2900       00000001      OFST:	set	1
2903                     ; 822     OS_CPU_SR  cpu_sr = 0u;
2905                     ; 827     if (OSRunning == OS_TRUE) {                            /* Make sure multitasking is running        */
2907  03b2 f604c0        	ldab	_OSRunning
2908  03b5 042121        	dbne	b,L1541
2909                     ; 828         OS_ENTER_CRITICAL();
2911  03b8 160000        	jsr	_OS_CPU_SR_Save
2913  03bb 6b80          	stab	OFST-1,s
2914                     ; 829         if (OSIntNesting == 0u) {                          /* Can't call from an ISR                   */
2916  03bd f704cd        	tst	_OSIntNesting
2917  03c0 2613          	bne	L7541
2918                     ; 830             if (OSLockNesting > 0u) {                      /* Do not decrement if already 0            */
2920  03c2 f704cc        	tst	_OSLockNesting
2921  03c5 270e          	beq	L7541
2922                     ; 831                 OSLockNesting--;                           /* Decrement lock nesting level             */
2924  03c7 7304cc        	dec	_OSLockNesting
2925                     ; 832                 if (OSLockNesting == 0u) {                 /* See if scheduler is enabled              */
2927  03ca 2609          	bne	L7541
2928                     ; 833                     OS_EXIT_CRITICAL();
2930  03cc 87            	clra	
2931  03cd 160000        	jsr	_OS_CPU_SR_Restore
2933                     ; 834                     OS_Sched();                            /* See if a HPT is ready                    */
2935  03d0 16080c        	jsr	_OS_Sched
2938  03d3 2004          	bra	L1541
2939  03d5               L7541:
2940                     ; 836                     OS_EXIT_CRITICAL();
2943                     ; 839                 OS_EXIT_CRITICAL();
2946                     ; 842             OS_EXIT_CRITICAL();
2948  03d5 87            	clra	
2949  03d6 160000        	jsr	_OS_CPU_SR_Restore
2951  03d9               L1541:
2952                     ; 845 }
2955  03d9 1b81          	leas	1,s
2956  03db 3d            	rts	
2958                     	xref	_OSStartHighRdy
2987                     ; 869 _NEAR void  OSStart (void)
2987                     ; 870 {
2988                     	switch	.text
2989  03dc               _OSStart:
2993                     ; 871     if (OSRunning == OS_FALSE) {
2995  03dc f604c0        	ldab	_OSRunning
2996  03df 261a          	bne	L7741
2997                     ; 872         OS_SchedNew();                               /* Find highest priority's task priority number   */
2999  03e1 160864        	jsr	L366_OS_SchedNew
3001                     ; 873         OSPrioCur     = OSPrioHighRdy;
3003  03e4 f604ca        	ldab	_OSPrioHighRdy
3004  03e7 7b04cb        	stab	_OSPrioCur
3005                     ; 874         OSTCBHighRdy  = OSTCBPrioTbl[OSPrioHighRdy]; /* Point to highest priority task ready to run    */
3007  03ea 87            	clra	
3008  03eb 59            	lsld	
3009  03ec b746          	tfr	d,y
3010  03ee ecea0393      	ldd	_OSTCBPrioTbl,y
3011  03f2 7c0415        	std	_OSTCBHighRdy
3012                     ; 875         OSTCBCur      = OSTCBHighRdy;
3014  03f5 7c0419        	std	_OSTCBCur
3015                     ; 876         OSStartHighRdy();                            /* Execute target specific code to start task     */
3017  03f8 160000        	jsr	_OSStartHighRdy
3019  03fb               L7741:
3020                     ; 878 }
3023  03fb 3d            	rts	
3402                     ; 937 _NEAR void  OSTimeTick (void)
3402                     ; 938 {
3403                     	switch	.text
3404  03fc               _OSTimeTick:
3406  03fc 1b9d          	leas	-3,s
3407       00000003      OFST:	set	3
3410                     ; 944     OS_CPU_SR  cpu_sr = 0u;
3412                     ; 950     OSTimeTickHook();                                      /* Call user definable hook                     */
3414  03fe 160000        	jsr	_OSTimeTickHook
3416                     ; 953     OS_ENTER_CRITICAL();                                   /* Update the 32-bit tick counter               */
3418  0401 160000        	jsr	_OS_CPU_SR_Save
3420  0404 6b82          	stab	OFST-1,s
3421                     ; 954     OSTime++;
3423  0406 fc0240        	ldd	_OSTime+2
3424  0409 c30001        	addd	#1
3425  040c 7c0240        	std	_OSTime+2
3426  040f 2408          	bcc	L05
3427  0411 72023f        	inc	_OSTime+1
3428  0414 2603          	bne	L05
3429  0416 72023e        	inc	_OSTime
3430  0419               L05:
3431                     ; 956     OS_EXIT_CRITICAL();
3434  0419 e682          	ldab	OFST-1,s
3435  041b 87            	clra	
3436  041c 160000        	jsr	_OS_CPU_SR_Restore
3438                     ; 958     if (OSRunning == OS_TRUE) {
3440  041f f604c0        	ldab	_OSRunning
3441  0422 53            	decb	
3442  0423 182600a6      	bne	L7271
3443                     ; 960         switch (OSTickStepState) {                         /* Determine whether we need to process a tick  */
3445  0427 f602d8        	ldab	_OSTickStepState
3447  042a 270f          	beq	L1051
3448  042c 040112        	dbeq	b,L3051
3449  042f 040113        	dbeq	b,L5051
3450                     ; 974             default:                                       /* Invalid case, correct situation              */
3450                     ; 975                  step            = OS_TRUE;
3452  0432 c601          	ldab	#1
3453  0434 6b82          	stab	OFST-1,s
3454                     ; 976                  OSTickStepState = OS_TICK_STEP_DIS;
3456  0436 7902d8        	clr	_OSTickStepState
3457                     ; 977                  break;
3459  0439 2011          	bra	L3371
3460  043b               L1051:
3461                     ; 961             case OS_TICK_STEP_DIS:                         /* Yes, stepping is disabled                    */
3461                     ; 962                  step = OS_TRUE;
3463  043b c601          	ldab	#1
3464  043d 6b82          	stab	OFST-1,s
3465                     ; 963                  break;
3467  043f 200b          	bra	L3371
3468  0441               L3051:
3469                     ; 965             case OS_TICK_STEP_WAIT:                        /* No,  waiting for uC/OS-View to set ...       */
3469                     ; 966                  step = OS_FALSE;                          /*      .. OSTickStepState to OS_TICK_STEP_ONCE */
3471  0441 6982          	clr	OFST-1,s
3472                     ; 967                  break;
3474  0443 2007          	bra	L3371
3475  0445               L5051:
3476                     ; 969             case OS_TICK_STEP_ONCE:                        /* Yes, process tick once and wait for next ... */
3476                     ; 970                  step            = OS_TRUE;                /*      ... step command from uC/OS-View        */
3478  0445 c601          	ldab	#1
3479  0447 6b82          	stab	OFST-1,s
3480                     ; 971                  OSTickStepState = OS_TICK_STEP_WAIT;
3482  0449 7b02d8        	stab	_OSTickStepState
3483                     ; 972                  break;
3485  044c               L3371:
3486                     ; 979         if (step == OS_FALSE) {                            /* Return if waiting for step command           */
3488  044c e682          	ldab	OFST-1,s
3489  044e 2603          	bne	L5371
3490                     ; 980             return;
3493  0450 1b83          	leas	3,s
3494  0452 3d            	rts	
3495  0453               L5371:
3496                     ; 983         ptcb = OSTCBList;                                  /* Point at first TCB in TCB list               */
3498  0453 1801800413    	movw	_OSTCBList,OFST-3,s
3500  0458 206a          	bra	L3471
3501  045a               L7371:
3502                     ; 985             OS_ENTER_CRITICAL();
3504  045a 160000        	jsr	_OS_CPU_SR_Save
3506  045d 6b82          	stab	OFST-1,s
3507                     ; 986             if (ptcb->OSTCBDly != 0u) {                    /* No, Delayed or waiting for event with TO     */
3509  045f ed80          	ldy	OFST-3,s
3510  0461 ece81e        	ldd	30,y
3511  0464 2605          	bne	LC007
3512  0466 ece820        	ldd	32,y
3513  0469 274f          	beq	L7471
3514  046b               LC007:
3515                     ; 987                 ptcb->OSTCBDly--;                          /* Decrement nbr of ticks to end of delay       */
3517  046b ece820        	ldd	32,y
3518  046e 830001        	subd	#1
3519  0471 6ce820        	std	32,y
3520  0474 ece81e        	ldd	30,y
3521  0477 c200          	sbcb	#0
3522  0479 8200          	sbca	#0
3523  047b 6ce81e        	std	30,y
3524                     ; 988                 if (ptcb->OSTCBDly == 0u) {                /* Check for timeout                            */
3526  047e 263a          	bne	L7471
3527  0480 ece820        	ldd	32,y
3528  0483 2635          	bne	L7471
3529                     ; 990                     if ((ptcb->OSTCBStat & OS_STAT_PEND_ANY) != OS_STAT_RDY) {
3531  0485 0fe822370b    	brclr	34,y,55,L3571
3532                     ; 991                         ptcb->OSTCBStat  &= (INT8U)~(INT8U)OS_STAT_PEND_ANY;   /* Yes, Clear status flag   */
3534  048a 0de82237      	bclr	34,y,55
3535                     ; 992                         ptcb->OSTCBStatPend = OS_STAT_PEND_TO;                 /* Indicate PEND timeout    */
3537  048e c601          	ldab	#1
3538  0490 6be823        	stab	35,y
3540  0493 2003          	bra	L5571
3541  0495               L3571:
3542                     ; 994                         ptcb->OSTCBStatPend = OS_STAT_PEND_OK;
3544  0495 69e823        	clr	35,y
3545  0498               L5571:
3546                     ; 997                     if ((ptcb->OSTCBStat & OS_STAT_SUSPEND) == OS_STAT_RDY) {  /* Is task suspended?       */
3548  0498 0ee822081d    	brset	34,y,8,L7471
3549                     ; 998                         OSRdyGrp               |= ptcb->OSTCBBitY;             /* No,  Make ready          */
3551  049d e6e828        	ldab	40,y
3552  04a0 fa04c9        	orab	_OSRdyGrp
3553  04a3 7b04c9        	stab	_OSRdyGrp
3554                     ; 999                         OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
3556  04a6 e6e826        	ldab	38,y
3557  04a9 b796          	exg	b,y
3558  04ab ee80          	ldx	OFST-3,s
3559  04ad e6e027        	ldab	39,x
3560  04b0 eaea04c1      	orab	_OSRdyTbl,y
3561  04b4 6bea04c1      	stab	_OSRdyTbl,y
3563  04b8 b756          	tfr	x,y
3564  04ba               L7471:
3565                     ; 1004             ptcb = ptcb->OSTCBNext;                        /* Point at next TCB in TCB list                */
3567  04ba 18024e80      	movw	14,y,OFST-3,s
3568                     ; 1005             OS_EXIT_CRITICAL();
3570  04be e682          	ldab	OFST-1,s
3571  04c0 87            	clra	
3572  04c1 160000        	jsr	_OS_CPU_SR_Restore
3574  04c4               L3471:
3575                     ; 984         while (ptcb->OSTCBPrio != OS_TASK_IDLE_PRIO) {     /* Go through all TCBs in TCB list              */
3577  04c4 ed80          	ldy	OFST-3,s
3578  04c6 e6e824        	ldab	36,y
3579  04c9 c13f          	cmpb	#63
3580  04cb 268d          	bne	L7371
3581  04cd               L7271:
3582                     ; 1008 }
3585  04cd 1b83          	leas	3,s
3586  04cf 3d            	rts	
3608                     ; 1025 _NEAR INT16U  OSVersion (void)
3608                     ; 1026 {
3609                     	switch	.text
3610  04d0               _OSVersion:
3614                     ; 1027     return (OS_VERSION);
3616  04d0 cc7274        	ldd	#29300
3619  04d3 3d            	rts	
3641                     ; 1044 _NEAR void  OS_Dummy (void)
3641                     ; 1045 {
3642                     	switch	.text
3643  04d4               _OS_Dummy:
3647                     ; 1046 }
3650  04d4 3d            	rts	
3749                     ; 1078 _NEAR INT8U  OS_EventTaskRdy (OS_EVENT  *pevent,
3749                     ; 1079                              void      *pmsg,
3749                     ; 1080                              INT8U      msk,
3749                     ; 1081                              INT8U      pend_stat)
3749                     ; 1082 {
3750                     	switch	.text
3751  04d5               _OS_EventTaskRdy:
3753  04d5 3b            	pshd	
3754  04d6 1b9c          	leas	-4,s
3755       00000004      OFST:	set	4
3758                     ; 1093     y    = OSUnMapTbl[pevent->OSEventGrp];              /* Find HPT waiting for message                */
3760  04d8 b746          	tfr	d,y
3761  04da e645          	ldab	5,y
3762  04dc 87            	clra	
3763  04dd b746          	tfr	d,y
3764  04df e6ea0000      	ldab	_OSUnMapTbl,y
3765  04e3 6b83          	stab	OFST-1,s
3766                     ; 1094     x    = OSUnMapTbl[pevent->OSEventTbl[y]];
3768  04e5 ed84          	ldy	OFST+0,s
3769  04e7 19ed          	leay	b,y
3770  04e9 e646          	ldab	6,y
3771  04eb b746          	tfr	d,y
3772  04ed e6ea0000      	ldab	_OSUnMapTbl,y
3773  04f1 6b82          	stab	OFST-2,s
3774                     ; 1095     prio = (INT8U)((y << 3u) + x);                      /* Find priority of task getting the msg       */
3776  04f3 e683          	ldab	OFST-1,s
3777  04f5 58            	lslb	
3778  04f6 58            	lslb	
3779  04f7 58            	lslb	
3780  04f8 eb82          	addb	OFST-2,s
3781  04fa 6b82          	stab	OFST-2,s
3782                     ; 1111     ptcb                  =  OSTCBPrioTbl[prio];        /* Point to this task's OS_TCB                 */
3784  04fc 59            	lsld	
3785  04fd b746          	tfr	d,y
3786  04ff edea0393      	ldy	_OSTCBPrioTbl,y
3787  0503 6d80          	sty	OFST-4,s
3788                     ; 1112     ptcb->OSTCBDly        =  0u;                        /* Prevent OSTimeTick() from readying task     */
3790  0505 87            	clra	
3791  0506 c7            	clrb	
3792  0507 6ce820        	std	32,y
3793  050a 6ce81e        	std	30,y
3794                     ; 1114     ptcb->OSTCBMsg        =  pmsg;                      /* Send message directly to waiting task       */
3796  050d ec88          	ldd	OFST+4,s
3797  050f 6ce818        	std	24,y
3798                     ; 1118     ptcb->OSTCBStat      &= (INT8U)~msk;                /* Clear bit associated with event type        */
3800  0512 e68b          	ldab	OFST+7,s
3801  0514 51            	comb	
3802  0515 e4e822        	andb	34,y
3803  0518 6be822        	stab	34,y
3804                     ; 1119     ptcb->OSTCBStatPend   =  pend_stat;                 /* Set pend status of post or abort            */
3806  051b e68d          	ldab	OFST+9,s
3807  051d 6be823        	stab	35,y
3808                     ; 1121     if ((ptcb->OSTCBStat &   OS_STAT_SUSPEND) == OS_STAT_RDY) {
3810  0520 0ee822081a    	brset	34,y,8,L5402
3811                     ; 1122         OSRdyGrp         |=  ptcb->OSTCBBitY;           /* Put task in the ready to run list           */
3813  0525 e6e828        	ldab	40,y
3814  0528 fa04c9        	orab	_OSRdyGrp
3815  052b 7b04c9        	stab	_OSRdyGrp
3816                     ; 1123         OSRdyTbl[y]      |=  ptcb->OSTCBBitX;
3818  052e e683          	ldab	OFST-1,s
3819  0530 b796          	exg	b,y
3820  0532 ee80          	ldx	OFST-4,s
3821  0534 e6e027        	ldab	39,x
3822  0537 eaea04c1      	orab	_OSRdyTbl,y
3823  053b 6bea04c1      	stab	_OSRdyTbl,y
3825  053f               L5402:
3826                     ; 1127     OS_EventTaskRemove(ptcb, pevent);                   /* Remove this task from event   wait list     */
3828  053f ec84          	ldd	OFST+0,s
3829  0541 3b            	pshd	
3830  0542 ec82          	ldd	OFST-2,s
3831  0544 160610        	jsr	_OS_EventTaskRemove
3833  0547 1b82          	leas	2,s
3834                     ; 1129     if (ptcb->OSTCBEventMultiPtr != (OS_EVENT **)0) {   /* Remove this task from events' wait lists    */
3836  0549 ed80          	ldy	OFST-4,s
3837  054b ece814        	ldd	20,y
3838  054e 2714          	beq	L7402
3839                     ; 1130         OS_EventTaskRemoveMulti(ptcb, ptcb->OSTCBEventMultiPtr);
3841  0550 3b            	pshd	
3842  0551 b764          	tfr	y,d
3843  0553 16063d        	jsr	_OS_EventTaskRemoveMulti
3845  0556 1b82          	leas	2,s
3846                     ; 1131         ptcb->OSTCBEventMultiPtr  = (OS_EVENT **)0;     /* No longer pending on multi list             */
3848  0558 87            	clra	
3849  0559 c7            	clrb	
3850  055a ed80          	ldy	OFST-4,s
3851  055c 6ce814        	std	20,y
3852                     ; 1132         ptcb->OSTCBEventMultiRdy  = (OS_EVENT  *)pevent;/* Return event as first multi-pend event ready*/
3854  055f ec84          	ldd	OFST+0,s
3855  0561 6ce816        	std	22,y
3856  0564               L7402:
3857                     ; 1136     return (prio);
3859  0564 e682          	ldab	OFST-2,s
3862  0566 1b86          	leas	6,s
3863  0568 3d            	rts	
3909                     ; 1156 _NEAR void  OS_EventTaskWait (OS_EVENT *pevent)
3909                     ; 1157 {
3910                     	switch	.text
3911  0569               _OS_EventTaskWait:
3913  0569 3b            	pshd	
3914  056a 37            	pshb	
3915       00000001      OFST:	set	1
3918                     ; 1161     OSTCBCur->OSTCBEventPtr               = pevent;                 /* Store ptr to ECB in TCB         */
3920  056b fe0419        	ldx	_OSTCBCur
3921                     ; 1163     pevent->OSEventTbl[OSTCBCur->OSTCBY] |= OSTCBCur->OSTCBBitX;    /* Put task in waiting list        */
3923  056e b746          	tfr	d,y
3924  0570 6de012        	sty	18,x
3925  0573 e6e026        	ldab	38,x
3926  0576 87            	clra	
3927  0577 19ed          	leay	b,y
3928  0579 e6e027        	ldab	39,x
3929  057c ea46          	orab	6,y
3930  057e 6b46          	stab	6,y
3931                     ; 1164     pevent->OSEventGrp                   |= OSTCBCur->OSTCBBitY;
3933  0580 ed81          	ldy	OFST+0,s
3934  0582 e6e028        	ldab	40,x
3935  0585 ea45          	orab	5,y
3936  0587 6b45          	stab	5,y
3937                     ; 1166     y             =  OSTCBCur->OSTCBY;            /* Task no longer ready                              */
3939  0589 b756          	tfr	x,y
3940  058b e6e826        	ldab	38,y
3941                     ; 1167     OSRdyTbl[y]  &= (OS_PRIO)~OSTCBCur->OSTCBBitX;
3943  058e b746          	tfr	d,y
3944  0590 e6e027        	ldab	39,x
3945  0593 51            	comb	
3946  0594 e4ea04c1      	andb	_OSRdyTbl,y
3947  0598 6bea04c1      	stab	_OSRdyTbl,y
3948                     ; 1169     if (OSRdyTbl[y] == 0u) {                      /* Clear event grp bit if this was only task pending */
3951  059c 260c          	bne	L3702
3952                     ; 1170         OSRdyGrp &= (OS_PRIO)~OSTCBCur->OSTCBBitY;
3954  059e b756          	tfr	x,y
3955  05a0 e6e828        	ldab	40,y
3956  05a3 51            	comb	
3957  05a4 f404c9        	andb	_OSRdyGrp
3958  05a7 7b04c9        	stab	_OSRdyGrp
3959  05aa               L3702:
3960                     ; 1172 }
3963  05aa 1b83          	leas	3,s
3964  05ac 3d            	rts	
4037                     ; 1192 _NEAR void  OS_EventTaskWaitMulti (OS_EVENT **pevents_wait)
4037                     ; 1193 {
4038                     	switch	.text
4039  05ad               _OS_EventTaskWaitMulti:
4041  05ad 3b            	pshd	
4042  05ae 1b9b          	leas	-5,s
4043       00000005      OFST:	set	5
4046                     ; 1199     OSTCBCur->OSTCBEventMultiPtr = (OS_EVENT **)pevents_wait;       /* Store ptr to ECBs in TCB        */
4048  05b0 fd0419        	ldy	_OSTCBCur
4049  05b3 6ce814        	std	20,y
4050                     ; 1200     OSTCBCur->OSTCBEventMultiRdy = (OS_EVENT  *)0;
4052  05b6 87            	clra	
4053  05b7 c7            	clrb	
4054  05b8 6ce816        	std	22,y
4055                     ; 1202     pevents =  pevents_wait;
4057  05bb ee85          	ldx	OFST+0,s
4058  05bd 6e82          	stx	OFST-3,s
4059                     ; 1203     pevent  = *pevents;
4061  05bf ec00          	ldd	0,x
4062  05c1 6c80          	std	OFST-5,s
4064  05c3 b765          	tfr	y,x
4065  05c5 201f          	bra	L7312
4066  05c7               L3312:
4067                     ; 1205         pevent->OSEventTbl[OSTCBCur->OSTCBY] |= OSTCBCur->OSTCBBitX;
4069  05c7 b746          	tfr	d,y
4070  05c9 e6e026        	ldab	38,x
4071  05cc 19ed          	leay	b,y
4072  05ce e6e027        	ldab	39,x
4073  05d1 ea46          	orab	6,y
4074  05d3 6b46          	stab	6,y
4075                     ; 1206         pevent->OSEventGrp                   |= OSTCBCur->OSTCBBitY;
4077  05d5 ed80          	ldy	OFST-5,s
4078  05d7 e6e028        	ldab	40,x
4079  05da ea45          	orab	5,y
4080  05dc 6b45          	stab	5,y
4081                     ; 1207         pevents++;
4083  05de ed82          	ldy	OFST-3,s
4084                     ; 1208         pevent = *pevents;
4086  05e0 ec61          	ldd	2,+y
4087  05e2 6d82          	sty	OFST-3,s
4088  05e4 6c80          	std	OFST-5,s
4089  05e6               L7312:
4090                     ; 1204     while (pevent != (OS_EVENT *)0) {                               /* Put task in waiting lists       */
4092  05e6 26df          	bne	L3312
4093                     ; 1211     y             =  OSTCBCur->OSTCBY;            /* Task no longer ready                              */
4095  05e8 fd0419        	ldy	_OSTCBCur
4096  05eb e6e826        	ldab	38,y
4097                     ; 1212     OSRdyTbl[y]  &= (OS_PRIO)~OSTCBCur->OSTCBBitX;
4099  05ee b796          	exg	b,y
4100  05f0 fe0419        	ldx	_OSTCBCur
4101  05f3 e6e027        	ldab	39,x
4102  05f6 51            	comb	
4103  05f7 e4ea04c1      	andb	_OSRdyTbl,y
4104  05fb 6bea04c1      	stab	_OSRdyTbl,y
4105                     ; 1214     if (OSRdyTbl[y] == 0u) {                      /* Clear event grp bit if this was only task pending */
4108  05ff 260c          	bne	L3412
4109                     ; 1215         OSRdyGrp &= (OS_PRIO)~OSTCBCur->OSTCBBitY;
4111  0601 b756          	tfr	x,y
4112  0603 e6e828        	ldab	40,y
4113  0606 51            	comb	
4114  0607 f404c9        	andb	_OSRdyGrp
4115  060a 7b04c9        	stab	_OSRdyGrp
4116  060d               L3412:
4117                     ; 1217 }
4120  060d 1b87          	leas	7,s
4121  060f 3d            	rts	
4176                     ; 1237 _NEAR void  OS_EventTaskRemove (OS_TCB   *ptcb,
4176                     ; 1238                                OS_EVENT *pevent)
4176                     ; 1239 {
4177                     	switch	.text
4178  0610               _OS_EventTaskRemove:
4180  0610 3b            	pshd	
4181  0611 37            	pshb	
4182       00000001      OFST:	set	1
4185                     ; 1243     y                       =  ptcb->OSTCBY;
4187  0612 b746          	tfr	d,y
4188  0614 e6e826        	ldab	38,y
4189  0617 6b80          	stab	OFST-1,s
4190                     ; 1244     pevent->OSEventTbl[y]  &= (OS_PRIO)~ptcb->OSTCBBitX;    /* Remove task from wait list              */
4192  0619 ed85          	ldy	OFST+4,s
4193  061b 19ed          	leay	b,y
4194  061d ee81          	ldx	OFST+0,s
4195  061f e6e027        	ldab	39,x
4196  0622 51            	comb	
4197  0623 e446          	andb	6,y
4198  0625 6b46          	stab	6,y
4199                     ; 1245     if (pevent->OSEventTbl[y] == 0u) {
4201  0627 260a          	bne	L5712
4202                     ; 1246         pevent->OSEventGrp &= (OS_PRIO)~ptcb->OSTCBBitY;
4204  0629 ed85          	ldy	OFST+4,s
4205  062b e6e028        	ldab	40,x
4206  062e 51            	comb	
4207  062f e445          	andb	5,y
4208  0631 6b45          	stab	5,y
4209  0633               L5712:
4210                     ; 1248     ptcb->OSTCBEventPtr     = (OS_EVENT  *)0;               /* Unlink OS_EVENT from OS_TCB             */
4212  0633 87            	clra	
4213  0634 c7            	clrb	
4214  0635 b756          	tfr	x,y
4215  0637 6ce812        	std	18,y
4216                     ; 1249 }
4219  063a 1b83          	leas	3,s
4220  063c 3d            	rts	
4316                     ; 1269 _NEAR void  OS_EventTaskRemoveMulti (OS_TCB    *ptcb,
4316                     ; 1270                                     OS_EVENT **pevents_multi)
4316                     ; 1271 {
4317                     	switch	.text
4318  063d               _OS_EventTaskRemoveMulti:
4320  063d 3b            	pshd	
4321  063e 1b99          	leas	-7,s
4322       00000007      OFST:	set	7
4325                     ; 1279     y       =  ptcb->OSTCBY;
4327  0640 b746          	tfr	d,y
4328  0642 e6e826        	ldab	38,y
4329  0645 6b84          	stab	OFST-3,s
4330                     ; 1280     bity    =  ptcb->OSTCBBitY;
4332  0647 ed87          	ldy	OFST+0,s
4333  0649 e6e828        	ldab	40,y
4334  064c 6b85          	stab	OFST-2,s
4335                     ; 1281     bitx    =  ptcb->OSTCBBitX;
4337  064e e6e827        	ldab	39,y
4338  0651 6b86          	stab	OFST-1,s
4339                     ; 1282     pevents =  pevents_multi;
4341  0653 18028b82      	movw	OFST+4,s,OFST-5,s
4342                     ; 1283     pevent  = *pevents;
4344  0657 ecf30002      	ldd	[OFST-5,s]
4346  065b 201c          	bra	L3522
4347  065d               L7422:
4348                     ; 1285         pevent->OSEventTbl[y]  &= (OS_PRIO)~bitx;
4350  065d e684          	ldab	OFST-3,s
4351  065f 19ed          	leay	b,y
4352  0661 e686          	ldab	OFST-1,s
4353  0663 51            	comb	
4354  0664 e446          	andb	6,y
4355  0666 6b46          	stab	6,y
4356                     ; 1286         if (pevent->OSEventTbl[y] == 0u) {
4358  0668 2609          	bne	L7522
4359                     ; 1287             pevent->OSEventGrp &= (OS_PRIO)~bity;
4361  066a ed80          	ldy	OFST-7,s
4362  066c e685          	ldab	OFST-2,s
4363  066e 51            	comb	
4364  066f e445          	andb	5,y
4365  0671 6b45          	stab	5,y
4366  0673               L7522:
4367                     ; 1289         pevents++;
4369  0673 ed82          	ldy	OFST-5,s
4370                     ; 1290         pevent = *pevents;
4372  0675 ec61          	ldd	2,+y
4373  0677 6d82          	sty	OFST-5,s
4374  0679               L3522:
4375  0679 6c80          	std	OFST-7,s
4376                     ; 1284     while (pevent != (OS_EVENT *)0) {                   /* Remove task from all events' wait lists     */
4378  067b ed80          	ldy	OFST-7,s
4379  067d 26de          	bne	L7422
4380                     ; 1292 }
4383  067f 1b89          	leas	9,s
4384  0681 3d            	rts	
4428                     ; 1310 _NEAR void  OS_EventWaitListInit (OS_EVENT *pevent)
4428                     ; 1311 {
4429                     	switch	.text
4430  0682               _OS_EventWaitListInit:
4432  0682 3b            	pshd	
4433  0683 37            	pshb	
4434       00000001      OFST:	set	1
4437                     ; 1315     pevent->OSEventGrp = 0u;                     /* No task waiting on event                           */
4439  0684 b746          	tfr	d,y
4440  0686 c7            	clrb	
4441  0687 6b45          	stab	5,y
4442                     ; 1316     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
4444  0689 6b80          	stab	OFST-1,s
4445  068b               L3032:
4446                     ; 1317         pevent->OSEventTbl[i] = 0u;
4448  068b ed81          	ldy	OFST+0,s
4449  068d 87            	clra	
4450  068e 19ed          	leay	b,y
4451  0690 6a46          	staa	6,y
4452                     ; 1316     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
4454  0692 6280          	inc	OFST-1,s
4457  0694 e680          	ldab	OFST-1,s
4458  0696 c108          	cmpb	#8
4459  0698 25f1          	blo	L3032
4460                     ; 1319 }
4463  069a 1b83          	leas	3,s
4464  069c 3d            	rts	
4529                     ; 1336 static  void  OS_InitEventList (void)
4529                     ; 1337 {
4530                     	switch	.text
4531  069d               L156_OS_InitEventList:
4533  069d 1b9a          	leas	-6,s
4534       00000006      OFST:	set	6
4537                     ; 1346     OS_MemClr((INT8U *)&OSEventTbl[0], sizeof(OSEventTbl)); /* Clear the event table                   */
4539  069f cc00a0        	ldd	#160
4540  06a2 3b            	pshd	
4541  06a3 cc04f3        	ldd	#_OSEventTbl
4542  06a6 1607e0        	jsr	_OS_MemClr
4544  06a9 1b82          	leas	2,s
4545                     ; 1347     for (ix = 0u; ix < (OS_MAX_EVENTS - 1u); ix++) {        /* Init. list of free EVENT control blocks */
4547  06ab 87            	clra	
4548  06ac c7            	clrb	
4549  06ad b746          	tfr	d,y
4550  06af 6d82          	sty	OFST-4,s
4551  06b1               L3432:
4552                     ; 1348         ix_next = ix + 1u;
4554  06b1 02            	iny	
4555                     ; 1349         pevent1 = &OSEventTbl[ix];
4557  06b2 59            	lsld	
4558  06b3 59            	lsld	
4559  06b4 59            	lsld	
4560  06b5 59            	lsld	
4561  06b6 c304f3        	addd	#_OSEventTbl
4562  06b9 6c80          	std	OFST-6,s
4563                     ; 1350         pevent2 = &OSEventTbl[ix_next];
4565  06bb b764          	tfr	y,d
4566  06bd 59            	lsld	
4567  06be 59            	lsld	
4568  06bf 59            	lsld	
4569  06c0 59            	lsld	
4570  06c1 c304f3        	addd	#_OSEventTbl
4571  06c4 6c84          	std	OFST-2,s
4572                     ; 1351         pevent1->OSEventType    = OS_EVENT_TYPE_UNUSED;
4574  06c6 ed80          	ldy	OFST-6,s
4575  06c8 6940          	clr	0,y
4576                     ; 1352         pevent1->OSEventPtr     = pevent2;
4578  06ca 6c41          	std	1,y
4579                     ; 1354         pevent1->OSEventName    = (INT8U *)(void *)"?";     /* Unknown name                            */
4581  06cc cc010e        	ldd	#L1532
4582  06cf 6c4e          	std	14,y
4583                     ; 1347     for (ix = 0u; ix < (OS_MAX_EVENTS - 1u); ix++) {        /* Init. list of free EVENT control blocks */
4585  06d1 ed82          	ldy	OFST-4,s
4586  06d3 02            	iny	
4589  06d4 b764          	tfr	y,d
4590  06d6 6c82          	std	OFST-4,s
4591  06d8 8c0009        	cpd	#9
4592  06db 25d4          	blo	L3432
4593                     ; 1357     pevent1                         = &OSEventTbl[ix];
4595  06dd 59            	lsld	
4596  06de 59            	lsld	
4597  06df 59            	lsld	
4598  06e0 59            	lsld	
4599  06e1 c304f3        	addd	#_OSEventTbl
4600  06e4 6c80          	std	OFST-6,s
4601                     ; 1358     pevent1->OSEventType            = OS_EVENT_TYPE_UNUSED;
4603  06e6 87            	clra	
4604  06e7 ed80          	ldy	OFST-6,s
4605  06e9 6a40          	staa	0,y
4606                     ; 1359     pevent1->OSEventPtr             = (OS_EVENT *)0;
4608  06eb c7            	clrb	
4609  06ec 6c41          	std	1,y
4610                     ; 1361     pevent1->OSEventName            = (INT8U *)(void *)"?"; /* Unknown name                            */
4612  06ee cc010e        	ldd	#L1532
4613  06f1 6c4e          	std	14,y
4614                     ; 1363     OSEventFreeList                 = &OSEventTbl[0];
4616  06f3 cc04f3        	ldd	#_OSEventTbl
4617  06f6 7c0593        	std	_OSEventFreeList
4618                     ; 1373 }
4621  06f9 1b86          	leas	6,s
4622  06fb 3d            	rts	
4651                     ; 1389 static  void  OS_InitMisc (void)
4651                     ; 1390 {
4652                     	switch	.text
4653  06fc               L356_OS_InitMisc:
4657                     ; 1392     OSTime                    = 0uL;                       /* Clear the 32-bit system clock            */
4659  06fc 87            	clra	
4660  06fd c7            	clrb	
4661  06fe 7c0240        	std	_OSTime+2
4662  0701 7c023e        	std	_OSTime
4663                     ; 1395     OSIntNesting              = 0u;                        /* Clear the interrupt nesting counter      */
4665  0704 7a04cd        	staa	_OSIntNesting
4666                     ; 1396     OSLockNesting             = 0u;                        /* Clear the scheduling lock counter        */
4668  0707 7b04cc        	stab	_OSLockNesting
4669                     ; 1398     OSTaskCtr                 = 0u;                        /* Clear the number of tasks                */
4671  070a 7b04bf        	stab	_OSTaskCtr
4672                     ; 1400     OSRunning                 = OS_FALSE;                  /* Indicate that multitasking not started   */
4674  070d 7a04c0        	staa	_OSRunning
4675                     ; 1402     OSCtxSwCtr                = 0u;                        /* Clear the context switch counter         */
4677  0710 7c0597        	std	_OSCtxSwCtr+2
4678  0713 7c0595        	std	_OSCtxSwCtr
4679                     ; 1403     OSIdleCtr                 = 0uL;                       /* Clear the 32-bit idle counter            */
4681  0716 7c04bd        	std	_OSIdleCtr+2
4682  0719 7c04bb        	std	_OSIdleCtr
4683                     ; 1418 }
4686  071c 3d            	rts	
4723                     ; 1434 static  void  OS_InitRdyList (void)
4723                     ; 1435 {
4724                     	switch	.text
4725  071d               L556_OS_InitRdyList:
4727  071d 37            	pshb	
4728       00000001      OFST:	set	1
4731                     ; 1439     OSRdyGrp      = 0u;                                    /* Clear the ready list                     */
4733  071e c7            	clrb	
4734  071f 7b04c9        	stab	_OSRdyGrp
4735                     ; 1440     for (i = 0u; i < OS_RDY_TBL_SIZE; i++) {
4737  0722 6b80          	stab	OFST-1,s
4738  0724               L7732:
4739                     ; 1441         OSRdyTbl[i] = 0u;
4741  0724 87            	clra	
4742  0725 b746          	tfr	d,y
4743  0727 6aea04c1      	staa	_OSRdyTbl,y
4744                     ; 1440     for (i = 0u; i < OS_RDY_TBL_SIZE; i++) {
4746  072b 6280          	inc	OFST-1,s
4749  072d e680          	ldab	OFST-1,s
4750  072f c108          	cmpb	#8
4751  0731 25f1          	blo	L7732
4752                     ; 1444     OSPrioCur     = 0u;
4754  0733 c7            	clrb	
4755  0734 7b04cb        	stab	_OSPrioCur
4756                     ; 1445     OSPrioHighRdy = 0u;
4758  0737 7a04ca        	staa	_OSPrioHighRdy
4759                     ; 1447     OSTCBHighRdy  = (OS_TCB *)0;
4761  073a 7c0415        	std	_OSTCBHighRdy
4762                     ; 1448     OSTCBCur      = (OS_TCB *)0;
4764  073d 7c0419        	std	_OSTCBCur
4765                     ; 1449 }
4768  0740 1b81          	leas	1,s
4769  0742 3d            	rts	
4805                     ; 1465 static  void  OS_InitTaskIdle (void)
4805                     ; 1466 {
4806                     	switch	.text
4807  0743               L756_OS_InitTaskIdle:
4809  0743 37            	pshb	
4810       00000001      OFST:	set	1
4813                     ; 1474     (void)OSTaskCreateExt(OS_TaskIdle,
4813                     ; 1475                           (void *)0,                                 /* No arguments passed to OS_TaskIdle() */
4813                     ; 1476                           &OSTaskIdleStk[OS_TASK_IDLE_STK_SIZE - 1u],/* Set Top-Of-Stack                     */
4813                     ; 1477                           OS_TASK_IDLE_PRIO,                         /* Lowest priority level                */
4813                     ; 1478                           OS_TASK_IDLE_ID,
4813                     ; 1479                           &OSTaskIdleStk[0],                         /* Set Bottom-Of-Stack                  */
4813                     ; 1480                           OS_TASK_IDLE_STK_SIZE,
4813                     ; 1481                           (void *)0,                                 /* No TCB extension                     */
4813                     ; 1482                           OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR);/* Enable stack checking + clear stack  */
4815  0744 cc0003        	ldd	#3
4816  0747 3b            	pshd	
4817  0748 c7            	clrb	
4818  0749 3b            	pshd	
4819  074a c6a0          	ldab	#160
4820  074c 3b            	pshd	
4821  074d c7            	clrb	
4822  074e 3b            	pshd	
4823  074f cc041b        	ldd	#_OSTaskIdleStk
4824  0752 3b            	pshd	
4825  0753 ccffff        	ldd	#-1
4826  0756 3b            	pshd	
4827  0757 cc003f        	ldd	#63
4828  075a 3b            	pshd	
4829  075b cc04ba        	ldd	#_OSTaskIdleStk+159
4830  075e 3b            	pshd	
4831  075f 87            	clra	
4832  0760 c7            	clrb	
4833  0761 3b            	pshd	
4834  0762 cc08a3        	ldd	#_OS_TaskIdle
4835  0765 160000        	jsr	_OSTaskCreateExt
4837  0768 1bf012        	leas	18,s
4838                     ; 1509     OSTaskNameSet(OS_TASK_IDLE_PRIO, (INT8U *)(void *)"uC/OS-II Idle", &err);
4840  076b 1a80          	leax	OFST-1,s
4841  076d 34            	pshx	
4842  076e cc0100        	ldd	#L1242
4843  0771 3b            	pshd	
4844  0772 cc003f        	ldd	#63
4845  0775 160000        	jsr	_OSTaskNameSet
4847                     ; 1511 }
4850  0778 1b85          	leas	5,s
4851  077a 3d            	rts	
4918                     ; 1591 static  void  OS_InitTCBList (void)
4918                     ; 1592 {
4919                     	switch	.text
4920  077b               L166_OS_InitTCBList:
4922  077b 1b9a          	leas	-6,s
4923       00000006      OFST:	set	6
4926                     ; 1599     OS_MemClr((INT8U *)&OSTCBTbl[0],     sizeof(OSTCBTbl));      /* Clear all the TCBs                 */
4928  077d cc00ba        	ldd	#186
4929  0780 3b            	pshd	
4930  0781 cc02d9        	ldd	#_OSTCBTbl
4931  0784 075a          	jsr	_OS_MemClr
4933                     ; 1600     OS_MemClr((INT8U *)&OSTCBPrioTbl[0], sizeof(OSTCBPrioTbl));  /* Clear the priority table           */
4935  0786 cc0080        	ldd	#128
4936  0789 6c80          	std	0,s
4937  078b cc0393        	ldd	#_OSTCBPrioTbl
4938  078e 0750          	jsr	_OS_MemClr
4940  0790 1b82          	leas	2,s
4941                     ; 1601     for (ix = 0u; ix < (OS_MAX_TASKS + OS_N_SYS_TASKS - 1u); ix++) {    /* Init. list of free TCBs     */
4943  0792 c7            	clrb	
4944  0793 6b80          	stab	OFST-6,s
4945  0795               L5542:
4946                     ; 1602         ix_next =  ix + 1u;
4948  0795 52            	incb	
4949  0796 6b83          	stab	OFST-3,s
4950                     ; 1603         ptcb1   = &OSTCBTbl[ix];
4952  0798 e680          	ldab	OFST-6,s
4953  079a 863e          	ldaa	#62
4954  079c 12            	mul	
4955  079d c302d9        	addd	#_OSTCBTbl
4956  07a0 6c81          	std	OFST-5,s
4957                     ; 1604         ptcb2   = &OSTCBTbl[ix_next];
4959  07a2 e683          	ldab	OFST-3,s
4960  07a4 863e          	ldaa	#62
4961  07a6 12            	mul	
4962  07a7 c302d9        	addd	#_OSTCBTbl
4963  07aa 6c84          	std	OFST-2,s
4964                     ; 1605         ptcb1->OSTCBNext = ptcb2;
4966  07ac ed81          	ldy	OFST-5,s
4967  07ae 6c4e          	std	14,y
4968                     ; 1607         ptcb1->OSTCBTaskName = (INT8U *)(void *)"?";             /* Unknown name                       */
4970  07b0 cc010e        	ldd	#L1532
4971  07b3 6ce83c        	std	60,y
4972                     ; 1601     for (ix = 0u; ix < (OS_MAX_TASKS + OS_N_SYS_TASKS - 1u); ix++) {    /* Init. list of free TCBs     */
4974  07b6 6280          	inc	OFST-6,s
4977  07b8 e680          	ldab	OFST-6,s
4978  07ba c102          	cmpb	#2
4979  07bc 25d7          	blo	L5542
4980                     ; 1610     ptcb1                   = &OSTCBTbl[ix];
4982  07be 863e          	ldaa	#62
4983  07c0 12            	mul	
4984  07c1 c302d9        	addd	#_OSTCBTbl
4985  07c4 6c81          	std	OFST-5,s
4986                     ; 1611     ptcb1->OSTCBNext        = (OS_TCB *)0;                       /* Last OS_TCB                        */
4988  07c6 87            	clra	
4989  07c7 c7            	clrb	
4990  07c8 ed81          	ldy	OFST-5,s
4991  07ca 6c4e          	std	14,y
4992                     ; 1613     ptcb1->OSTCBTaskName    = (INT8U *)(void *)"?";              /* Unknown name                       */
4994  07cc cc010e        	ldd	#L1532
4995  07cf 6ce83c        	std	60,y
4996                     ; 1615     OSTCBList               = (OS_TCB *)0;                       /* TCB lists initializations          */
4998  07d2 87            	clra	
4999  07d3 c7            	clrb	
5000  07d4 7c0413        	std	_OSTCBList
5001                     ; 1616     OSTCBFreeList           = &OSTCBTbl[0];
5003  07d7 cc02d9        	ldd	#_OSTCBTbl
5004  07da 7c0417        	std	_OSTCBFreeList
5005                     ; 1617 }
5008  07dd 1b86          	leas	6,s
5009  07df 3d            	rts	
5050                     ; 1640 _NEAR void  OS_MemClr (INT8U  *pdest,
5050                     ; 1641                       INT16U  size)
5050                     ; 1642 {
5051                     	switch	.text
5052  07e0               _OS_MemClr:
5054  07e0 3b            	pshd	
5055       00000000      OFST:	set	0
5058  07e1 200b          	bra	L5052
5059  07e3               L3052:
5060                     ; 1644         *pdest++ = (INT8U)0;
5062  07e3 ed80          	ldy	OFST+0,s
5063  07e5 6970          	clr	1,y+
5064  07e7 6d80          	sty	OFST+0,s
5065                     ; 1645         size--;
5067  07e9 b746          	tfr	d,y
5068  07eb 03            	dey	
5069  07ec 6d84          	sty	OFST+4,s
5070  07ee               L5052:
5071                     ; 1643     while (size > 0u) {
5073  07ee ec84          	ldd	OFST+4,s
5074  07f0 26f1          	bne	L3052
5075                     ; 1647 }
5078  07f2 31            	puly	
5079  07f3 3d            	rts	
5130                     ; 1674 _NEAR void  OS_MemCopy (INT8U  *pdest,
5130                     ; 1675                        INT8U  *psrc,
5130                     ; 1676                        INT16U  size)
5130                     ; 1677 {
5131                     	switch	.text
5132  07f4               _OS_MemCopy:
5134  07f4 3b            	pshd	
5135       00000000      OFST:	set	0
5138  07f5 ee84          	ldx	OFST+4,s
5139  07f7 200d          	bra	L7352
5140  07f9               L5352:
5141                     ; 1679         *pdest++ = *psrc++;
5143  07f9 ed80          	ldy	OFST+0,s
5144  07fb 180a3070      	movb	1,x+,1,y+
5145  07ff 6d80          	sty	OFST+0,s
5146                     ; 1680         size--;
5148  0801 ed86          	ldy	OFST+6,s
5149  0803 03            	dey	
5150  0804 6d86          	sty	OFST+6,s
5151  0806               L7352:
5152                     ; 1678     while (size > 0u) {
5154  0806 ec86          	ldd	OFST+6,s
5155  0808 26ef          	bne	L5352
5156                     ; 1682 }
5159  080a 31            	puly	
5160  080b 3d            	rts	
5203                     ; 1702 _NEAR void  OS_Sched (void)
5203                     ; 1703 {
5204                     	switch	.text
5205  080c               _OS_Sched:
5207  080c 37            	pshb	
5208       00000001      OFST:	set	1
5211                     ; 1705     OS_CPU_SR  cpu_sr = 0u;
5213                     ; 1710     OS_ENTER_CRITICAL();
5215  080d 160000        	jsr	_OS_CPU_SR_Save
5217  0810 6b80          	stab	OFST-1,s
5218                     ; 1711     if (OSIntNesting == 0u) {                          /* Schedule only if all ISRs done and ...       */
5220  0812 f604cd        	ldab	_OSIntNesting
5221  0815 2644          	bne	L7552
5222                     ; 1712         if (OSLockNesting == 0u) {                     /* ... scheduler is not locked                  */
5224  0817 f604cc        	ldab	_OSLockNesting
5225  081a 263f          	bne	L7552
5226                     ; 1713             OS_SchedNew();
5228  081c 0746          	jsr	L366_OS_SchedNew
5230                     ; 1714             OSTCBHighRdy = OSTCBPrioTbl[OSPrioHighRdy];
5232  081e f604ca        	ldab	_OSPrioHighRdy
5233  0821 87            	clra	
5234  0822 59            	lsld	
5235  0823 b746          	tfr	d,y
5236  0825 edea0393      	ldy	_OSTCBPrioTbl,y
5237  0829 7d0415        	sty	_OSTCBHighRdy
5238                     ; 1715             if (OSPrioHighRdy != OSPrioCur) {          /* No Ctx Sw if current task is highest rdy     */
5240  082c f604ca        	ldab	_OSPrioHighRdy
5241  082f f104cb        	cmpb	_OSPrioCur
5242  0832 2727          	beq	L7552
5243                     ; 1717                 OSTCBHighRdy->OSTCBCtxSwCtr++;         /* Inc. # of context switches to this task      */
5245  0834 ece82c        	ldd	44,y
5246  0837 c30001        	addd	#1
5247  083a 6ce82c        	std	44,y
5248  083d 2408          	bcc	L611
5249  083f 62e82b        	inc	43,y
5250  0842 2603          	bne	L611
5251  0844 62e82a        	inc	42,y
5252  0847               L611:
5253                     ; 1719                 OSCtxSwCtr++;                          /* Increment context switch counter             */
5255  0847 fc0597        	ldd	_OSCtxSwCtr+2
5256  084a c30001        	addd	#1
5257  084d 7c0597        	std	_OSCtxSwCtr+2
5258  0850 2408          	bcc	L021
5259  0852 720596        	inc	_OSCtxSwCtr+1
5260  0855 2603          	bne	L021
5261  0857 720595        	inc	_OSCtxSwCtr
5262  085a               L021:
5263                     ; 1727                 OS_TASK_SW();                          /* Perform a context switch                     */
5266  085a 3f            	swi	
5269  085b               L7552:
5270                     ; 1731     OS_EXIT_CRITICAL();
5272  085b e680          	ldab	OFST-1,s
5273  085d 87            	clra	
5274  085e 160000        	jsr	_OS_CPU_SR_Restore
5276                     ; 1732 }
5279  0861 1b81          	leas	1,s
5280  0863 3d            	rts	
5315                     ; 1751 _NEAR static  void  OS_SchedNew (void)
5315                     ; 1752 {
5316                     	switch	.text
5317  0864               L366_OS_SchedNew:
5319  0864 37            	pshb	
5320       00000001      OFST:	set	1
5323                     ; 1757     y             = OSUnMapTbl[OSRdyGrp];
5325  0865 f604c9        	ldab	_OSRdyGrp
5326  0868 87            	clra	
5327  0869 b746          	tfr	d,y
5328  086b e6ea0000      	ldab	_OSUnMapTbl,y
5329  086f 6b80          	stab	OFST-1,s
5330                     ; 1758     OSPrioHighRdy = (INT8U)((y << 3u) + OSUnMapTbl[OSRdyTbl[y]]);
5332  0871 b746          	tfr	d,y
5333  0873 e6ea04c1      	ldab	_OSRdyTbl,y
5334  0877 b746          	tfr	d,y
5335  0879 e680          	ldab	OFST-1,s
5336  087b 58            	lslb	
5337  087c 58            	lslb	
5338  087d 58            	lslb	
5339  087e ebea0000      	addb	_OSUnMapTbl,y
5340  0882 7b04ca        	stab	_OSPrioHighRdy
5341                     ; 1776 }
5344  0885 1b81          	leas	1,s
5345  0887 3d            	rts	
5386                     ; 1796 _NEAR INT8U  OS_StrLen (INT8U *psrc)
5386                     ; 1797 {
5387                     	switch	.text
5388  0888               _OS_StrLen:
5390  0888 3b            	pshd	
5391  0889 37            	pshb	
5392       00000001      OFST:	set	1
5395                     ; 1802     if (psrc == (INT8U *)0) {
5397  088a 046402        	tbne	d,L1262
5398                     ; 1803         return (0u);
5401  088d 2011          	bra	L621
5402  088f               L1262:
5403                     ; 1807     len = 0u;
5405  088f 6980          	clr	OFST-1,s
5407  0891 b746          	tfr	d,y
5408  0893 2003          	bra	L7262
5409  0895               L3262:
5410                     ; 1809         psrc++;
5412  0895 02            	iny	
5413                     ; 1810         len++;
5415  0896 6280          	inc	OFST-1,s
5416  0898               L7262:
5417                     ; 1808     while (*psrc != OS_ASCII_NUL) {
5417                     ; 1809         psrc++;
5417                     ; 1810         len++;
5419  0898 e640          	ldab	0,y
5420  089a 26f9          	bne	L3262
5421  089c 6d81          	sty	OFST+0,s
5422                     ; 1812     return (len);
5424  089e e680          	ldab	OFST-1,s
5426  08a0               L621:
5428  08a0 1b83          	leas	3,s
5429  08a2 3d            	rts	
5474                     ; 1838 _NEAR void  OS_TaskIdle (void *p_arg)
5474                     ; 1839 {
5475                     	switch	.text
5476  08a3               _OS_TaskIdle:
5478  08a3 3b            	pshd	
5479  08a4 37            	pshb	
5480       00000001      OFST:	set	1
5483                     ; 1841     OS_CPU_SR  cpu_sr = 0u;
5485                     ; 1844     (void)p_arg;                                 /* Prevent compiler warning for not using 'p_arg'     */
5487  08a5               L3562:
5488                     ; 1846         OS_ENTER_CRITICAL();
5490  08a5 160000        	jsr	_OS_CPU_SR_Save
5492  08a8 6b80          	stab	OFST-1,s
5493                     ; 1847         OSIdleCtr++;
5495  08aa fc04bd        	ldd	_OSIdleCtr+2
5496  08ad c30001        	addd	#1
5497  08b0 7c04bd        	std	_OSIdleCtr+2
5498  08b3 2408          	bcc	L231
5499  08b5 7204bc        	inc	_OSIdleCtr+1
5500  08b8 2603          	bne	L231
5501  08ba 7204bb        	inc	_OSIdleCtr
5502  08bd               L231:
5503                     ; 1848         OS_EXIT_CRITICAL();
5505  08bd e680          	ldab	OFST-1,s
5506  08bf 87            	clra	
5507  08c0 160000        	jsr	_OS_CPU_SR_Restore
5509                     ; 1849         OSTaskIdleHook();                        /* Call user definable HOOK                           */
5511  08c3 160000        	jsr	_OSTaskIdleHook
5514  08c6 20dd          	bra	L3562
5597                     ; 1949 _NEAR void  OS_TaskStatStkChk (void)
5597                     ; 1950 {
5598                     	switch	.text
5599  08c8               _OS_TaskStatStkChk:
5601  08c8 1b94          	leas	-12,s
5602       0000000c      OFST:	set	12
5605                     ; 1957     for (prio = 0u; prio <= OS_TASK_IDLE_PRIO; prio++) {
5607  08ca 6982          	clr	OFST-10,s
5608  08cc               L7172:
5609                     ; 1958         err = OSTaskStkChk(prio, &stk_data);
5611  08cc 1a83          	leax	OFST-9,s
5612  08ce 34            	pshx	
5613  08cf e684          	ldab	OFST-8,s
5614  08d1 87            	clra	
5615  08d2 160000        	jsr	_OSTaskStkChk
5617  08d5 1b82          	leas	2,s
5618  08d7 6b8b          	stab	OFST-1,s
5619                     ; 1959         if (err == OS_ERR_NONE) {
5621  08d9 2624          	bne	L5272
5622                     ; 1960             ptcb = OSTCBPrioTbl[prio];
5624  08db e682          	ldab	OFST-10,s
5625  08dd 87            	clra	
5626  08de 59            	lsld	
5627  08df b746          	tfr	d,y
5628  08e1 edea0393      	ldy	_OSTCBPrioTbl,y
5629  08e5 6d80          	sty	OFST-12,s
5630                     ; 1961             if (ptcb != (OS_TCB *)0) {                               /* Make sure task 'ptcb' is ...   */
5632  08e7 ec80          	ldd	OFST-12,s
5633  08e9 2714          	beq	L5272
5634                     ; 1962                 if (ptcb != OS_TCB_RESERVED) {                       /* ... still valid.               */
5636  08eb 040411        	dbeq	d,L5272
5637                     ; 1965                     ptcb->OSTCBStkBase = ptcb->OSTCBStkBottom + ptcb->OSTCBStkSize;
5639  08ee ec48          	ldd	8,y
5640  08f0 e344          	addd	4,y
5641  08f2 6ce836        	std	54,y
5642                     ; 1969                     ptcb->OSTCBStkUsed = stk_data.OSUsed;            /* Store number of entries used   */
5644  08f5 ec89          	ldd	OFST-3,s
5645  08f7 6ce83a        	std	58,y
5646  08fa ec87          	ldd	OFST-5,s
5647  08fc 6ce838        	std	56,y
5648  08ff               L5272:
5649                     ; 1957     for (prio = 0u; prio <= OS_TASK_IDLE_PRIO; prio++) {
5651  08ff 6282          	inc	OFST-10,s
5654  0901 e682          	ldab	OFST-10,s
5655  0903 c13f          	cmpb	#63
5656  0905 23c5          	bls	L7172
5657                     ; 1975 }
5660  0907 1b8c          	leas	12,s
5661  0909 3d            	rts	
5772                     ; 2022 _NEAR INT8U  OS_TCBInit (INT8U    prio,
5772                     ; 2023                         OS_STK  *ptos,
5772                     ; 2024                         OS_STK  *pbos,
5772                     ; 2025                         INT16U   id,
5772                     ; 2026                         INT32U   stk_size,
5772                     ; 2027                         void    *pext,
5772                     ; 2028                         INT16U   opt)
5772                     ; 2029 {
5773                     	switch	.text
5774  090a               _OS_TCBInit:
5776  090a 3b            	pshd	
5777  090b 1b9d          	leas	-3,s
5778       00000003      OFST:	set	3
5781                     ; 2032     OS_CPU_SR  cpu_sr = 0u;
5783                     ; 2044     OS_ENTER_CRITICAL();
5785  090d 160000        	jsr	_OS_CPU_SR_Save
5787  0910 6b82          	stab	OFST-1,s
5788                     ; 2045     ptcb = OSTCBFreeList;                                  /* Get a free TCB from the free TCB list    */
5790  0912 fd0417        	ldy	_OSTCBFreeList
5791  0915 6d80          	sty	OFST-3,s
5792                     ; 2046     if (ptcb != (OS_TCB *)0) {
5794  0917 18270104      	beq	L1003
5795                     ; 2047         OSTCBFreeList            = ptcb->OSTCBNext;        /* Update pointer to free TCB list          */
5797  091b 18054e0417    	movw	14,y,_OSTCBFreeList
5798                     ; 2048         OS_EXIT_CRITICAL();
5800  0920 87            	clra	
5801  0921 160000        	jsr	_OS_CPU_SR_Restore
5803                     ; 2049         ptcb->OSTCBStkPtr        = ptos;                   /* Load Stack pointer in TCB                */
5805  0924 ed80          	ldy	OFST-3,s
5806  0926 18028740      	movw	OFST+4,s,0,y
5807                     ; 2050         ptcb->OSTCBPrio          = prio;                   /* Load task priority into TCB              */
5809  092a e684          	ldab	OFST+1,s
5810  092c 6be824        	stab	36,y
5811                     ; 2051         ptcb->OSTCBStat          = OS_STAT_RDY;            /* Task is ready to run                     */
5813  092f c7            	clrb	
5814  0930 6be822        	stab	34,y
5815                     ; 2052         ptcb->OSTCBStatPend      = OS_STAT_PEND_OK;        /* Clear pend status                        */
5817  0933 87            	clra	
5818  0934 6ae823        	staa	35,y
5819                     ; 2053         ptcb->OSTCBDly           = 0u;                     /* Task is not delayed                      */
5821  0937 6ce820        	std	32,y
5822  093a 6ce81e        	std	30,y
5823                     ; 2056         ptcb->OSTCBExtPtr        = pext;                   /* Store pointer to TCB extension           */
5825  093d ecf011        	ldd	OFST+14,s
5826  0940 6c42          	std	2,y
5827                     ; 2057         ptcb->OSTCBStkSize       = stk_size;               /* Store stack size                         */
5829  0942 18028f48      	movw	OFST+12,s,8,y
5830  0946 18028d46      	movw	OFST+10,s,6,y
5831                     ; 2058         ptcb->OSTCBStkBottom     = pbos;                   /* Store pointer to bottom of stack         */
5833  094a 18028944      	movw	OFST+6,s,4,y
5834                     ; 2059         ptcb->OSTCBOpt           = opt;                    /* Store task options                       */
5836  094e ecf013        	ldd	OFST+16,s
5837  0951 6c4a          	std	10,y
5838                     ; 2060         ptcb->OSTCBId            = id;                     /* Store task ID                            */
5840  0953 18028b4c      	movw	OFST+8,s,12,y
5841                     ; 2070         ptcb->OSTCBDelReq        = OS_ERR_NONE;
5843  0957 69e829        	clr	41,y
5844                     ; 2074         ptcb->OSTCBY             = (INT8U)(prio >> 3u);
5846  095a e684          	ldab	OFST+1,s
5847  095c 54            	lsrb	
5848  095d 54            	lsrb	
5849  095e 54            	lsrb	
5850  095f 6be826        	stab	38,y
5851                     ; 2075         ptcb->OSTCBX             = (INT8U)(prio & 0x07u);
5853  0962 e684          	ldab	OFST+1,s
5854  0964 c407          	andb	#7
5855  0966 6be825        	stab	37,y
5856                     ; 2081         ptcb->OSTCBBitY          = (OS_PRIO)(1uL << ptcb->OSTCBY);
5858  0969 c601          	ldab	#1
5859  096b a6e826        	ldaa	38,y
5860  096e 2704          	beq	L041
5861  0970               L241:
5862  0970 58            	lslb	
5863  0971 0430fc        	dbne	a,L241
5864  0974               L041:
5865  0974 6be828        	stab	40,y
5866                     ; 2082         ptcb->OSTCBBitX          = (OS_PRIO)(1uL << ptcb->OSTCBX);
5868  0977 c601          	ldab	#1
5869  0979 a6e825        	ldaa	37,y
5870  097c 2704          	beq	L441
5871  097e               L641:
5872  097e 58            	lslb	
5873  097f 0430fc        	dbne	a,L641
5874  0982               L441:
5875  0982 6be827        	stab	39,y
5876                     ; 2085         ptcb->OSTCBEventPtr      = (OS_EVENT  *)0;         /* Task is not pending on an  event         */
5878  0985 87            	clra	
5879  0986 c7            	clrb	
5880  0987 6ce812        	std	18,y
5881                     ; 2087         ptcb->OSTCBEventMultiPtr = (OS_EVENT **)0;         /* Task is not pending on any events        */
5883  098a 6ce814        	std	20,y
5884                     ; 2088         ptcb->OSTCBEventMultiRdy = (OS_EVENT  *)0;         /* No events readied for Multipend          */
5886  098d 6ce816        	std	22,y
5887                     ; 2093         ptcb->OSTCBFlagNode      = (OS_FLAG_NODE *)0;      /* Task is not pending on an event flag     */
5889  0990 6ce81a        	std	26,y
5890                     ; 2097         ptcb->OSTCBMsg           = (void *)0;              /* No message received                      */
5892  0993 6ce818        	std	24,y
5893                     ; 2101         ptcb->OSTCBCtxSwCtr      = 0uL;                    /* Initialize profiling variables           */
5895  0996 6ce82c        	std	44,y
5896  0999 6ce82a        	std	42,y
5897                     ; 2102         ptcb->OSTCBCyclesStart   = 0uL;
5899  099c 6ce834        	std	52,y
5900  099f 6ce832        	std	50,y
5901                     ; 2103         ptcb->OSTCBCyclesTot     = 0uL;
5903  09a2 6ce830        	std	48,y
5904  09a5 6ce82e        	std	46,y
5905                     ; 2104         ptcb->OSTCBStkBase       = (OS_STK *)0;
5907  09a8 6ce836        	std	54,y
5908                     ; 2105         ptcb->OSTCBStkUsed       = 0uL;
5910  09ab 6ce83a        	std	58,y
5911  09ae 6ce838        	std	56,y
5912                     ; 2109         ptcb->OSTCBTaskName      = (INT8U *)(void *)"?";
5914  09b1 cc010e        	ldd	#L1532
5915  09b4 6ce83c        	std	60,y
5916                     ; 2118         OSTCBInitHook(ptcb);
5918  09b7 ec80          	ldd	OFST-3,s
5919  09b9 160000        	jsr	_OSTCBInitHook
5921                     ; 2120         OS_ENTER_CRITICAL();
5923  09bc 160000        	jsr	_OS_CPU_SR_Save
5925  09bf 6b82          	stab	OFST-1,s
5926                     ; 2121         OSTCBPrioTbl[prio] = ptcb;
5928  09c1 e684          	ldab	OFST+1,s
5929  09c3 87            	clra	
5930  09c4 59            	lsld	
5931  09c5 b746          	tfr	d,y
5932  09c7 ec80          	ldd	OFST-3,s
5933  09c9 6cea0393      	std	_OSTCBPrioTbl,y
5934                     ; 2122         OS_EXIT_CRITICAL();
5936  09cd e682          	ldab	OFST-1,s
5937  09cf 87            	clra	
5938  09d0 160000        	jsr	_OS_CPU_SR_Restore
5940                     ; 2124         OSTaskCreateHook(ptcb);                            /* Call user defined hook                   */
5942  09d3 ec80          	ldd	OFST-3,s
5943  09d5 160000        	jsr	_OSTaskCreateHook
5945                     ; 2135         OS_ENTER_CRITICAL();
5947  09d8 160000        	jsr	_OS_CPU_SR_Save
5949  09db 6b82          	stab	OFST-1,s
5950                     ; 2136         ptcb->OSTCBNext = OSTCBList;                       /* Link into TCB chain                      */
5952  09dd ed80          	ldy	OFST-3,s
5953  09df 18014e0413    	movw	_OSTCBList,14,y
5954                     ; 2137         ptcb->OSTCBPrev = (OS_TCB *)0;
5956  09e4 87            	clra	
5957  09e5 c7            	clrb	
5958  09e6 6ce810        	std	16,y
5959                     ; 2138         if (OSTCBList != (OS_TCB *)0) {
5961  09e9 fd0413        	ldy	_OSTCBList
5962  09ec 2705          	beq	L3003
5963                     ; 2139             OSTCBList->OSTCBPrev = ptcb;
5965  09ee ec80          	ldd	OFST-3,s
5966  09f0 6ce810        	std	16,y
5967  09f3               L3003:
5968                     ; 2141         OSTCBList               = ptcb;
5970  09f3 ed80          	ldy	OFST-3,s
5971  09f5 7d0413        	sty	_OSTCBList
5972                     ; 2142         OSRdyGrp               |= ptcb->OSTCBBitY;         /* Make task ready to run                   */
5974  09f8 e6e828        	ldab	40,y
5975  09fb fa04c9        	orab	_OSRdyGrp
5976  09fe 7b04c9        	stab	_OSRdyGrp
5977                     ; 2143         OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
5979  0a01 e6e826        	ldab	38,y
5980  0a04 87            	clra	
5981  0a05 b746          	tfr	d,y
5982  0a07 ee80          	ldx	OFST-3,s
5983  0a09 e6e027        	ldab	39,x
5984  0a0c eaea04c1      	orab	_OSRdyTbl,y
5985  0a10 6bea04c1      	stab	_OSRdyTbl,y
5986                     ; 2144         OSTaskCtr++;                                       /* Increment the #tasks counter             */
5988  0a14 7204bf        	inc	_OSTaskCtr
5989                     ; 2146         OS_EXIT_CRITICAL();
5992  0a17 e682          	ldab	OFST-1,s
5993  0a19 160000        	jsr	_OS_CPU_SR_Restore
5995                     ; 2147         return (OS_ERR_NONE);
5997  0a1c c7            	clrb	
5999  0a1d 2006          	bra	L051
6000  0a1f               L1003:
6001                     ; 2149     OS_EXIT_CRITICAL();
6003  0a1f 87            	clra	
6004  0a20 160000        	jsr	_OS_CPU_SR_Restore
6006                     ; 2150     return (OS_ERR_TASK_NO_MORE_TCB);
6008  0a23 c642          	ldab	#66
6010  0a25               L051:
6012  0a25 1b85          	leas	5,s
6013  0a27 3d            	rts	
6037                     	xref	_OSTimeTickHook
6038                     	xref	_OSTCBInitHook
6039                     	xref	_OSTaskIdleHook
6040                     	xref	_OSTaskCreateHook
6041                     	xref	_OSInitHookEnd
6042                     	xref	_OSInitHookBegin
6043                     	xref	_OSDebugInit
6044                     	xref	_OSTmr_Init
6045                     	xdef	_OS_TCBInit
6046                     	xdef	_OS_TaskStatStkChk
6047                     	xdef	_OS_TaskIdle
6048                     	xdef	_OS_StrLen
6049                     	xdef	_OS_Sched
6050                     	xref	_OS_QInit
6051                     	xref	_OS_MemInit
6052                     	xdef	_OS_MemCopy
6053                     	xdef	_OS_MemClr
6054                     	xref	_OS_FlagInit
6055                     	xdef	_OS_EventWaitListInit
6056                     	xdef	_OS_EventTaskRemoveMulti
6057                     	xdef	_OS_EventTaskWaitMulti
6058                     	xdef	_OS_EventTaskRemove
6059                     	xdef	_OS_EventTaskWait
6060                     	xdef	_OS_EventTaskRdy
6061                     	xdef	_OS_Dummy
6062                     	xdef	_OSVersion
6063                     	xdef	_OSStart
6064                     	xdef	_OSSchedUnlock
6065                     	xdef	_OSSchedLock
6066                     	xdef	_OSIntExit
6067                     	xdef	_OSIntEnter
6068                     	xdef	_OSInit
6069                     	xdef	_OSTimeTick
6070                     	xref	_OSTaskStkChk
6071                     	xref	_OSTaskNameSet
6072                     	xref	_OSTaskCreateExt
6073                     	xdef	_OSEventPendMulti
6074                     	xdef	_OSEventNameSet
6075                     	xdef	_OSEventNameGet
6076                     	xdef	_OSUnMapTbl
6077                     	switch	.bss
6078  0000               _OSTmrWheelTbl:
6079  0000 000000000000  	ds.b	32
6080                     	xdef	_OSTmrWheelTbl
6081  0020               _OSTmrTaskStk:
6082  0020 000000000000  	ds.b	160
6083                     	xdef	_OSTmrTaskStk
6084  00c0               _OSTmrFreeList:
6085  00c0 0000          	ds.b	2
6086                     	xdef	_OSTmrFreeList
6087  00c2               _OSTmrTbl:
6088  00c2 000000000000  	ds.b	368
6089                     	xdef	_OSTmrTbl
6090  0232               _OSTmrSemSignal:
6091  0232 0000          	ds.b	2
6092                     	xdef	_OSTmrSemSignal
6093  0234               _OSTmrSem:
6094  0234 0000          	ds.b	2
6095                     	xdef	_OSTmrSem
6096  0236               _OSTmrTime:
6097  0236 00000000      	ds.b	4
6098                     	xdef	_OSTmrTime
6099  023a               _OSTmrUsed:
6100  023a 0000          	ds.b	2
6101                     	xdef	_OSTmrUsed
6102  023c               _OSTmrFree:
6103  023c 0000          	ds.b	2
6104                     	xdef	_OSTmrFree
6105  023e               _OSTime:
6106  023e 00000000      	ds.b	4
6107                     	xdef	_OSTime
6108  0242               _OSQTbl:
6109  0242 000000000000  	ds.b	56
6110                     	xdef	_OSQTbl
6111  027a               _OSQFreeList:
6112  027a 0000          	ds.b	2
6113                     	xdef	_OSQFreeList
6114  027c               _OSMemTbl:
6115  027c 000000000000  	ds.b	90
6116                     	xdef	_OSMemTbl
6117  02d6               _OSMemFreeList:
6118  02d6 0000          	ds.b	2
6119                     	xdef	_OSMemFreeList
6120  02d8               _OSTickStepState:
6121  02d8 00            	ds.b	1
6122                     	xdef	_OSTickStepState
6123  02d9               _OSTCBTbl:
6124  02d9 000000000000  	ds.b	186
6125                     	xdef	_OSTCBTbl
6126  0393               _OSTCBPrioTbl:
6127  0393 000000000000  	ds.b	128
6128                     	xdef	_OSTCBPrioTbl
6129  0413               _OSTCBList:
6130  0413 0000          	ds.b	2
6131                     	xdef	_OSTCBList
6132  0415               _OSTCBHighRdy:
6133  0415 0000          	ds.b	2
6134                     	xdef	_OSTCBHighRdy
6135  0417               _OSTCBFreeList:
6136  0417 0000          	ds.b	2
6137                     	xdef	_OSTCBFreeList
6138  0419               _OSTCBCur:
6139  0419 0000          	ds.b	2
6140                     	xdef	_OSTCBCur
6141  041b               _OSTaskIdleStk:
6142  041b 000000000000  	ds.b	160
6143                     	xdef	_OSTaskIdleStk
6144  04bb               _OSIdleCtr:
6145  04bb 00000000      	ds.b	4
6146                     	xdef	_OSIdleCtr
6147  04bf               _OSTaskCtr:
6148  04bf 00            	ds.b	1
6149                     	xdef	_OSTaskCtr
6150  04c0               _OSRunning:
6151  04c0 00            	ds.b	1
6152                     	xdef	_OSRunning
6153  04c1               _OSRdyTbl:
6154  04c1 000000000000  	ds.b	8
6155                     	xdef	_OSRdyTbl
6156  04c9               _OSRdyGrp:
6157  04c9 00            	ds.b	1
6158                     	xdef	_OSRdyGrp
6159  04ca               _OSPrioHighRdy:
6160  04ca 00            	ds.b	1
6161                     	xdef	_OSPrioHighRdy
6162  04cb               _OSPrioCur:
6163  04cb 00            	ds.b	1
6164                     	xdef	_OSPrioCur
6165  04cc               _OSLockNesting:
6166  04cc 00            	ds.b	1
6167                     	xdef	_OSLockNesting
6168  04cd               _OSIntNesting:
6169  04cd 00            	ds.b	1
6170                     	xdef	_OSIntNesting
6171  04ce               _OSFlagFreeList:
6172  04ce 0000          	ds.b	2
6173                     	xdef	_OSFlagFreeList
6174  04d0               _OSFlagTbl:
6175  04d0 000000000000  	ds.b	35
6176                     	xdef	_OSFlagTbl
6177  04f3               _OSEventTbl:
6178  04f3 000000000000  	ds.b	160
6179                     	xdef	_OSEventTbl
6180  0593               _OSEventFreeList:
6181  0593 0000          	ds.b	2
6182                     	xdef	_OSEventFreeList
6183  0595               _OSCtxSwCtr:
6184  0595 00000000      	ds.b	4
6185                     	xdef	_OSCtxSwCtr
6186                     	xref	_OS_CPU_SR_Restore
6187                     	xref	_OS_CPU_SR_Save
6188                     	switch	.const
6189  0100               L1242:
6190  0100 75432f4f532d  	dc.b	"uC/OS-II Idle",0
6191  010e               L1532:
6192  010e 3f00          	dc.b	"?",0
6213                     	end
