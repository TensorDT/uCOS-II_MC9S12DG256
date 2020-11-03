//*********************************************************************
//
//  File name:  os_cpu.h
//
//  Purpose:    uCOS-II MC9S12DG256-specific header file
//
//  Target:     CPU 2.0
//
//  Revisions:
//   ##  dd mmm yyyy  who  description
//    1  28 Oct 2020  GPM  Initial revision.
//
//  Notes:
//  Based on os_cpu.h provided by Micrium (V2.93.00)
//
//  Tensor Drilling Technologies
//  2418 North Frazier St., Suite 100
//  Conroe, TX 77303
//*********************************************************************

// Avoid multiple inclusions.
#ifndef _os_cpu_h
#define _os_cpu_h

//--------------------------- Included Files --------------------------
#include "mc9s12dg256_banking.h"  // for program memory banking

//-------------------------- Type Definitions -------------------------
typedef unsigned char  BOOLEAN;
typedef unsigned char  INT8U;                    // Unsigned  8 bit quantity
typedef signed   char  INT8S;                    // Signed    8 bit quantity
typedef unsigned int   INT16U;                   // Unsigned 16 bit quantity
typedef signed   int   INT16S;                   // Signed   16 bit quantity
typedef unsigned long  INT32U;                   // Unsigned 32 bit quantity
typedef signed   long  INT32S;                   // Signed   32 bit quantity
typedef float          FP32;                     // Single precision floating point
typedef double         FP64;                     // Double precision floating point

typedef unsigned char  OS_STK;                   // Each stack entry is 8-bit wide
typedef unsigned char  OS_CPU_SR;                // Define size of CPU status register (PSW = 16 bits)

//------------------------ Constant Definitions -----------------------
#define BYTE           INT8S                     // Define data types for backward compatibility ...
#define UBYTE          INT8U                     // ... to uC/OS V1.xx      
#define WORD           INT16S
#define UWORD          INT16U
#define LONG           INT32S
#define ULONG          INT32U

#ifndef  FALSE
#define  FALSE    0
#endif

#ifndef  TRUE
#define  TRUE     1
#endif

//********************************************************************************************************
//                                           Motorola 68HC12
//
// Method #1:  Disable/Enable interrupts using simple instructions.  After critical section, interrupts
//             will be enabled even if they were disabled before entering the critical section.
//
// Method #2:  Disable/Enable interrupts by preserving the state of interrupts.  In other words, if
//             interrupts were disabled before entering the critical section, they will be disabled when
//             leaving the critical section.
//
// Method #3:  Disable/Enable interrupts by preserving the state of interrupts.  Generally speaking you
//             would store the state of the interrupt disable flag in the local variable 'cpu_sr' and then
//             disable interrupts.  'cpu_sr' is allocated in all of uC/OS-II's functions that need to
//             disable interrupts.  You would restore the interrupt disable state by copying back 'cpu_sr'
//             into the CPU's status register.
//
// NOTE(s)  :  1) The current version of the compiler does NOT allow method #2 to be used without changing
//                the processor independent portion of uC/OS-II.
//             2) The current version of the compiler does NOT allow method #3 either.  However, this can
//                be implemented in OS_CPU_A.S by defining the functions: OSCPUSaveSR() and
//                OSCPURestoreSR().
//********************************************************************************************************

#define  OS_CRITICAL_METHOD    3


#if      OS_CRITICAL_METHOD == 3
#define  OS_ENTER_CRITICAL()  cpu_sr = OS_CPU_SR_Save()    // Disable interrupts
#define  OS_EXIT_CRITICAL()   OS_CPU_SR_Restore(cpu_sr)    // Enable  interrupts
#endif


#define  OS_TASK_SW()         __asm("swi");                // modified for Cosmic toolchain

#define  OS_STK_GROWTH        1                            // Stack growth: 1 = Down, 0 = Up
                                                           // where down is high to low mem
														   // and   up   is low to high mem

//------------------------------- Macros ------------------------------
// none

//-------------------------- Module Variables -------------------------
// none

//------------------------ Function Prototype(s) ----------------------
// Prototypes for ISRs
_NEAR OS_CPU_SR  OS_CPU_SR_Save(void);
_NEAR void       OS_CPU_SR_Restore(OS_CPU_SR cpu_sr);
_NEAR void       OSTickISRHandler(void);

#endif   // end of os_cpu.h
