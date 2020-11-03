///*********************************************************************
//
//  mc9s12dg256_time.h
//
//  MC9S12DG256 processor time-related header file
//
//  Target: MC9S12DG256-based board
//
//  Revision History
//    ##  dd mmm yyyy  who  description
//     1  29 Oct 2020  GPM  Initial revision
//
//  Copyright 2020 Tensor Drilling Technologies
//
//  Tensor Drilling Technologies
//  2418 North Frazier St., Suite 100
//  Conroe, TX 77303 USA
//
//   *** PROPRIETARY INFORMATION ***
//   THIS DOCUMENT CONTAINS PROPRIETARY INFORMATION OF TENSOR DRILLING
//   TECHNOLOGIES AND MAY NOT BE USED OR DISCLOSED TO OTHERS, EXCEPT
//   WITH THE WRITTEN PERMISSION OF TENSOR DRILLING TECHNOLOGIES.
//  
//*********************************************************************

// Avoid multiple inclusions
#ifndef _TIME_H
#define _TIME_H

//--------------------------- Included Files --------------------------
#include "os_cpu.h"          // uC/OS-II file for data types

//-------------------------- Type Definitions -------------------------
// none

//------------------------ Constant Definitions -----------------------
// Hardware time definitions
#define XTAL_FREQ_HZ         ((INT32U) 4915200)       // crystal frequency (Hz)
#define OSC_CLK_FREQ_HZ      (XTAL_FREQ_HZ)           // oscillator clock freq (Hz)
#define SYS_CLK_FREQ_HZ      (OSC_CLK_FREQ_HZ)        // system clock freq (Hz)
#define BUS_CLK_FREQ_HZ      (SYS_CLK_FREQ_HZ / 2)    // bus clock freq (Hz)

// The time prescaler MUST be set to the value below
#define TSCR2_PRESCALER_BITS (0x2)

#if   (TSCR2_PRESCALER_BITS==0x0)
#define BUS_CLK_DIVISOR      (  1)
#elif (TSCR2_PRESCALER_BITS==0x1)
#define BUS_CLK_DIVISOR      (  2)
#elif (TSCR2_PRESCALER_BITS==0x2)
#define BUS_CLK_DIVISOR      (  4)
#elif (TSCR2_PRESCALER_BITS==0x3)
#define BUS_CLK_DIVISOR      (  8)
#elif (TSCR2_PRESCALER_BITS==0x4)
#define BUS_CLK_DIVISOR      ( 16)
#elif (TSCR2_PRESCALER_BITS==0x5)
#define BUS_CLK_DIVISOR      ( 32)
#elif (TSCR2_PRESCALER_BITS==0x6)
#define BUS_CLK_DIVISOR      ( 64)
#elif (TSCR2_PRESCALER_BITS==0x7)
#define BUS_CLK_DIVISOR      (128)
#else
#warning "TSCR2 PRESCALER INVALID"
#endif

// Calculate the timer clock frequency (ticks/sec)
#define TMR_CLK_FREQ_HZ      (BUS_CLK_FREQ_HZ / BUS_CLK_DIVISOR)

//------------------------------- Macros ------------------------------
// none

//---------------------- Extern Global Variables ----------------------
// none

//------------------------ Function Prototype(s) ----------------------
// none

#endif
