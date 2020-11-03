//*********************************************************************
//
//  File name:  vectors.c
//
//  Purpose:    MC9S12DG256 vector table module
//
//  Target:     CPU 2.0
//
//  Revisions:
//   ##  dd mmm yyyy  who  description
//    1  28 Oct 2020  GPM  Initial revision.
//
//  Notes:
//  (c) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
//  (p) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
//
//  Tensor Drilling Technologies
//  2418 North Frazier St., Suite 100
//  Conroe, TX 77303
//*********************************************************************

//--------------------------- Included Files --------------------------
#include "sw_traps.h"                  /* SoftwareTrapXX */

//-------------------------- Type Definitions -------------------------
// none

//------------------------ Constant Definitions -----------------------
// none

//------------------------------- Macros ------------------------------
// none

//------------------------ Function Prototype(s) ----------------------
extern void _NEAR _reset(void);              // from startup.s
extern void _NEAR OSTickISR(void);           // OS Time Tick Routine
extern void _NEAR OSCtxSw(void);             // OS Context Switch Routine

//-------------------------- Module Variables -------------------------
// Vector table is expected to be linked to start at 0xFFF80
void (* const _vect[])() = 
{
	SoftwareTrap63, // Isr_Trap,	//	0xFF80  INT80 reserved
  	SoftwareTrap62,	//	0xFF82  INT82 reserved
  	SoftwareTrap61,	//	0xFF84  INT84 reserved
  	SoftwareTrap60,	//	0xFF86  INT86 reserved
  	SoftwareTrap59,	//	0xFF88  INT88 reserved
  	SoftwareTrap58,	//	0xFF8A  INT8A reserved
  	SoftwareTrap57,	//	0xFF8C  PWM Emergency Shutdown
  	SoftwareTrap56,	//	0xFF8E  Port P Interrupt
  	SoftwareTrap55,	//	0xFF90  MSCAN 4 transmit
  	SoftwareTrap54,	//	0xFF92  MSCAN 4 receive
  	SoftwareTrap53,	//	0xFF94  MSCAN 4 errors
  	SoftwareTrap52,	//	0xFF96  MSCAN 4 wake-up
  	SoftwareTrap51,	//	0xFF98  MSCAN 3 transmit
  	SoftwareTrap50,	//	0xFF9A  MSCAN 3 receive
  	SoftwareTrap49,	//	0xFF9C  MSCAN 3 errors
  	SoftwareTrap48,	//	0xFF9E  MSCAN 3 wake-up
  	SoftwareTrap47,	//	0xFFA0  MSCAN 2 transmit
  	SoftwareTrap46,	//	0xFFA2  MSCAN 2 receive
  	SoftwareTrap45,	//	0xFFA4  MSCAN 2 errors
  	SoftwareTrap44,	//	0xFFA6  MSCAN 2 wake-up
  	SoftwareTrap43,	//	0xFFA8  MSCAN 1 transmit
  	SoftwareTrap42,	//	0xFFAA  MSCAN 1 receive
  	SoftwareTrap41,	//	0xFFAC  MSCAN 1 errors
  	SoftwareTrap40,	//	0xFFAE  MSCAN 1 wake-up
  	SoftwareTrap39,	//	0xFFB0  MSCAN 0 transmit
  	SoftwareTrap38,	//	0xFFB2  MSCAN 0 receive
  	SoftwareTrap37,	//	0xFFB4  MSCAN 0 errors
  	SoftwareTrap36,	//	0xFFB6  MSCAN 0 wake-up
  	SoftwareTrap35,	//	0xFFB8  FLASH
  	SoftwareTrap34,	//	0xFFBA  EEPROM
  	SoftwareTrap33,	//	0xFFBC  SPI2
  	SoftwareTrap32,	//	0xFFBE  SPI1
  	SoftwareTrap31,	//	0xFFC0  IIC Bus
  	SoftwareTrap30,	//	0xFFC2  DLC
  	SoftwareTrap29,	//	0xFFC4  SCME
  	SoftwareTrap28,	//	0xFFC6  CRG lock
  	SoftwareTrap27,	//	0xFFC8  Pulse Accumulator B Overflow
  	SoftwareTrap26,	//	0xFFCA  Modulus Down Counter underflow
  	SoftwareTrap25,	//	0xFFCC  Port H
  	SoftwareTrap24,	//	0xFFCE  Port J
  	SoftwareTrap23,	//	0xFFD0  ATD1
  	SoftwareTrap22,	//	0xFFD2  ATD0
  	SoftwareTrap21, //	0xFFD4  SCI 1
  	SoftwareTrap20,	//	0xFFD6  SCI 0
  	SoftwareTrap19,	//	0xFFD8  SPI0
  	SoftwareTrap18,	//	0xFFDA  Pulse accumulator input edge
  	SoftwareTrap17,	//	0xFFDC  Pulse accumulator A overflow
  	SoftwareTrap16,	//	0xFFDE  Timer overflow
  	OSTickISR,	    //	0xFFE0  Timer channel 7
  	SoftwareTrap14,	//	0xFFE2  Timer channel 6
  	SoftwareTrap13,	//	0xFFE4  Timer channel 5
  	SoftwareTrap12,	//	0xFFE6  Timer channel 4
  	SoftwareTrap11,	//	0xFFE8  Timer channel 3
  	SoftwareTrap10,	//	0xFFEA  Timer channel 2
  	SoftwareTrap09,	//	0xFFEC  Timer channel 1
  	SoftwareTrap08,	//	0xFFEE  Timer channel 0
  	SoftwareTrap07,	//	0xFFF0  Real Time Interrupt
  	SoftwareTrap06,	//	0xFFF2  IRQ
  	SoftwareTrap05,	//	0xFFF4  XIRQ
  	OSCtxSw,        //	0xFFF6  SWI
  	SoftwareTrap03,	//	0xFFF8  Unimplemented instruction trap (illegal instruction)
  	SoftwareTrap02,	//	0xFFFA  COP failure reset
  	SoftwareTrap01,	//	0xFFFC  Clock Monitor fail reset
  	(void *)0xF800, //  0xFFFE  reset
};

//------------------------------ Functions ----------------------------
// none

// End of vectors.c
