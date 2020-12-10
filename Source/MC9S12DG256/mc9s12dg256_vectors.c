//*********************************************************************
//
//  File name:  mc9s12dg256_vectors.c
//
//  Purpose:    MC9S12DG256 vector table module
//
//  Target:     MC9S12DG256-based board
//
//  Revisions:
//   ##  dd mmm yyyy  who  description
//    1  28 Oct 2020  GPM  Initial revision.
//
//  Notes:
//    IMPORTANT!!!
//    DO NOT modify this file! The jump table in
//    mc9s12dg256_jump_table.c is where all vector-related
//    modifications should be implemented.
// 
//  (c) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
//  (p) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
//
//  Tensor Drilling Technologies
//  2418 North Frazier St., Suite 100
//  Conroe, TX 77303
//*********************************************************************

//--------------------------- Included Files --------------------------
#include "mc9s12dg256_banking.h"

//-------------------------- Type Definitions -------------------------
// none

//------------------------ Constant Definitions -----------------------
// Address of the start of the jump table
// NOTE: This *MUST* agree with the start of the jump table as
//       defined in the linker file!
#define ADDR_JUMP_TABLE      (0xF500)

//------------------------------- Macros ------------------------------
// none

//------------------------ Function Prototype(s) ----------------------
extern _NEAR void _reset(void);        // from mc9s12dg256_startup.s

//-------------------------- Module Variables -------------------------
// Vector table is expected to be linked to start at 0xFFF80
void (* const _Vect[])() = 
{
	(void *)(ADDR_JUMP_TABLE+0x00),    // 0XFF80  INT80 reserved
  	(void *)(ADDR_JUMP_TABLE+0x03),    // 0XFF82  INT82 reserved
  	(void *)(ADDR_JUMP_TABLE+0x06),    // 0XFF84  INT84 reserved
  	(void *)(ADDR_JUMP_TABLE+0x09),    // 0XFF86  INT86 reserved
  	(void *)(ADDR_JUMP_TABLE+0x0C),    // 0XFF88  INT88 reserved
  	(void *)(ADDR_JUMP_TABLE+0x0F),    // 0XFF8A  INT8A reserved
  	(void *)(ADDR_JUMP_TABLE+0x12),    // 0XFF8C  PWM Emergency Shutdown
  	(void *)(ADDR_JUMP_TABLE+0x15),    // 0XFF8E  Port P Interrupt
  	(void *)(ADDR_JUMP_TABLE+0x18),    // 0XFF90  MSCAN 4 transmit
  	(void *)(ADDR_JUMP_TABLE+0x1B),    // 0XFF92  MSCAN 4 receive
  	(void *)(ADDR_JUMP_TABLE+0x1E),    // 0XFF94  MSCAN 4 errors
  	(void *)(ADDR_JUMP_TABLE+0x21),    // 0XFF96  MSCAN 4 wake-up
  	(void *)(ADDR_JUMP_TABLE+0x24),    // 0XFF98  MSCAN 3 transmit
  	(void *)(ADDR_JUMP_TABLE+0x27),    // 0XFF9A  MSCAN 3 receive
  	(void *)(ADDR_JUMP_TABLE+0x2A),    // 0XFF9C  MSCAN 3 errors
  	(void *)(ADDR_JUMP_TABLE+0x2D),    // 0XFF9E  MSCAN 3 wake-up
  	(void *)(ADDR_JUMP_TABLE+0x30),    // 0XFFA0  MSCAN 2 transmit
  	(void *)(ADDR_JUMP_TABLE+0x33),    // 0XFFA2  MSCAN 2 receive
  	(void *)(ADDR_JUMP_TABLE+0x36),    // 0XFFA4  MSCAN 2 errors
  	(void *)(ADDR_JUMP_TABLE+0x39),    // 0XFFA6  MSCAN 2 wake-up
  	(void *)(ADDR_JUMP_TABLE+0x3C),    // 0XFFA8  MSCAN 1 transmit
  	(void *)(ADDR_JUMP_TABLE+0x3F),    // 0XFFAA  MSCAN 1 receive
  	(void *)(ADDR_JUMP_TABLE+0x42),    // 0XFFAC  MSCAN 1 errors
  	(void *)(ADDR_JUMP_TABLE+0x45),    // 0XFFAE  MSCAN 1 wake-up
  	(void *)(ADDR_JUMP_TABLE+0x48),    // 0XFFB0  MSCAN 0 transmit
  	(void *)(ADDR_JUMP_TABLE+0x4B),    // 0XFFB2  MSCAN 0 receive
  	(void *)(ADDR_JUMP_TABLE+0x4E),    // 0XFFB4  MSCAN 0 errors
  	(void *)(ADDR_JUMP_TABLE+0x51),    // 0XFFB6  MSCAN 0 wake-up
  	(void *)(ADDR_JUMP_TABLE+0x54),    // 0XFFB8  FLASH
  	(void *)(ADDR_JUMP_TABLE+0x57),    // 0XFFBA  EEPROM
  	(void *)(ADDR_JUMP_TABLE+0x5A),    // 0XFFBC  SPI2
  	(void *)(ADDR_JUMP_TABLE+0x5D),    // 0XFFBE  SPI1
  	(void *)(ADDR_JUMP_TABLE+0x60),    // 0XFFC0  IIC Bus
  	(void *)(ADDR_JUMP_TABLE+0x63),    // 0XFFC2  DLC
  	(void *)(ADDR_JUMP_TABLE+0x66),    // 0XFFC4  SCME
  	(void *)(ADDR_JUMP_TABLE+0x69),    // 0XFFC6  CRG lock
  	(void *)(ADDR_JUMP_TABLE+0x6C),    // 0XFFC8  Pulse Accumulator B Overflow
  	(void *)(ADDR_JUMP_TABLE+0x6F),    // 0XFFCA  Modulus Down Counter underflow
  	(void *)(ADDR_JUMP_TABLE+0x72),    // 0XFFCC  Port H
  	(void *)(ADDR_JUMP_TABLE+0x75),    // 0XFFCE  Port J
  	(void *)(ADDR_JUMP_TABLE+0x78),    // 0XFFD0  ATD1
  	(void *)(ADDR_JUMP_TABLE+0x7B),    // 0XFFD2  ATD0
  	(void *)(ADDR_JUMP_TABLE+0x7E),    // 0XFFD4  SCI 1
  	(void *)(ADDR_JUMP_TABLE+0x81),    // 0XFFD6  SCI 0
  	(void *)(ADDR_JUMP_TABLE+0x84),    // 0XFFD8  SPI0
  	(void *)(ADDR_JUMP_TABLE+0x87),    // 0XFFDA  Pulse accumulator input edge
  	(void *)(ADDR_JUMP_TABLE+0x8A),    // 0XFFDC  Pulse accumulator A overflow
  	(void *)(ADDR_JUMP_TABLE+0x8D),    // 0XFFDE  Timer overflow
  	(void *)(ADDR_JUMP_TABLE+0x90),    // 0XFFE0  Timer channel 7
  	(void *)(ADDR_JUMP_TABLE+0x93),    // 0XFFE2  Timer channel 6
  	(void *)(ADDR_JUMP_TABLE+0x96),    // 0XFFE4  Timer channel 5
  	(void *)(ADDR_JUMP_TABLE+0x99),    // 0XFFE6  Timer channel 4
  	(void *)(ADDR_JUMP_TABLE+0x9C),    // 0XFFE8  Timer channel 3
  	(void *)(ADDR_JUMP_TABLE+0x9F),    // 0XFFEA  Timer channel 2
  	(void *)(ADDR_JUMP_TABLE+0xA2),    // 0XFFEC  Timer channel 1
  	(void *)(ADDR_JUMP_TABLE+0xA5),    // 0XFFEE  Timer channel 0
  	(void *)(ADDR_JUMP_TABLE+0xA8),    // 0XFFF0  Real Time Interrupt
  	(void *)(ADDR_JUMP_TABLE+0xAB),    // 0XFFF2  IRQ
  	(void *)(ADDR_JUMP_TABLE+0xAE),    // 0XFFF4  XIRQ
  	(void *)(ADDR_JUMP_TABLE+0xB1),    // 0XFFF6  SWI
  	(void *)(ADDR_JUMP_TABLE+0xB4),    // 0XFFF8  Unimplemented instruction trap (illegal instruction)
  	(void *)(ADDR_JUMP_TABLE+0xB7),    // 0XFFFA  COP failure reset
  	(void *)(ADDR_JUMP_TABLE+0xBA),    // 0XFFFC  Clock Monitor fail reset
  	_reset                             // 0xFFFE  reset
};

//------------------------------ Functions ----------------------------
// none

// End of mc9s12dg256_vectors.c
