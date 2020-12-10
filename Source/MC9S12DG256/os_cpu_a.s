;********************************************************************************************************
;                                              uC/OS-II
;                                        The Real-Time Kernel
;
;                    Copyright 1992-2020 Silicon Laboratories Inc. www.silabs.com
;
;                                 SPDX-License-Identifier: APACHE-2.0
;
;               This software is subject to an open source license and is distributed by
;                Silicon Laboratories Inc. pursuant to the terms of the Apache License,
;                    Version 2.0 available at www.apache.org/licenses/LICENSE-2.0.
;
;********************************************************************************************************

;********************************************************************************************************
;
;                                        PAGED S12 Specific code
;                                               (COSMIC)
;
; Filename : os_cpu_a.s
; Version  : V2.93.00
;
; 2020-12-10  GPM
; * As all the OS code will be located in unpaged (unbanked) memory, changed calls and return from
;   calls to jump to subroutines and return from subroutines.
;
; 2020-10-27  GPM
; * Replaced lone single quote (such as in a contraction) with two single quotes to keep assembler
;   "happy".
; * Put double quotes around word "defined" so assembler does not think that it is a keyword. This
;   happens even if the word is in a comment.
;
;********************************************************************************************************
; NOTES:
; * THIS FILE *MUST* BE LINKED INTO UNPAGED (UNBANKED) FLASH MEMORY! (PAGE 0x3E or 0x3F)
;********************************************************************************************************

;********************************************************************************************************
;                                           I/O PORT ADDRESSES
;********************************************************************************************************

PPAGE:            equ    $0030         ; Addres of PPAGE register (assuming MC9S12 (non XGATE part))

;********************************************************************************************************
;                                          PUBLIC DECLARATIONS
;********************************************************************************************************

    xdef   _OS_CPU_SR_Save
    xdef   _OS_CPU_SR_Restore
    xdef   _OSStartHighRdy
    xdef   _OSCtxSw
    xdef   _OSIntCtxSw
    xdef   _OSTickISR

;********************************************************************************************************
;                                         EXTERNAL DECLARATIONS
;********************************************************************************************************

    xref   _OSIntExit
    xref   _OSIntNesting
    xref   _OSPrioCur
    xref   _OSPrioHighRdy
    xref   _OSRunning
    xref   _OSTaskSwHook
    xref   _OSTCBCur
    xref   _OSTCBHighRdy
    xref   _OSTickISRHandler
    xref   _OSTimeTick

;********************************************************************************************************
;                                  SAVE THE CCR AND DISABLE INTERRUPTS
;                                                  &
;                                              RESTORE CCR
;
; Description : These function implements OS_CRITICAL_METHOD #3
;
; Arguments   : The function prototypes for the two functions are:
;               1) OS_CPU_SR  OSCPUSaveSR(void)
;                             where OS_CPU_SR is the contents of the CCR register prior to disabling
;                             interrupts.
;               2) void       OSCPURestoreSR(OS_CPU_SR os_cpu_sr);
;                             'os_cpu_sr' the the value of the CCR to restore.
;
; Note(s)     : 1) It''s assumed that the compiler uses the D register to pass a single 16-bit argument
;                  to and from an assembly language function.
;********************************************************************************************************

_OS_CPU_SR_Save:
    tfr  ccr,b                         ; It''s assumed that 8-bit return value is in register B
    sei                                ; Disable interrupts
;    rtc                                ; Return to caller with D containing the previous ccr
    rts 

_OS_CPU_SR_Restore:
    tfr  b,ccr                         ; B contains the CCR value to restore, move to CCR
;    rtc
    rts

;********************************************************************************************************
;                               START HIGHEST PRIORITY TASK READY-TO-RUN
;
; Description : This function is called by OSStart() to start the highest priority task that was created
;               by your application before calling OSStart().
;
; Arguments   : none
;
; Note(s)     : 1) The stack frame is assumed to look as follows:
;
;                  _OSTCBHighRdy->OSTCBStkPtr +  0       PPAGE
;                                             +  1       CCR
;                                             +  2       B
;                                             +  3       A
;                                             +  4       X (H)
;                                             +  5       X (L)
;                                             +  6       Y (H)
;                                             +  7       Y (L)
;                                             +  8       PC(H)
;                                             +  9       PC(L)
;
;               2) OSStartHighRdy() MUST:
;                      a) Call OSTaskSwHook() then,
;                      b) Set OSRunning to TRUE,
;                      c) Switch to the highest priority task by loading the stack pointer of the
;                         highest priority task into the SP register and execute an RTI instruction.
;********************************************************************************************************

_OSStartHighRdy:
;    call   _OSTaskSwHook               ;  4~, Invoke user "defined" context switch hook
    jsr    _OSTaskSwHook               ;  4~, Invoke user "defined" context switch hook

    ldab   #$01                        ;  2~, Indicate that we are multitasking
    stab   _OSRunning                  ;  4~

    ldx    _OSTCBHighRdy               ;  3~, Point to TCB of highest priority task ready to run
    lds    0,x                         ;  3~, Load SP into 68HC12

    pula                               ;  3~, Get value of PPAGE register
    staa   PPAGE                       ;  3~, Store into CPU''s PPAGE register

    rti                                ;  4~, Run task

;********************************************************************************************************
;                                       TASK LEVEL CONTEXT SWITCH
;
; Description : This function is called when a task makes a higher priority task ready-to-run.
;
; Arguments   : none
;
; Note(s)     : 1) Upon entry,
;                  _OSTCBCur     points to the OS_TCB of the task to suspend
;                  _OSTCBHighRdy points to the OS_TCB of the task to resume
;
;               2) The stack frame of the task to suspend looks as follows:
;
;                  SP +  0       PC(H)
;                     +  1       PC(L)
;
;               3) The stack frame of the task to resume looks as follows:
;
;                  _OSTCBHighRdy->OSTCBStkPtr +  0       PPAGE
;                                             +  1       CCR
;                                             +  2       B
;                                             +  3       A
;                                             +  4       X (H)
;                                             +  5       X (L)
;                                             +  6       Y (H)
;                                             +  7       Y (L)
;                                             +  8       PC(H)
;                                             +  9       PC(L)
;********************************************************************************************************

_OSCtxSw:
    ldaa   PPAGE                       ;  3~, Get current value of PPAGE register
    psha                               ;  2~, Push PPAGE register onto current task''s stack

    ldy    _OSTCBCur                   ;  3~, _OSTCBCur->OSTCBStkPtr = Stack Pointer
    sts    0,y                         ;  3~,

;    call   _OSTaskSwHook               ;  4~, Call user task switch hook
    jsr   _OSTaskSwHook                ;  4~, Call user task switch hook

    ldx    _OSTCBHighRdy               ;  3~, _OSTCBCur  = _OSTCBHighRdy
    stx    _OSTCBCur                   ;  3~

    ldab   _OSPrioHighRdy              ;  3~, _OSPrioCur = _OSPrioHighRdy
    stab   _OSPrioCur                  ;  3~

    lds    0,x                         ;  3~, Load SP into 68HC12

    pula                               ;  3~, Get value of PPAGE register
    staa   PPAGE                       ;  3~, Store into CPU''s PPAGE register

    rti                                ;  8~, Run task

;********************************************************************************************************
;                                    INTERRUPT LEVEL CONTEXT SWITCH
;
; Description : This function is called by OSIntExit() to perform a context switch to a task that has
;               been made ready-to-run by an ISR. The PPAGE register of the preempted task has already
;               been stacked during the start of the ISR that is currently running.
;
; Arguments   : none
;********************************************************************************************************

_OSIntCtxSw:
;    call   _OSTaskSwHook               ;  4~, Call user task switch hook
    jsr    _OSTaskSwHook               ;  4~, Call user task switch hook

    ldx    _OSTCBHighRdy               ;  3~, _OSTCBCur  = _OSTCBHighRdy
    stx    _OSTCBCur                   ;  3~

    ldab   _OSPrioHighRdy              ;  3~, _OSPrioCur = _OSPrioHighRdy
    stab   _OSPrioCur                  ;  3~

    lds    0,x                         ;  3~, Load the SP of the next task

    pula                               ;  3~, Get value of PPAGE register
    staa   PPAGE                       ;  3~, Store into CPU''s PPAGE register

    rti                                ;  8~, Run task

;********************************************************************************************************
;                                           SYSTEM TICK ISR
;
; Description : This function is the ISR used to notify uC/OS-II that a system tick has occurred.  You
;               must setup the S12XE''s interrupt vector table so that an OUTPUT COMPARE interrupt
;               vectors to this function.
;
; Arguments   : none
;
;********************************************************************************************************

_OSTickISR:
    ldaa   PPAGE                       ;  3~, Get current value of PPAGE register
    psha                               ;  2~, Push PPAGE register onto current task''s stack

    inc    _OSIntNesting               ;  4~, Notify uC/OS-II about ISR

    ldab   _OSIntNesting               ;  4~, if (OSIntNesting == 1) {
    cmpb   #$01                        ;  2~
    bne    OSTickISR1                  ;  3~

    ldy    _OSTCBCur                   ;  3~,     _OSTCBCur->OSTCBStkPtr = Stack Pointer
    sts    0,y                         ;  3~, }

OSTickISR1:
    jsr    _OSTimeTick                 ; OSTimeTick can be called here or from within OSTickISRHandler

    jsr    _OSTickISRHandler           ; (original code used call instead of jsr)

;   cli                                ;  2~, Enable interrupts to allow interrupt nesting

    jsr    _OSIntExit                  ;  6~+, Notify uC/OS-II about end of ISR
                                       ;       (original code used call instead of jsr)

    pula                               ;  3~, Get value of PPAGE register
    staa   PPAGE                       ;  3~, Store into CPU''s PPAGE register

    rti                                ;  12~, Return from interrupt, no higher priority tasks ready.
