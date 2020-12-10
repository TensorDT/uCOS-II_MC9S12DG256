//*********************************************************************
//
//  File name:  test.c
//
//  Purpose:    uC/OS-II test module
//
//  Target:     MC9S12DG256-based board
//
//  Revisions:
//   ##  dd mmm yyyy  who  description
//    1  28 Oct 2020  GPM  Initial revision.
//
//  Notes:
//  (c) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
//  (p) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
//
//  Tensor Drilling Technologies
//  2418 North Frazier St., Suite 100
//  Conroe, TX 77303
//*********************************************************************

//--------------------------- Included Files --------------------------
#include "mc9s12dg256_banking.h"
#include "includes.h"
#include "iosdg256.h"
#include "mc9s12dg256_time.h"
#include "datatypes.h"

//-------------------------- Type Definitions -------------------------
// none

//------------------------ Constant Definitions -----------------------
#define PRIO_TEST_TASK            (0)       // TestTask's priority level

//------------------------------- Macros ------------------------------
// none

//-------------------------- Module Variables -------------------------
OS_STK TestTaskStk[100];

_EEPROM static UINT16 EETest16;
_EEPROM static UINT32 EETest32 = 0xDEADBEEF;

_DIR    static UINT16 ZeroPage16 = 0xFADE;

//------------------------------ Functions ----------------------------
_NEAR static void initHardware(void)
{
    // This just does the minimal hardware initialization to locate
    // the memory (RAM, registers, EEPROM) & init and start the
    // timer. (See S12MMCV4_ModMappingCtrl.pdf pp. 12-13)
    INITRG = 0x00;                // Keep registers at default location
                                  //   0x0000-0x03FF
    INITEE = 0x01;                // Keep 4K EEPROM at default location
                                  //   0x0000-0x0FFF
                                  //  (only 3K at 0x0400-0x3FFF is usable)
    INITRM = 0x11;                // Move 12K RAM to 0x1000-0x3FFF
								  
    MODE   = 0x80;                // Normal Single Chip mode
    CLKSEL = 0x00;                // SYSCLK derived from OSCCLK,
                                  //   nothing stops in wait mode
    PLLCTL = 0x80;                // Crystal monitor enabled, PLL off
    RTICTL = 0x00;                // RTI Prescale off
    COPCTL = 0x00;                // Disable the watchdog

    return;
}

_NEAR static void initClockTimer(void)
{
    // Disable all timer functions from pin logic.
    TCTL1  = 0x00;
    TCTL2  = 0x00;
    TCTL3  = 0x00;
    TCTL4  = 0x00;

    // Enable output compare 7 interrupt and disable all other
    // output compare interrupts.
    TIE    = TIE_C7I;

    // Configure the timer system prescaler (bus clock divisor).
    TSCR2  = TSCR2_PRESCALER_BITS; 

    // Configure timer 7 as output compare per the desired tick rate.
    // NOTE: The timer 7 interrupt handler must update the TC7 by
    //       TMR_TICKS_PER_TMR_INT since we're letting the clock run
    //       free (TSCR2 TCRE bit is zero).
    TIOS  |= TIOS_IOS7;
    OC7M  &= ~(OC7M_OC7M7);
    TC7    = TMR_TICKS_PER_TMR_INT;

    // Enable the timer system.
    TSCR1 |= TSCR1_TEN;

    return;
}

_NEAR void TestTask (void *pdata)
{
    // To avoid compiler warning
    pdata = pdata;

    // Initialize timer 7 for the clock tick interrupt
    initClockTimer();
	
    // For testing EEPROM
    EETest16 = 0x0000;

    // Enable interrupts.
    ENABLE_INTS();
    
    while (TRUE) {
        OSTimeDly(1);
    }
}

_NEAR void main(void)
{
    // Initialize the hardware, particularly the timer system.
    initHardware();

    // Test uC/OS-II here!!!
    OSInit();

    OSTaskCreate(
        TestTask,                 // task's address
        (void *)0,                // ptr to data to pass to task
        &TestTaskStk[99],         // task's top of stack
        PRIO_TEST_TASK);          // task's priority level

    OSStart();
}

