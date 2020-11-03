// Avoid multiple inclusions.
#ifndef _iosdg256_h
#define _iosdg256_h

/*	IO DEFINITIONS FOR MCS912DG256
 *	Copyright (c) 2003 by COSMIC Software
 */
#ifndef _BASE
#define _BASE	0
#endif
#define _IO(x)	@(_BASE)+(x)

typedef unsigned char __uchar;
typedef unsigned int __uint;

/*	MEBI Module
 */
volatile __uint  PORTAB       _IO(0x00);   /* port A+B */
volatile __uchar PORTA        _IO(0x00);   /* port A */
volatile __uchar PORTB        _IO(0x01);   /* port B */
volatile __uint  DDRAB        _IO(0x02);   /* data direction port A+B */
volatile __uchar DDRA         _IO(0x02);   /* data direction port A */
volatile __uchar DDRB         _IO(0x03);   /* data direction port B */
volatile __uchar PORTE        _IO(0x08);   /* port E */
volatile __uchar DDRE         _IO(0x09);   /* data direction port E */
volatile __uchar PEAR         _IO(0x0a);   /* port E assignment register */
volatile __uchar MODE         _IO(0x0b);   /* mode register */
volatile __uchar PUCR         _IO(0x0c);   /* pull-up control register */
volatile __uchar RDRIV        _IO(0x0d);   /* reduced drive of I/O lines */
volatile __uchar EBICTL       _IO(0x0e);   /* external bus interface control */

/*	MMC Module
 */
volatile __uchar INITRM       _IO(0x10);   /* RAM mapping register */
volatile __uchar INITRG       _IO(0x11);   /* IO mapping register */
volatile __uchar INITEE       _IO(0x12);   /* EEPROM mapping register */
volatile __uchar MISC         _IO(0x13);   /* mapping control register */
volatile __uchar MTST0        _IO(0x14);   /* mapping test register 0 */

/*	INT Module
 */
volatile __uchar ITCR         _IO(0x15);   /* interrupt test control reg. */
volatile __uchar ITEST        _IO(0x16);   /* interrupt test register */

/*	MMC Module
 */
volatile __uchar MTST1        _IO(0x17);   /* mapping test register 1 */
volatile __uint  PARTID       _IO(0x1a);   /* part ID register */
volatile __uchar MEMSIZ0      _IO(0x1c);   /* memory size register 0 */
volatile __uchar MEMSIZ1      _IO(0x1d);   /* memory size register 1 */

/*	INT Module
 */
volatile __uchar INTCR        _IO(0x1e);   /* interrupt control register */
volatile __uchar HPRIO        _IO(0x1f);   /* highest priority */

/*	BKP Module
 */
volatile __uchar BKPCT0       _IO(0x28);   /* Breakpoint Control 0 */
volatile __uchar BKPCT1       _IO(0x29);   /* Breakpoint Control 1 */
volatile __uchar BKP0X        _IO(0x2a);   /* Breakpoint 0 address upper */
volatile __uint  BKP0         _IO(0x2b);   /* Breakpoint 0 address */
volatile __uchar BKP1X        _IO(0x2d);   /* Breakpoint 1 address upper */
volatile __uint  BKP1         _IO(0x2e);   /* Breakpoint 1 address */

/*	MEBI Module
 */
volatile __uchar PPAGE        _IO(0x30);   /* program page register */
volatile __uchar PORTK        _IO(0x32);   /* port K data register */
volatile __uchar DDRK         _IO(0x33);   /* port K data direction */

/*	CRG Module
 */
volatile __uchar SYNR         _IO(0x34);   /* synthesizer register */
volatile __uchar REFDV        _IO(0x35);   /* reference divider register */
volatile __uchar CTFLG        _IO(0x36);   /* clock test flag register */
volatile __uchar CRGFLG       _IO(0x37);   /* clock generator flag register */
volatile __uchar CRGINT       _IO(0x38);   /* clock interrupt enable */
volatile __uchar CLKSEL       _IO(0x39);   /* clock select register */
volatile __uchar PLLCTL       _IO(0x3a);   /* PLL control register */
volatile __uchar RTICTL       _IO(0x3b);   /* clock real time control reg. */
volatile __uchar COPCTL       _IO(0x3c);   /* COP control register */
volatile __uchar FORBYP       _IO(0x3d);   /* clock force and bypass register */
volatile __uchar CTCTL        _IO(0x3e);   /* clock test control register */
volatile __uchar ARMCOP       _IO(0x3f);   /* COP arm/reset register */

/*	Enhanced Capture Timer Module
 */
volatile __uchar TIOS         _IO(0x40);   /* timer select register */
volatile __uchar CFORC        _IO(0x41);   /* compare force register */
volatile __uchar OC7M         _IO(0x42);   /* oc7 mask register */
volatile __uchar OC7D         _IO(0x43);   /* oc7 data register */
volatile __uint  TCNT         _IO(0x44);   /* timer counter */
volatile __uchar TSCR1        _IO(0x46);   /* system control register 1 */
volatile __uchar TTOV         _IO(0x47);   /* toggle on overflow register */
volatile __uchar TCTL1        _IO(0x48);   /* control register 1 */
volatile __uchar TCTL2        _IO(0x49);   /* control register 2 */
volatile __uchar TCTL3        _IO(0x4a);   /* control register 3 */
volatile __uchar TCTL4        _IO(0x4b);   /* control register 4 */
volatile __uchar TIE          _IO(0x4c);   /* interrupt enable register */
volatile __uchar TSCR2        _IO(0x4d);   /* system control register 2 */
volatile __uchar TFLG1        _IO(0x4e);   /* interrupt flag register 1 */
volatile __uchar TFLG2        _IO(0x4f);   /* interrupt flag register 2 */
volatile __uint  TC0          _IO(0x50);   /* capture/compare register 0 */
volatile __uint  TC1          _IO(0x52);   /* capture/compare register 1 */
volatile __uint  TC2          _IO(0x54);   /* capture/compare register 2 */
volatile __uint  TC3          _IO(0x56);   /* capture/compare register 3 */
volatile __uint  TC4          _IO(0x58);   /* capture/compare register 4 */
volatile __uint  TC5          _IO(0x5a);   /* capture/compare register 5 */
volatile __uint  TC6          _IO(0x5c);   /* capture/compare register 6 */
volatile __uint  TC7          _IO(0x5e);   /* capture/compare register 7 */
volatile __uchar PACTL        _IO(0x60);   /* pulse accumulator A control */
volatile __uchar PAFLG        _IO(0x61);   /* pulse accumulator A flag */
volatile __uint  PACN32       _IO(0x62);   /* pulse accumulator A3+A2 count */
volatile __uchar PACN3        _IO(0x62);   /* pulse accumulator A3 count */
volatile __uchar PACN2        _IO(0x63);   /* pulse accumulator A2 count */
volatile __uint  PACN10       _IO(0x64);   /* pulse accumulator A1+A0 count */
volatile __uchar PACN1        _IO(0x64);   /* pulse accumulator A1 count */
volatile __uchar PACN0        _IO(0x65);   /* pulse accumulator A0 count */
volatile __uchar MCCTL        _IO(0x66);   /* modulus counter control reg */
volatile __uchar MCFLG        _IO(0x67);   /* modulus counter flag reg */
volatile __uchar ICPAR        _IO(0x68);   /* input control pulse acc reg */
volatile __uchar DLYCT        _IO(0x69);   /* delay counter control reg */
volatile __uchar ICOVW        _IO(0x6a);   /* input control overwrite reg */
volatile __uchar ICSYS        _IO(0x6b);   /* input control system reg */
volatile __uchar TIMTST       _IO(0x6d);   /* timer test register */
volatile __uchar PBCTL        _IO(0x70);   /* pulse accumulator B control */
volatile __uchar PBFLG        _IO(0x71);   /* pulse accumulator B flag */
volatile __uint  PA32H        _IO(0x72);   /* pulse accumulator B3+B2 count */
volatile __uchar PA3H         _IO(0x72);   /* pulse accumulator B3 count */
volatile __uchar PA2H         _IO(0x73);   /* pulse accumulator B2 count */
volatile __uint  PA10H        _IO(0x74);   /* pulse accumulator B1+B0 count */
volatile __uchar PA1H         _IO(0x74);   /* pulse accumulator B1 count */
volatile __uchar PA0H         _IO(0x75);   /* pulse accumulator B0 count */
volatile __uint  MCCNT        _IO(0x76);   /* modulus counter count reg */
volatile __uint  TC0H         _IO(0x78);   /* timer input capture hold 0 */
volatile __uint  TC1H         _IO(0x7a);   /* timer input capture hold 1 */
volatile __uint  TC2H         _IO(0x7c);   /* timer input capture hold 2 */
volatile __uint  TC3H         _IO(0x7e);   /* timer input capture hold 3 */

/*	ATD0 Module
 */
volatile __uint  ATD0CTL01    _IO(0x80);   /* A/D0 control register 0+1 */
volatile __uchar ATD0CTL0     _IO(0x80);   /* A/D0 control register 0 */
volatile __uchar ATD0CTL1     _IO(0x81);   /* A/D0 control register 1 */
volatile __uint  ATD0CTL23    _IO(0x82);   /* A/D0 control register 2+3 */
volatile __uchar ATD0CTL2     _IO(0x82);   /* A/D0 control register 2 */
volatile __uchar ATD0CTL3     _IO(0x83);   /* A/D0 control register 3 */
volatile __uint  ATD0CTL45    _IO(0x84);   /* A/D0 control register 4+5 */
volatile __uchar ATD0CTL4     _IO(0x84);   /* A/D0 control register 4 */
volatile __uchar ATD0CTL5     _IO(0x85);   /* A/D0 control register 5 */
volatile __uchar ATD0STAT0    _IO(0x86);   /* A/D0 status register 0 */
volatile __uchar ATD0TEST0    _IO(0x88);   /* A/D0 test register 0 */
volatile __uchar ATD0TEST1    _IO(0x89);   /* A/D0 test register 1 */
volatile __uchar ATD0STAT1    _IO(0x8b);   /* A/D0 status register 1 */
volatile __uchar ATD0DIEN     _IO(0x8d);   /* A/D0 interrupt enable */
volatile __uchar PORTAD0      _IO(0x8f);   /* port AD0 data input register */
volatile __uint  ATD0DR[8]    _IO(0x90);   /* A/D0 result */
volatile __uint  ATD0DR0      _IO(0x90);   /* A/D0 result 0 */
volatile __uint  ATD0DR1      _IO(0x92);   /* A/D0 result 1 */
volatile __uint  ATD0DR2      _IO(0x94);   /* A/D0 result 2 */
volatile __uint  ATD0DR3      _IO(0x96);   /* A/D0 result 3 */
volatile __uint  ATD0DR4      _IO(0x98);   /* A/D0 result 4 */
volatile __uint  ATD0DR5      _IO(0x9a);   /* A/D0 result 5 */
volatile __uint  ATD0DR6      _IO(0x9c);   /* A/D0 result 6 */
volatile __uint  ATD0DR7      _IO(0x9e);   /* A/D0 result 7 */

/*	PWM Module
 */
volatile __uchar PWME         _IO(0xa0);   /* PWM Enable */
volatile __uchar PWMPOL       _IO(0xa1);   /* PWM Clock Polarity */
volatile __uchar PWMCLK       _IO(0xa2);   /* PWM Clocks */
volatile __uchar PWMPRCLK     _IO(0xa3);   /* PWM prescale clock select */
volatile __uchar PWMCAE       _IO(0xa4);   /* PWM center align enable */
volatile __uchar PWMCTL       _IO(0xa5);   /* PWM Control Register */
volatile __uchar PWMTST       _IO(0xa6);   /* PWM Test Register */
volatile __uchar PWMPRSC      _IO(0xa7);   /* PWM Test Register */
volatile __uchar PWMSCLA      _IO(0xa8);   /* PWM scale A */
volatile __uchar PWMSCLB      _IO(0xa9);   /* PWM scale B */
volatile __uchar PWMSCNTA     _IO(0xaa);   /* PWM Test Register A */
volatile __uchar PWMSCNTB     _IO(0xab);   /* PWM Test Register B */
volatile __uint  PWMCNT01     _IO(0xac);   /* PWM Channel Counter 0+1 */
volatile __uchar PWMCNT0      _IO(0xac);   /* PWM Channel Counter 0 */
volatile __uchar PWMCNT1      _IO(0xad);   /* PWM Channel Counter 1 */
volatile __uint  PWMCNT23     _IO(0xae);   /* PWM Channel Counter 2+3 */
volatile __uchar PWMCNT2      _IO(0xae);   /* PWM Channel Counter 2 */
volatile __uchar PWMCNT3      _IO(0xaf);   /* PWM Channel Counter 3 */
volatile __uint  PWMCNT45     _IO(0xb0);   /* PWM Channel Counter 4+5 */
volatile __uchar PWMCNT4      _IO(0xb0);   /* PWM Channel Counter 4 */
volatile __uchar PWMCNT5      _IO(0xb1);   /* PWM Channel Counter 5 */
volatile __uint  PWMCNT67     _IO(0xb2);   /* PWM Channel Counter 6+7 */
volatile __uchar PWMCNT6      _IO(0xb2);   /* PWM Channel Counter 6 */
volatile __uchar PWMCNT7      _IO(0xb3);   /* PWM Channel Counter 7 */
volatile __uint  PWMPER01     _IO(0xb4);   /* PWM Channel Period 0+1 */
volatile __uchar PWMPER0      _IO(0xb4);   /* PWM Channel Period 0 */
volatile __uchar PWMPER1      _IO(0xb5);   /* PWM Channel Period 1 */
volatile __uint  PWMPER23     _IO(0xb6);   /* PWM Channel Period 2+3 */
volatile __uchar PWMPER2      _IO(0xb6);   /* PWM Channel Period 2 */
volatile __uchar PWMPER3      _IO(0xb7);   /* PWM Channel Period 3 */
volatile __uint  PWMPER45     _IO(0xb8);   /* PWM Channel Period 4+5 */
volatile __uchar PWMPER4      _IO(0xb8);   /* PWM Channel Period 4 */
volatile __uchar PWMPER5      _IO(0xb9);   /* PWM Channel Period 5 */
volatile __uint  PWMPER67     _IO(0xba);   /* PWM Channel Period 6+7 */
volatile __uchar PWMPER6      _IO(0xba);   /* PWM Channel Period 6 */
volatile __uchar PWMPER7      _IO(0xbb);   /* PWM Channel Period 7 */
volatile __uint  PWMDTY01     _IO(0xbc);   /* PWM Channel Duty 0+1 */
volatile __uchar PWMDTY0      _IO(0xbc);   /* PWM Channel Duty 0 */
volatile __uchar PWMDTY1      _IO(0xbd);   /* PWM Channel Duty 1 */
volatile __uint  PWMDTY23     _IO(0xbe);   /* PWM Channel Duty 2+3 */
volatile __uchar PWMDTY2      _IO(0xbe);   /* PWM Channel Duty 2 */
volatile __uchar PWMDTY3      _IO(0xbf);   /* PWM Channel Duty 3 */
volatile __uint  PWMDTY45     _IO(0xc0);   /* PWM Channel Duty 4+5 */
volatile __uchar PWMDTY4      _IO(0xc0);   /* PWM Channel Duty 4 */
volatile __uchar PWMDTY5      _IO(0xc1);   /* PWM Channel Duty 5 */
volatile __uint  PWMDTY67     _IO(0xc2);   /* PWM Channel Duty 6+7 */
volatile __uchar PWMDTY6      _IO(0xc2);   /* PWM Channel Duty 6 */
volatile __uchar PWMDTY7      _IO(0xc3);   /* PWM Channel Duty 7 */
volatile __uchar PWMSDN       _IO(0xc4);   /* PWM shutdown register */

/*	SCI0 Module
 */
volatile __uint  SCI0BD       _IO(0xc8);   /* SCI 0 baud rate */
volatile __uchar SCI0BDH      _IO(0xc8);   /* SCI 0 baud rate high */
volatile __uchar SCI0BDL      _IO(0xc9);   /* SCI 0 baud rate low */
volatile __uchar SCI0CR1      _IO(0xca);   /* SCI 0 control register 1 */
volatile __uchar SCI0CR2      _IO(0xcb);   /* SCI 0 control register 2 */
volatile __uchar SCI0SR1      _IO(0xcc);   /* SCI 0 status register 1 */
volatile __uchar SCI0SR2      _IO(0xcd);   /* SCI 0 status register 2 */
volatile __uchar SCI0DRH      _IO(0xce);   /* SCI 0 data register high */
volatile __uchar SCI0DRL      _IO(0xcf);   /* SCI 0 data register low */

/*	SCI1 Module
 */
volatile __uint  SCI1BD       _IO(0xd0);   /* SCI 1 baud rate */
volatile __uchar SCI1BDH      _IO(0xd0);   /* SCI 1 baud rate high */
volatile __uchar SCI1BDL      _IO(0xd1);   /* SCI 1 baud rate low */
volatile __uchar SCI1CR1      _IO(0xd2);   /* SCI 1 control register 1 */
volatile __uchar SCI1CR2      _IO(0xd3);   /* SCI 1 control register 2 */
volatile __uchar SCI1SR1      _IO(0xd4);   /* SCI 1 status register 1 */
volatile __uchar SCI1SR2      _IO(0xd5);   /* SCI 1 status register 2 */
volatile __uchar SCI1DRH      _IO(0xd6);   /* SCI 1 data register high */
volatile __uchar SCI1DRL      _IO(0xd7);   /* SCI 1 data register low */

/*	SPI0 Module
 */
volatile __uchar SPI0CR1      _IO(0xd8);   /* SPI 0 control register 1 */
volatile __uchar SPI0CR2      _IO(0xd9);   /* SPI 0 control register 2 */
volatile __uchar SPI0BR       _IO(0xda);   /* SPI 0 baud rate register */
volatile __uchar SPI0SR       _IO(0xdb);   /* SPI 0 status register */
volatile __uchar SPI0DR       _IO(0xdd);   /* SPI 0 data register */

/*	I2C Module
 */
volatile __uchar IBAD         _IO(0xe0);   /* I2C address register */
volatile __uchar IBFD         _IO(0xe1);   /* I2C freqency divider reg */
volatile __uchar IBCR         _IO(0xe2);   /* I2C control register */
volatile __uchar IBSR         _IO(0xe3);   /* I2C status register */
volatile __uchar IBDR         _IO(0xe4);   /* I2C data register */

/*	SPI1 Module
 */
volatile __uchar SPI1CR1      _IO(0xf0);   /* SPI 1 control register 1 */
volatile __uchar SPI1CR2      _IO(0xf1);   /* SPI 1 control register 2 */
volatile __uchar SPI1BR       _IO(0xf2);   /* SPI 1 baud rate register */
volatile __uchar SPI1SR       _IO(0xf3);   /* SPI 1 status register */
volatile __uchar SPI1DR       _IO(0xf5);   /* SPI 1 data register */

/*	SPI2 Module
 */
volatile __uchar SPI2CR1      _IO(0xf8);   /* SPI 2 control register 1 */
volatile __uchar SPI2CR2      _IO(0xf9);   /* SPI 2 control register 2 */
volatile __uchar SPI2BR       _IO(0xfa);   /* SPI 2 baud rate register */
volatile __uchar SPI2SR       _IO(0xfb);   /* SPI 2 status register */
volatile __uchar SPI2DR       _IO(0xfd);   /* SPI 2 data register */

/*	Flash Control Module
 */
volatile __uchar FCLKDIV      _IO(0x100);  /* flash clock divider */
volatile __uchar FSEC         _IO(0x101);  /* flash security register */
volatile __uchar FTSTMOD      _IO(0x102);  /* flash test register */
volatile __uchar FCNFG        _IO(0x103);  /* flash configuration register */
volatile __uchar FPROT        _IO(0x104);  /* flash protection register */
volatile __uchar FSTAT        _IO(0x105);  /* flash status register */
volatile __uchar FCMD         _IO(0x106);  /* flash command register */
volatile __uint  FADDR        _IO(0x108);  /* flash address register */
volatile __uint  FDATA        _IO(0x10a);  /* flash address register */

/*	EEPROM Control Module
 */
volatile __uchar ECLKDIV      _IO(0x110);  /* eeprom clock divider */
volatile __uchar ECNFG        _IO(0x113);  /* eeprom configuration register */
volatile __uchar EPROT        _IO(0x114);  /* eeprom protection register */
volatile __uchar ESTAT        _IO(0x115);  /* eeprom status register */
volatile __uchar ECMD         _IO(0x116);  /* eeprom command register */
volatile __uint  EADDR        _IO(0x118);  /* eeprom address register */
volatile __uint  EDATA        _IO(0x11a);  /* eeprom address register */

/*	ATD1 Module
 */
volatile __uint  ATD1CTL01    _IO(0x120);  /* A/D1 control registers 0+1 */
volatile __uchar ATD1CTL0     _IO(0x120);  /* A/D1 control register 0 */
volatile __uchar ATD1CTL1     _IO(0x121);  /* A/D1 control register 1 */
volatile __uint  ATD1CTL23    _IO(0x122);  /* A/D1 control registers 2+3 */
volatile __uchar ATD1CTL2     _IO(0x122);  /* A/D1 control register 2 */
volatile __uchar ATD1CTL3     _IO(0x123);  /* A/D1 control register 3 */
volatile __uint  ATD1CTL45    _IO(0x124);  /* A/D1 control registers 4+5 */
volatile __uchar ATD1CTL4     _IO(0x124);  /* A/D1 control register 4 */
volatile __uchar ATD1CTL5     _IO(0x125);  /* A/D1 control register 5 */
volatile __uchar ATD1STAT0    _IO(0x126);  /* A/D1 status register 0 */
volatile __uchar ATD1TEST0    _IO(0x128);  /* A/D1 test register 0 */
volatile __uchar ATD1TEST1    _IO(0x129);  /* A/D1 test register 1 */
volatile __uchar ATD1STAT1    _IO(0x12b);  /* A/D1 status register 1 */
volatile __uchar ATD1DIEN     _IO(0x12d);  /* A/D1 interrupt enable */
volatile __uchar PORTAD1      _IO(0x12f);  /* port AD1 data input register */
volatile __uint  ATD1DR[8]    _IO(0x130);  /* A/D1 result */
volatile __uint  ATD1DR0      _IO(0x130);  /* A/D1 result 0 */
volatile __uint  ATD1DR1      _IO(0x132);  /* A/D1 result 1 */
volatile __uint  ATD1DR2      _IO(0x134);  /* A/D1 result 2 */
volatile __uint  ATD1DR3      _IO(0x136);  /* A/D1 result 3 */
volatile __uint  ATD1DR4      _IO(0x138);  /* A/D1 result 4 */
volatile __uint  ATD1DR5      _IO(0x13a);  /* A/D1 result 5 */
volatile __uint  ATD1DR6      _IO(0x13c);  /* A/D1 result 6 */
volatile __uint  ATD1DR7      _IO(0x13e);  /* A/D1 result 7 */

/*	CAN0 Module
 */
volatile __uchar CAN0CTL0     _IO(0x140);  /* CAN0 control register 0 */
volatile __uchar CAN0CTL1     _IO(0x141);  /* CAN0 control register 1 */
volatile __uchar CAN0BTR0     _IO(0x142);  /* CAN0 bus timing register 0 */
volatile __uchar CAN0BTR1     _IO(0x143);  /* CAN0 bus timing register 1 */
volatile __uchar CAN0RFLG     _IO(0x144);  /* CAN0 receiver flag register */
volatile __uchar CAN0RIER     _IO(0x145);  /* CAN0 receiver interrupt reg */
volatile __uchar CAN0TFLG     _IO(0x146);  /* CAN0 transmitter flag reg */
volatile __uchar CAN0TIER     _IO(0x147);  /* CAN0 transmitter control reg */
volatile __uchar CAN0TARQ     _IO(0x148);  /* CAN0 transmitter abort req. */
volatile __uchar CAN0TAAK     _IO(0x149);  /* CAN0 transmitter abort ack. */
volatile __uchar CAN0TBSEL    _IO(0x14a);  /* CAN0 transmit buffer selection */
volatile __uchar CAN0IDAC     _IO(0x14b);  /* CAN0 identifier acceptance */
volatile __uchar CAN0RXERR    _IO(0x14e);  /* CAN0 receive error counter */
volatile __uchar CAN0TXERR    _IO(0x14f);  /* CAN0 transmit error counter */
volatile __uchar CAN0IDAR0    _IO(0x150);  /* CAN0 id acceptance reg 0 */
volatile __uchar CAN0IDAR1    _IO(0x151);  /* CAN0 id acceptance reg 1 */
volatile __uchar CAN0IDAR2    _IO(0x152);  /* CAN0 id acceptance reg 2 */
volatile __uchar CAN0IDAR3    _IO(0x153);  /* CAN0 id acceptance reg 3 */
volatile __uchar CAN0IDMR0    _IO(0x154);  /* CAN0 id mask register 0 */
volatile __uchar CAN0IDMR1    _IO(0x155);  /* CAN0 id mask register 1 */
volatile __uchar CAN0IDMR2    _IO(0x156);  /* CAN0 id mask register 2 */
volatile __uchar CAN0IDMR3    _IO(0x157);  /* CAN0 id mask register 3 */
volatile __uchar CAN0IDAR4    _IO(0x158);  /* CAN0 id acceptance reg 4 */
volatile __uchar CAN0IDAR5    _IO(0x159);  /* CAN0 id acceptance reg 5 */
volatile __uchar CAN0IDAR6    _IO(0x15a);  /* CAN0 id acceptance reg 6 */
volatile __uchar CAN0IDAR7    _IO(0x15b);  /* CAN0 id acceptance reg 7 */
volatile __uchar CAN0IDMR4    _IO(0x15c);  /* CAN0 id mask register 4 */
volatile __uchar CAN0IDMR5    _IO(0x15d);  /* CAN0 id mask register 5 */
volatile __uchar CAN0IDMR6    _IO(0x15e);  /* CAN0 id mask register 6 */
volatile __uchar CAN0IDMR7    _IO(0x15f);  /* CAN0 id mask register 7 */
volatile __uchar CAN0RXFG[16] _IO(0x160);  /* CAN0 receive buffer */
volatile __uchar CAN0TXFG[16] _IO(0x170);  /* CAN0 transmit buffer */

/*	Port T Module
 */
volatile __uchar PTT          _IO(0x240);  /* port T data register */
volatile __uchar PTIT         _IO(0x241);  /* port T input register */
volatile __uchar DDRT         _IO(0x242);  /* port T data direction */
volatile __uchar RDRT         _IO(0x243);  /* port T reduce drive */
volatile __uchar PERT         _IO(0x244);  /* port T pull enable */
volatile __uchar PPST         _IO(0x245);  /* port T polarity select */

/*	Port S Module
 */
volatile __uchar PTS          _IO(0x248);  /* port S data register */
volatile __uchar PTIS         _IO(0x249);  /* port S input register */
volatile __uchar DDRS         _IO(0x24a);  /* port S data direction */
volatile __uchar RDRS         _IO(0x24b);  /* port S reduce drive */
volatile __uchar PERS         _IO(0x24c);  /* port S pull enable */
volatile __uchar PPSS         _IO(0x24d);  /* port S polarity select */
volatile __uchar WOMS         _IO(0x24e);  /* port S wired-or mode */

/*	Port M Module
 */
volatile __uchar PTM          _IO(0x250);  /* port M data register */
volatile __uchar PTIM         _IO(0x251);  /* port M input register */
volatile __uchar DDRM         _IO(0x252);  /* port M data direction */
volatile __uchar RDRM         _IO(0x253);  /* port M reduce drive */
volatile __uchar PERM         _IO(0x254);  /* port M pull enable */
volatile __uchar PPSM         _IO(0x255);  /* port M polarity select */
volatile __uchar WOMM         _IO(0x256);  /* port M wired-or mode */

// module routing re-assignment
volatile __uchar MODRR        _IO(0x257);  /* module routing register */

/*	Port P Module
 */
volatile __uchar PTP          _IO(0x258);  /* port P data register */
volatile __uchar PTIP         _IO(0x259);  /* port P input register */
volatile __uchar DDRP         _IO(0x25a);  /* port P data direction */
volatile __uchar RDRP         _IO(0x25b);  /* port P reduce drive */
volatile __uchar PERP         _IO(0x25c);  /* port P pull enable */
volatile __uchar PPSP         _IO(0x25d);  /* port P polarity select */
volatile __uchar PIEP         _IO(0x25e);  /* port P interrupt enable */
volatile __uchar PIFP         _IO(0x25f);  /* port P interrupt flag */

/*	Port H Module
 */
volatile __uchar PTH          _IO(0x260);  /* port H data register */
volatile __uchar PTIH         _IO(0x261);  /* port H input register */
volatile __uchar DDRH         _IO(0x262);  /* port H data direction */
volatile __uchar RDRH         _IO(0x263);  /* port H reduce drive */
volatile __uchar PERH         _IO(0x264);  /* port H pull enable */
volatile __uchar PPSH         _IO(0x265);  /* port H polarity select */
volatile __uchar PIEH         _IO(0x266);  /* port H interrupt enable */
volatile __uchar PIFH         _IO(0x267);  /* port H interrupt flag */

/*	Port J Module
 */
volatile __uchar PTJ          _IO(0x268);  /* port J data register */
volatile __uchar PTIJ         _IO(0x269);  /* port J input register */
volatile __uchar DDRJ         _IO(0x26a);  /* port J data direction */
volatile __uchar RDRJ         _IO(0x26b);  /* port J reduce drive */
volatile __uchar PERJ         _IO(0x26c);  /* port J pull enable */
volatile __uchar PPSJ         _IO(0x26d);  /* port J polarity select */
volatile __uchar PIEJ         _IO(0x26e);  /* port J interrupt enable */
volatile __uchar PIFJ         _IO(0x26f);  /* port J interrupt flag */

/*	CAN4 Module
 */
volatile __uchar CAN4CTL0     _IO(0x280);  /* CAN4 control register 0 */
volatile __uchar CAN4CTL1     _IO(0x281);  /* CAN4 control register 1 */
volatile __uchar CAN4BTR0     _IO(0x282);  /* CAN4 bus timing register 0 */
volatile __uchar CAN4BTR1     _IO(0x283);  /* CAN4 bus timing register 1 */
volatile __uchar CAN4RFLG     _IO(0x284);  /* CAN4 receiver flag register */
volatile __uchar CAN4RIER     _IO(0x285);  /* CAN4 receiver interrupt reg */
volatile __uchar CAN4TFLG     _IO(0x286);  /* CAN4 transmitter flag reg */
volatile __uchar CAN4TIER     _IO(0x287);  /* CAN4 transmitter control reg */
volatile __uchar CAN4TARQ     _IO(0x288);  /* CAN4 transmitter abort req. */
volatile __uchar CAN4TAAK     _IO(0x289);  /* CAN4 transmitter abort ack. */
volatile __uchar CAN4TBSEL    _IO(0x28a);  /* CAN4 transmit buffer selection */
volatile __uchar CAN4IDAC     _IO(0x28b);  /* CAN4 identifier acceptance */
volatile __uchar CAN4RXERR    _IO(0x28e);  /* CAN4 transmitter control reg */
volatile __uchar CAN4TXERR    _IO(0x28f);  /* CAN4 transmit error counter */
volatile __uchar CAN4IDAR0    _IO(0x290);  /* CAN4 id acceptance reg 0 */
volatile __uchar CAN4IDAR1    _IO(0x291);  /* CAN4 id acceptance reg 1 */
volatile __uchar CAN4IDAR2    _IO(0x292);  /* CAN4 id acceptance reg 2 */
volatile __uchar CAN4IDAR3    _IO(0x293);  /* CAN4 id acceptance reg 3 */
volatile __uchar CAN4IDMR0    _IO(0x294);  /* CAN4 id mask register 0 */
volatile __uchar CAN4IDMR1    _IO(0x295);  /* CAN4 id mask register 1 */
volatile __uchar CAN4IDMR2    _IO(0x296);  /* CAN4 id mask register 2 */
volatile __uchar CAN4IDMR3    _IO(0x297);  /* CAN4 id mask register 3 */
volatile __uchar CAN4IDAR4    _IO(0x298);  /* CAN4 id acceptance reg 4 */
volatile __uchar CAN4IDAR5    _IO(0x299);  /* CAN4 id acceptance reg 5 */
volatile __uchar CAN4IDAR6    _IO(0x29a);  /* CAN4 id acceptance reg 6 */
volatile __uchar CAN4IDAR7    _IO(0x29b);  /* CAN4 id acceptance reg 7 */
volatile __uchar CAN4IDMR4    _IO(0x29c);  /* CAN4 id mask register 4 */
volatile __uchar CAN4IDMR5    _IO(0x29d);  /* CAN4 id mask register 5 */
volatile __uchar CAN4IDMR6    _IO(0x29e);  /* CAN4 id mask register 6 */
volatile __uchar CAN4IDMR7    _IO(0x29f);  /* CAN4 id mask register 7 */
volatile __uchar CAN4RXFG[16] _IO(0x2a0);  /* CAN4 receive buffer */
volatile __uchar CAN4TXFG[16] _IO(0x2b0);  /* CAN4 transmit buffer */

#endif
