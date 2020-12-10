//*********************************************************************
//
//  File name:  mc9s12dg256_jump_table.c
//
//  Purpose:    MC9S12DG256 vector jump table module
//              Note: A jump table is necessary since the vector
//                    table is in the bootloader memory area
//                    and the bootloader is (normally) not
//                    reprogrammed when firmware is loaded.
//
//  Target:     MC9S12DG256-based board
//
//  Revisions:
//   ##  dd mmm yyyy  who  description
//    1  04 Dec 2020  GPM  Initial revision. Copied from Translator
//                         board firmware so we have the entire
//                         vector table.
//
//  Notes:
//    IMPORTANT!!!
//      This module *MUST* be located at physical address 0xFF400
//      (logical address 0xF400) so that it agrees with the (new)
//      vector table.
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
#include "software_traps.h"

//-------------------------- Type Definitions -------------------------
// none

//------------------------ Constant Definitions -----------------------
// none

//------------------------------- Macros ------------------------------
// none

//------------------------ Function Prototype(s) ----------------------
extern _NEAR void OSTickISR(void);           // OS Time Tick Routine
extern _NEAR void OSCtxSw(void);             // OS Context Switch Routine

//-------------------------- Module Variables -------------------------

//------------------------------ Functions ----------------------------
//*********************************************************************
//  JUMP_TABLE
//  This is a listing of jump instructions in assembly language to
//  jump to the appropriate interrupt service routines.
//
//  All unused interrupt service routines should be mapped to a trap
//  function.
//
//  ASSUMPTION(S):
//  * The vector table will map the interrupt vectors to this location.
//  * The location of this function is set in the linker file to be
//    in unbanked memory. The location is currently 0x0FF400.
//*********************************************************************
void JUMP_TABLE(void) 
{
    // Recall that C-language functions, when referenced in assembly
	// language, must be prefixed with an underscore.
#pragma asm
    xref  _SoftwareTrap63, _SoftwareTrap62, _SoftwareTrap61, _SoftwareTrap60
    xref  _SoftwareTrap59, _SoftwareTrap58, _SoftwareTrap57, _SoftwareTrap56
    xref  _SoftwareTrap55, _SoftwareTrap54, _SoftwareTrap53, _SoftwareTrap52
    xref  _SoftwareTrap51, _SoftwareTrap50, _SoftwareTrap49, _SoftwareTrap48
    xref  _SoftwareTrap47, _SoftwareTrap46, _SoftwareTrap45, _SoftwareTrap44
    xref  _SoftwareTrap43, _SoftwareTrap42, _SoftwareTrap41, _SoftwareTrap40
    xref  _SoftwareTrap39, _SoftwareTrap38, _SoftwareTrap37, _SoftwareTrap36
    xref  _SoftwareTrap35, _SoftwareTrap34, _SoftwareTrap33, _SoftwareTrap32
    xref  _SoftwareTrap31, _SoftwareTrap30, _SoftwareTrap29, _SoftwareTrap28
    xref  _SoftwareTrap27, _SoftwareTrap26, _SoftwareTrap25, _SoftwareTrap24
    xref  _SoftwareTrap23, _SoftwareTrap22, _SoftwareTrap21, _SoftwareTrap20
    xref  _SoftwareTrap19, _SoftwareTrap18, _SoftwareTrap17, _SoftwareTrap16
    xref  _SoftwareTrap15, _SoftwareTrap14, _SoftwareTrap13, _SoftwareTrap12
    xref  _SoftwareTrap11, _SoftwareTrap10, _SoftwareTrap09, _SoftwareTrap08
    xref  _SoftwareTrap07, _SoftwareTrap06, _SoftwareTrap05, _SoftwareTrap04
    xref  _SoftwareTrap03, _SoftwareTrap02, _SoftwareTrap01
    xref  _OSTickISR, _OSCtxSw

    jmp   _SoftwareTrap63    //  0xFF400  INT80 reserved
    jmp   _SoftwareTrap62    //  0xFF403 INT82 reserved
    jmp   _SoftwareTrap61    //  0xFF406 INT84 reserved
    jmp   _SoftwareTrap60    //  0xFF409 INT86 reserved
    jmp   _SoftwareTrap59    //  0xFF40C INT88 reserved
    jmp   _SoftwareTrap58    //  0xFF40F INT8A reserved
    jmp   _SoftwareTrap57    //  0xFF412 PWM Emergency Shutdown
    jmp   _SoftwareTrap56    //  0xFF415 Port P Interrupt
    jmp   _SoftwareTrap55    //  0xFF418 MSCAN 4 transmit
    jmp   _SoftwareTrap54    //  0xFF41B MSCAN 4 receive
    jmp   _SoftwareTrap53    //  0xFF41E MSCAN 4 errors
    jmp   _SoftwareTrap52    //  0xFF421 MSCAN 4 wake-up
    jmp   _SoftwareTrap51    //  0xFF424 MSCAN 3 transmit
    jmp   _SoftwareTrap50    //  0xFF427 MSCAN 3 receive
    jmp   _SoftwareTrap49    //  0xFF42A MSCAN 3 errors
    jmp   _SoftwareTrap48    //  0xFF42D MSCAN 3 wake-up
    jmp   _SoftwareTrap47    //  0xFF430 MSCAN 2 transmit
    jmp   _SoftwareTrap46    //  0xFF433 MSCAN 2 receive
    jmp   _SoftwareTrap45    //  0xFF436 MSCAN 2 errors
    jmp   _SoftwareTrap44    //  0xFF439 MSCAN 2 wake-up
    jmp   _SoftwareTrap43    //  0xFF43C MSCAN 1 transmit
    jmp   _SoftwareTrap42    //  0xFF43F MSCAN 1 receive
    jmp   _SoftwareTrap41    //  0xFF442 MSCAN 1 errors
    jmp   _SoftwareTrap40    //  0xFF445 MSCAN 1 wake-up
    jmp   _SoftwareTrap39    //  0xFF448 MSCAN 0 transmit
    jmp   _SoftwareTrap38    //  0xFF44B MSCAN 0 receive
    jmp   _SoftwareTrap37    //  0xFF44E MSCAN 0 errors
    jmp   _SoftwareTrap36    //  0xFF451 MSCAN 0 wake-up
    jmp   _SoftwareTrap35    //  0xFF454 FLASH
    jmp   _SoftwareTrap34    //  0xFF457 EEPROM
    jmp   _SoftwareTrap33    //  0xFF45A SPI2
    jmp   _SoftwareTrap32    //  0xFF45D SPI1
    jmp   _SoftwareTrap31    //  0xFF460 IIC Bus
    jmp   _SoftwareTrap30    //  0xFF463 DLC
    jmp   _SoftwareTrap29    //  0xFF466 SCME
    jmp   _SoftwareTrap28    //  0xFF469 CRG lock
    jmp   _SoftwareTrap27    //  0xFF46C Pulse Accumulator B Overflow
    jmp   _SoftwareTrap26    //  0xFF46F Modulus Down Counter underflow
    jmp   _SoftwareTrap25    //  0xFF472 Port H
    jmp   _SoftwareTrap24    //  0xFF475 Port J
    jmp   _SoftwareTrap23    //  0xFF478 ATD1
    jmp   _SoftwareTrap22    //  0xFF47B ATD0
    jmp   _SoftwareTrap21    //  0xFF47E SCI 1
    jmp   _SoftwareTrap20    //  0xFF481 SCI 0
    jmp   _SoftwareTrap19    //  0xFF484 SPI0
    jmp   _SoftwareTrap18    //  0xFF487 Pulse accumulator input edge
    jmp   _SoftwareTrap17    //  0xFF48A Pulse accumulator A overflow
    jmp   _SoftwareTrap16    //  0xFF48D Timer overflow
    jmp   _OSTickISR         //  0xFF490 Timer channel 7
    jmp   _SoftwareTrap14    //  0xFF493 Timer channel 6
    jmp   _SoftwareTrap13    //  0xFF496 Timer channel 5
    jmp   _SoftwareTrap12    //  0xFF499 Timer channel 4
    jmp   _SoftwareTrap11    //  0xFF49C Timer channel 3
    jmp   _SoftwareTrap10    //  0xFF49F Timer channel 2
    jmp   _SoftwareTrap09    //  0xFF4A2 Timer channel 1
    jmp   _SoftwareTrap08    //  0xFF4A5 Timer channel 0
    jmp   _SoftwareTrap07    //  0xFF4A8 Real Time Interrupt
    jmp   _SoftwareTrap06    //  0xFF4AB IRQ
    jmp   _SoftwareTrap05    //  0xFF4AE XIRQ
    jmp   _OSCtxSw           //  0xFF4B1 SWI
    jmp   _SoftwareTrap03    //  0xFF4B4 Unimplemented instruction trap (illegal instruction)
    jmp   _SoftwareTrap02    //  0xFF4B7 COP failure reset
    jmp   _SoftwareTrap01    //  0xFF4BA Clock Monitor fail reset
#pragma endasm
}
