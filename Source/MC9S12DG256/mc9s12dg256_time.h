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
#ifndef _time_h
#define _time_h

//--------------------------- Included Files --------------------------
#include "os_cpu.h"            // uC/OS-II file for data types
#include "iosdg256.h"          // register addresses and bit definitions
#include "unit_conversions.h"  // unit conversions (time)

//-------------------------- Type Definitions -------------------------
// none

//------------------------ Constant Definitions -----------------------
// Hardware time definitions
#define XTAL_FREQ_HZ         ((INT32U) 4915200)       // crystal frequency (Hz)
#define OSC_CLK_FREQ_HZ      (XTAL_FREQ_HZ)           // oscillator clock freq (Hz)
#define SYS_CLK_FREQ_HZ      (OSC_CLK_FREQ_HZ)        // system clock freq (Hz)
#define BUS_CLK_FREQ_HZ      (SYS_CLK_FREQ_HZ / 2)    // bus clock freq (Hz)

// The time prescaler (TSCR2 register) MUST be set to the value below
#define TSCR2_PRESCALER_BITS (TMR_PRESCALE_FCTR_2)

#if   (TSCR2_PRESCALER_BITS==TMR_PRESCALE_FCTR_1)
#define BUS_CLK_DIVISOR      (  1)
#elif (TSCR2_PRESCALER_BITS==TMR_PRESCALE_FCTR_2)
#define BUS_CLK_DIVISOR      (  2)
#elif (TSCR2_PRESCALER_BITS==TMR_PRESCALE_FCTR_4)
#define BUS_CLK_DIVISOR      (  4)
#elif (TSCR2_PRESCALER_BITS==TMR_PRESCALE_FCTR_8)
#define BUS_CLK_DIVISOR      (  8)
#elif (TSCR2_PRESCALER_BITS==TMR_PRESCALE_FCTR_16)
#define BUS_CLK_DIVISOR      ( 16)
#elif (TSCR2_PRESCALER_BITS==TMR_PRESCALE_FCTR_32)
#define BUS_CLK_DIVISOR      ( 32)
#elif (TSCR2_PRESCALER_BITS==TMR_PRESCALE_FCTR_64)
#define BUS_CLK_DIVISOR      ( 64)
#elif (TSCR2_PRESCALER_BITS==TMR_PRESCALE_FCTR_128)
#define BUS_CLK_DIVISOR      (128)
#else
#warning "TSCR2 PRESCALER INVALID"
#endif

// Calculate the timer clock frequency (counts/sec)
#define TMR_CLK_FREQ_HZ      (BUS_CLK_FREQ_HZ / BUS_CLK_DIVISOR)

// IMPORTANT DISTINCTION!!! ---------------------------------------------
//
// A timer TICK is one increment of the timer counter (TCNT). The
// period depends on the oscillator frequency and timer prescaler.
//
// A timer INT is one timer interrupt. The period (in milliseconds)
// is defined by MS_PER_TMR_INT.
//
// ----------------------------------------------------------------------
#define TMR_TICKS_PER_MS    (TMR_CLK_FREQ_HZ / MS_PER_SEC)
#define MS_PER_TMR_INT       (20)  // Timer interrupt period in millisec
#define TMR_TICKS_PER_TMR_INT                                          \
                             (TMR_TICKS_PER_MS * MS_PER_TMR_INT)

//------------------------------- Macros ------------------------------
// Convert time (microsec) into the equivalent number of timer ticks
// (rounded up).
#define CNVRT_US_TO_TMR_TICKS(t_us)                                    \
                  ((UINT16)ceil((TMR_TICKS_PER_MS * t_us) / US_PER_MS))

// Convert milliseconds to timer ticks (rounded up)
#define CNVRT_MS_TO_TMR_TICKS(t_ms)                                    \
                                ((UINT16)ceil(TMR_TICKS_PER_MS * t_ms))

//---------------------- Extern Global Variables ----------------------
// none

//------------------------ Function Prototype(s) ----------------------
// none

#endif
