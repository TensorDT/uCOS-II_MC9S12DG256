///*********************************************************************
//
//  time.h
//
//  Time-related module header file
//
//  Target: MC9S12DG256-based board
//
//  Revision History
//    ##  dd mmm yyyy  who  description
//     1  09 Dec 2020  GPM  Initial revision
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
#include "global.h"          // data types, unit conversions, _NEAR, _FAR

//-------------------------- Type Definitions -------------------------
typedef struct {
    UINT16 year;             // year [1900, 9999]
    UINT8  month;            // month [1,12]
    UINT8  day;              // day [1,31]
    UINT8  hour;             // hour [0,23]
    UINT8  minute;           // minute [0,59]
    UINT8  second;           // second [0,59]
} TIME_ST;

// The Cosmic compiler defaults to filling bitfields from least
// significant bit to most significant bit. (C Cross Compiler User’s
// Guide for NXP HC12/HCS12, V4.8, PDF p. 97)
// Also, bitfields are packed by default.
typedef struct {
    UINT32 second  :  5;     // lsb (actually second / 2) [0,29]
    UINT32 minute  :  6;
    UINT32 hour    :  5;
    UINT32 day     :  5;
    UINT32 month   :  4;
    UINT32 year    :  7;     // msb 2-digit year [0,99]
} PACKED_TIME_ST;


//------------------------ Constant Definitions -----------------------
#define MS_PER_TMR_INT       (20)  // Timer interrupt period in millisec

//------------------------------- Macros ------------------------------
// none

//---------------------- Extern Global Variables ----------------------
// none

//------------------------ Function Prototype(s) ----------------------
_FAR void Time_Init(void);
_FAR void Time_GetTime(
    TIME_ST *pTimeSt);                   // ptr to time structure
_FAR BOOL Time_DidSetTime(
    const TIME_ST *pTimeSt);             // ptr to (new) time structure
_FAR void Time_IncrementTime(
    UINT16 incrMillisec);                // num milliseconds to increment time
_FAR BOOL Time_DidPackTime(
    const TIME_ST *pTimeSt,              // ptr to time structure
    PACKED_TIME_ST *pTimePackedSt);      // ptr to packed time structure
_FAR BOOL Time_DidUnpackTime(
    const PACKED_TIME_ST *pTimePackedSt, // ptr to packed time structure
    TIME_ST *pTimeSt);                   // ptr to (unpacked) time structure

#endif
