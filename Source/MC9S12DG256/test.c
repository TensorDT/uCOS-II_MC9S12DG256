//*********************************************************************
//
//  File name:  test.c
//
//  Purpose:    uC/OS-II test module
//
//  Target:     CPU 2.0
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

//-------------------------- Type Definitions -------------------------
// none

//------------------------ Constant Definitions -----------------------
#define PRIO_TEST_TASK   (0)      // TestTask's priority level

//------------------------------- Macros ------------------------------
// none

//-------------------------- Module Variables -------------------------
OS_STK TestTaskStk[100];

//------------------------------ Functions ----------------------------
static void initHardware(void)
{
    // This just does the minimal hardware initialization to locate
    // the memory (registers, EEPROM, RAM) & init and start the
    // timer.
    INITRG = 0x00;                // Keep registers at default location
                                  //   0x0000-0x03FF
    INITEE = 0x01;                // Keep 4K EEPROM at default location
                                  //   0x0000-0x0FFF
                                  //  (only 3K at 0x0x0400-0x3FFF is usable)
    INITRM = 0x09;                // Keep 12K RAM  at default location
                                  //   0x1000-0x3FFF
    MODE   = 0x80;                // Normal Single Chip mode
    CLKSEL = 0x00;                // SYSCLK derived from OSCCLK,
                                  //   nothing stops in wait mode
    PLLCTL = 0x80;                // Crystal monitor enabled, PLL off
    RTICTL = 0x00;                // RTI Prescale off
    COPCTL = 0x00;                // Disable the watchdog

    TSCR2 = TSCR2_PRESCALER_BITS; // Disable timer overflow interrupt,
                                  //   counter runs free, timer prescaler
                                  //   set as defined in mc9s12dg256_time.h
//    TSCR1 = 0x80;                 // Enable the timer, allow to run during wait

}

_NEAR void TestTask (void *pdata)
{
    pdata = pdata;
    while (1) {
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

