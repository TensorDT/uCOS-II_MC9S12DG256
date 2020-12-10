//*********************************************************************
//
//  File name:  mc9s12dg256_banking.h
//
//  Purpose:    MC9S12DG256 processor banking header file
//              for use with the Cosmic compiler.
//
//  Target:     MC9S12DG256-based board
//
//  Revisions:
//   ##  dd mmm yyyy  who  description
//    1  29 Oct 2020  GPM  Initial revision.
//
//  IMPPORTANT NOTE:
//  This header file MUST be included in ALL C modules and
//  MUST be the first header file!
//
//  Tensor Drilling Technologies
//  2418 North Frazier St., Suite 100
//  Conroe, TX 77303
//*********************************************************************

// Avoid multiple inclusions.
#ifndef _banking_h
#define _banking_h

#define BANKED     1

// The @near and @far type modifiers are important for MC9S12 code when
// memory banking is used so that the correct method is used to invoke
// the function and return from the function (i.e., call/rtc or jsr/rts).
// See FreeScale Semiconductor CPU12 Reference Manual, Rev. 4.0 pp. 339-340
// for more information.
#if defined BANKED
#define _NEAR      @near            // for code in unbanked flash
#define _FAR       @far             // for code in banked flash
#define _INTERRUPT @interrupt       // for Interrupt Service Routines
#define _EEPROM    @eeprom          // for data in EEPROM
#define _DIR       @dir             // for variables in RAM zero page
#else
#define _NEAR
#define _FAR
#define _INTERRUPT
#define _EEPROM
#define _DIR
#endif

//--------------------------- Included Files --------------------------
// none

//-------------------------- Type Definitions -------------------------
// none

//------------------------ Constant Definitions -----------------------
// none

//------------------------------- Macros ------------------------------
// none

//-------------------------- Module Variables -------------------------
// none

//------------------------ Function Prototype(s) ----------------------

#endif   // end of banking.h
