///*********************************************************************
//
//  time.c
//
//  Time-related module.
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

//--------------------------- Included Files --------------------------
#include "global.h"          // data types, unit conversions, _NEAR, _FAR
#include "time.h"
#include "includes.h"        // DISABLE_INTS, ENABLE_INTS

//-------------------------- Type Definitions -------------------------
// none

//------------------------ Constant Definitions -----------------------
// none

//------------------------------- Macros ------------------------------
// none

//-------------------------  Module Variables -------------------------
static TIME_ST TimeSt;            // current time structure
static UINT16 Millisec;           // millisecond [0,999]

//------------------------------ Functions ----------------------------
//*********************************************************************
// isLeapYear
// This function determines if the passed 4-digit year is a leap year
// or not.
// Returns:
//   TRUE   if the year is a leap year
//   FALSE  otherwise
//*********************************************************************
_FAR static BOOL isLeapYear(
    UINT16 year)                  // 4-digit year
{
    BOOL isLeapYear;

    // A year is a leap year if it is:
    //  * divisible by 4 but not by 100
    //    -OR-
    //  * divisible by 400
    isLeapYear = (BOOL)
        (((year % 4 == 0) && (year % 100 != 0))
                ||
         (year % 400 == 0));

    return(isLeapYear);
}

//*********************************************************************
// getDaysInMonth
// This function returns the number of days in the specified month for
// the specified year.
// Returns:
//   UINT8 [1,31] if the month and year are valid
//   UINT8 0      if the month is invalid
//*********************************************************************
_FAR static UINT8 getDaysInMonth(
    UINT8 month,                  // month
    UINT16 year)                  // year (4-digit)
{
    // Number of days in the month (non-leap year)
    static const UINT8 daysInMonth[MONTHS_PER_YEAR + 1] =
        {0, // dummy value since months are 1-based but array is 0-based
     // Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
         31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    UINT8   numDaysInMonth;

#define JANUARY   ( 1)
#define FEBRUARY  ( 2)
#define DECEMBER  (12)

    if ((month >= JANUARY) && (month <= DECEMBER)) {
        numDaysInMonth = daysInMonth[month];
        if ((month == FEBRUARY) && (isLeapYear(year))) {
            numDaysInMonth++;
        }
    }
    else {
        numDaysInMonth = (UINT8)0;
    }

    return(numDaysInMonth);
}


//*********************************************************************
// Time_GetTime
// This function returns the current time in the time structure whose
// address is passed.
//*********************************************************************
_FAR void Time_GetTime(
    TIME_ST *pTimeGetSt)          // addr to store time structure
{
    TIME_ST *pTimeSt = &TimeSt;

    if (pTimeGetSt != NULL) {
        DISABLE_INTS();
        // CHECK ME!! Could alternatively use memcpy. Which is faster???
        pTimeGetSt->hour     = pTimeSt->hour;
        pTimeGetSt->minute   = pTimeSt->minute;
        pTimeGetSt->second   = pTimeSt->second;
        pTimeGetSt->month    = pTimeSt->month;
        pTimeGetSt->day      = pTimeSt->day;
        pTimeGetSt->year     = pTimeSt->year;
        ENABLE_INTS();
    }

    return;
}


//*********************************************************************
// isTimeValid
// This function checks the validity of the time structure whose
// address is passed.
// Returns:
//   TRUE   if the time structure is valid
//   FALSE  otherwise
//*********************************************************************
_FAR static BOOL isTimeValid(
    const TIME_ST *pTimeSt)
{
    BOOL isValid;
	
    // The year is limited to a 4-digit value.
    if ((pTimeSt->year  >= 1900 && pTimeSt->year   <= 9999) &&
        (pTimeSt->month >= 1 &&    pTimeSt->month  <= 12)   &&
        (pTimeSt->day   >= 1 &&    pTimeSt->day    <= getDaysInMonth(
                                                        pTimeSt->month,
                                                        pTimeSt->year)) &&
        (                          pTimeSt->hour   <= 23)   &&
        (                          pTimeSt->minute <= 59)   &&
        (                          pTimeSt->second <= 59)) {
        isValid = TRUE;
    }
    else {
        isValid = FALSE;
    }

    return(isValid);
}


//*********************************************************************
// Time_DidSetTime
// This function attempts to set the current time to the value passed
// (by address).
// Returns:
//   TRUE   if the current time is successfully set to the time passed
//   FALSE  otherwise
//*********************************************************************
_FAR BOOL Time_DidSetTime(
    const TIME_ST *pTimeNewSt)
{
    BOOL didSetTime;
    TIME_ST *pTimeSt = &TimeSt;

    // Validate the new time data.
    if (isTimeValid(pTimeNewSt)) {
        // Update the time.  We must disable interrupts while updating
        // the time to keep from having the time updated from within
        // an ISR.
        DISABLE_INTS();
        pTimeSt->year    = pTimeNewSt->year;
        pTimeSt->month   = pTimeNewSt->month;
        pTimeSt->day     = pTimeNewSt->day;
        pTimeSt->hour    = pTimeNewSt->hour;
        pTimeSt->minute  = pTimeNewSt->minute;
        pTimeSt->second  = pTimeNewSt->second;
        Millisec         = 0;
        ENABLE_INTS();

        didSetTime = TRUE;
    }

    else {
        didSetTime = FALSE;
    }

    return(didSetTime);
}


//*********************************************************************
// Time_IncrementTime
// This function increments the time by the number of milliseconds
// specified. This function is expected to be called as a result
// of the time interrupt.
//*********************************************************************
_FAR void Time_IncrementTime(
    UINT16 incrMillisec)
{
    TIME_ST *pTimeSt = &TimeSt;

    DISABLE_INTS();

    Millisec += incrMillisec;

    if (Millisec >= MS_PER_SEC) {

        while (Millisec >= MS_PER_SEC) {
            Millisec -= MS_PER_SEC;
            pTimeSt->second++;
        }

        if (pTimeSt->second >= SEC_PER_MIN) {
            pTimeSt->second = 0;
            pTimeSt->minute++;

            if (pTimeSt->minute >= MIN_PER_HR) {
                pTimeSt->minute = 0;
                pTimeSt->hour++;

                if (pTimeSt->hour >= HR_PER_DAY) {
                    pTimeSt->hour = 0;
                    pTimeSt->day++;

                    if (pTimeSt->day >
                        getDaysInMonth(pTimeSt->month, pTimeSt->year)) {
                        pTimeSt->day = 1;
                        pTimeSt->month++;

                        if (pTimeSt->month > MONTHS_PER_YEAR) {
                            pTimeSt->month = 1;
                            pTimeSt->year++;
                        }
                    }
                }
            }
        }
    }

    // Re-enable interrupts.
    ENABLE_INTS();

    return;
}


//*********************************************************************
// Time_DidPackTime
// This function packs the time passed in the time structure and
// places the result at the specified address.
// Returns:
//   TRUE   if the time was successfully packed
//   FALSE  otherwise
//*********************************************************************
_FAR BOOL Time_DidPackTime(
    const TIME_ST *pTimeSt,              // ptr to time structure
    PACKED_TIME_ST *pTimePackedSt) {     // ptr to packed time structure

    BOOLEAN didPackTime;

    if (isTimeValid(pTimeSt)) {
    
        // Convert the 4-digit year to the 2-digit equivalent.
        pTimePackedSt->year   = (pTimeSt->year % 1000) % 100;
        pTimePackedSt->month  = pTimeSt->month;
        pTimePackedSt->day    = pTimeSt->day;
        pTimePackedSt->hour   = pTimeSt->hour;
        pTimePackedSt->minute = pTimeSt->minute;
        pTimePackedSt->second = pTimeSt->second >> 1;

        didPackTime = TRUE;
    }
    else {
        didPackTime = FALSE;
    }

    return(didPackTime);
}


//*********************************************************************
// Time_DidUnpackTime
// This function unpacks the time passed in the packed time structure
// and places the result at the specified address.
// ASSUMPTION: It is assumed that the packed year is in the 21st
//             century (i.e., 2000 <= year <= 2999).
// Returns:
//   TRUE   if the unpacked time is valid
//   FALSE  otherwise (i.e., the value in pTimeSt is invalid)
//*********************************************************************
_FAR BOOL Time_DidUnpackTime(
    const PACKED_TIME_ST *pTimePackedSt, // ptr to packed time structure
    TIME_ST *pTimeSt) {                  // ptr to (unpacked) time structure

    pTimeSt->year   = pTimePackedSt->year + 2000;
    pTimeSt->month  = pTimePackedSt->month;
    pTimeSt->day    = pTimePackedSt->day;
    pTimeSt->hour   = pTimePackedSt->hour;
    pTimeSt->minute = pTimePackedSt->minute;
    pTimeSt->second = pTimePackedSt->second << 1;

    return(isTimeValid(pTimeSt));
}


//*********************************************************************
// Time_Init
// This function initializes the time module. It is expected to be
// invoked once at start-up. The clock is initialized
// to midnight, Jan. 1, 2000.
//*********************************************************************
_FAR void Time_Init(void)
{
    // Initialize the time to Jan. 1, 2000 00:00:00.
    TimeSt.year    =  2000;
    TimeSt.month   =  1;
    TimeSt.day     =  1;
    TimeSt.hour    =  0;
    TimeSt.minute  =  0;
    TimeSt.second  =  0;

    return;
}
