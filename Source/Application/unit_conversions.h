//*********************************************************************
//
//  File name:  unit_conversions.h
//
//  Purpose:    Unit conversion constants.
//
//  Target:     MC9S12DG256-based board
//
//  Revisions:
//   ##  dd mmm yyyy  who  description
//    1  09 Dec 2020  GPM  Initial revision.
//
//
//  Notes:
//  (c) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
//  (p) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
//
//  Tensor Drilling Technologies
//  2418 North Frazier St., Suite 100
//  Conroe, TX 77303
//
//  *** PROPRIETARY INFORMATION ***
//  THIS DOCUMENT CONTAINS PROPRIETARY INFORMATION OF TENSOR DRILLING
//  TECHNOLOGIES AND MAY NOT BE USED OR DISCLOSED TO OTHERS, EXCEPT
//  WITH THE WRITTEN PERMISSION OF TENSOR DRILLING TECHNOLOGIES.
//  
//********************************************************************

// Avoid multiple inclusions
#ifndef _unit_conversions_h
#define _unit_conversions_h

//--------------------------- Included Files --------------------------
// none

//-------------------------- Type Definitions -------------------------
// none

//------------------------ Constant Definitions -----------------------
#define US_PER_MS            (1000)    // microseconds per millisecond
#define MS_PER_SEC           (1000)    // milliseconds per second
#define US_PER_SEC           (USEC_PER_MS * MS_PER_SEC)
#define SEC_PER_MIN          (60)
#define MIN_PER_HR           (60)
#define HR_PER_DAY           (24)
#define MONTHS_PER_YEAR      (12)


//------------------------------- Macros ------------------------------
// none

//---------------------- Extern Global Variables ----------------------
// none

//------------------------ Function Prototype(s) ----------------------
// not applicable


#endif