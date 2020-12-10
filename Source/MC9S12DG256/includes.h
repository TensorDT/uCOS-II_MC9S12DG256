//*********************************************************************
//
//  File name:  includes.h
//
//  Purpose:    uCOS-II meta header file
//
//  Target:     MC9S12DG256-based board
//
//  Revisions:
//   ##  dd mmm yyyy  who  description
//    1  28 Oct 2020  GPM  Initial revision.
//
//  Notes:
//
//  Tensor Drilling Technologies
//  2418 North Frazier St., Suite 100
//  Conroe, TX 77303
//*********************************************************************

// Avoid multiple inclusions.
#ifndef _includes_h
#define _includes_h


//--------------------------- Included Files --------------------------
#include "mc9s12dg256_banking.h"

// ---------------- STD INCLUDE FILES -----------------
#include  <string.h>                                            
#include  <stddef.h>

// ---------------- CPU INCLUDE FILES -----------------
#include "iosdg256.h"

// -------------- MICRIUM INCLUDE FILES ---------------
#include "os_cpu.h"
#include "os_cfg.h"
#include "ucos_ii.h"

//-------------------------- Type Definitions -------------------------
// none

//------------------------ Constant Definitions -----------------------
// none

//------------------------------- Macros ------------------------------
#define DISABLE_INTS()       _asm("SEI")    // disable interrupts
#define ENABLE_INTS()        _asm("CLI")    // enable interrupts


//-------------------------- Module Variables -------------------------
// none

//------------------------ Function Prototype(s) ----------------------

#endif   // end of includes.h
