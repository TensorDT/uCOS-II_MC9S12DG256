//*********************************************************************
//
//  File name:  mc9s12dg256_banking.h
//
//  Purpose:    MC9S12DG256 processor banking header file
//              for use with the Cosmic compiler.
//
//  Target:     CPU 2.0
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
#define _NEAR      @near
#define _FAR       @far
#define _INTERRUPT @interrupt
#else
#define _NEAR
#define _FAR
#define _INTERRUPT
#endif

//--------------------------- Included Files --------------------------
// none

// ---------------- CPU INCLUDE FILES -----------------
// none

// -------------- MICRIUM INCLUDE FILES ---------------
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
