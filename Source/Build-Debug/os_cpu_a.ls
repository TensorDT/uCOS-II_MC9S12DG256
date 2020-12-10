   2                     ;********************************************************************************************************
   3                     ;                                              uC/OS-II
   4                     ;                                        The Real-Time Kernel
   5                     ;
   6                     ;                    Copyright 1992-2020 Silicon Laboratories Inc. www.silabs.com
   7                     ;
   8                     ;                                 SPDX-License-Identifier: APACHE-2.0
   9                     ;
  10                     ;               This software is subject to an open source license and is distributed by
  11                     ;                Silicon Laboratories Inc. pursuant to the terms of the Apache License,
  12                     ;                    Version 2.0 available at www.apache.org/licenses/LICENSE-2.0.
  13                     ;
  14                     ;********************************************************************************************************
  15                     
  16                     ;********************************************************************************************************
  17                     ;
  18                     ;                                        PAGED S12 Specific code
  19                     ;                                               (COSMIC)
  20                     ;
  21                     ; Filename : os_cpu_a.s
  22                     ; Version  : V2.93.00
  23                     ;
  24                     ; 2020-12-10  GPM
  25                     ; * As all the OS code will be located in unpaged (unbanked) memory, changed calls and return from
  26                     ;   calls to jump to subroutines and return from subroutines.
  27                     ;
  28                     ; 2020-10-27  GPM
  29                     ; * Replaced lone single quote (such as in a contraction) with two single quotes to keep assembler
  30                     ;   "happy".
  31                     ; * Put double quotes around word "defined" so assembler does not think that it is a keyword. This
  32                     ;   happens even if the word is in a comment.
  33                     ;
  34                     ;********************************************************************************************************
  35                     ; NOTES:
  36                     ; * THIS FILE *MUST* BE LINKED INTO UNPAGED (UNBANKED) FLASH MEMORY! (PAGE 0x3E or 0x3F)
  37                     ;********************************************************************************************************
  38                     
  39                     ;********************************************************************************************************
  40                     ;                                           I/O PORT ADDRESSES
  41                     ;********************************************************************************************************
  42                     
  43       00000030      PPAGE:            equ    $0030         ; Addres of PPAGE register (assuming MC9S12 (non XGATE part))
  44                     
  45                     ;********************************************************************************************************
  46                     ;                                          PUBLIC DECLARATIONS
  47                     ;********************************************************************************************************
  48                     
  49                         xdef   _OS_CPU_SR_Save
  50                         xdef   _OS_CPU_SR_Restore
  51                         xdef   _OSStartHighRdy
  52                         xdef   _OSCtxSw
  53                         xdef   _OSIntCtxSw
  54                         xdef   _OSTickISR
  55                     
  56                     ;********************************************************************************************************
  57                     ;                                         EXTERNAL DECLARATIONS
  58                     ;********************************************************************************************************
  59                     
  60                         xref   _OSIntExit
  61                         xref   _OSIntNesting
  62                         xref   _OSPrioCur
  63                         xref   _OSPrioHighRdy
  64                         xref   _OSRunning
  65                         xref   _OSTaskSwHook
  66                         xref   _OSTCBCur
  67                         xref   _OSTCBHighRdy
  68                         xref   _OSTickISRHandler
  69                         xref   _OSTimeTick
  70                     
  71                     ;********************************************************************************************************
  72                     ;                                  SAVE THE CCR AND DISABLE INTERRUPTS
  73                     ;                                                  &
  74                     ;                                              RESTORE CCR
  75                     ;
  76                     ; Description : These function implements OS_CRITICAL_METHOD #3
  77                     ;
  78                     ; Arguments   : The function prototypes for the two functions are:
  79                     ;               1) OS_CPU_SR  OSCPUSaveSR(void)
  80                     ;                             where OS_CPU_SR is the contents of the CCR register prior to disabling
  81                     ;                             interrupts.
  82                     ;               2) void       OSCPURestoreSR(OS_CPU_SR os_cpu_sr);
  83                     ;                             'os_cpu_sr' the the value of the CCR to restore.
  84                     ;
  85                     ; Note(s)     : 1) It''s assumed that the compiler uses the D register to pass a single 16-bit argument
  86                     ;                  to and from an assembly language function.
  87                     ;********************************************************************************************************
  88                     
  89  0000               _OS_CPU_SR_Save:
  90  0000 b721              tfr  ccr,b                         ; It''s assumed that 8-bit return value is in register B
  91  0002 1410              sei                                ; Disable interrupts
  92                     ;    rtc                                ; Return to caller with D containing the previous ccr
  93  0004 3d                rts
  94                     
  95  0005               _OS_CPU_SR_Restore:
  96  0005 b712              tfr  b,ccr                         ; B contains the CCR value to restore, move to CCR
  97                     ;    rtc
  98  0007 3d                rts
  99                     
 100                     ;********************************************************************************************************
 101                     ;                               START HIGHEST PRIORITY TASK READY-TO-RUN
 102                     ;
 103                     ; Description : This function is called by OSStart() to start the highest priority task that was created
 104                     ;               by your application before calling OSStart().
 105                     ;
 106                     ; Arguments   : none
 107                     ;
 108                     ; Note(s)     : 1) The stack frame is assumed to look as follows:
 109                     ;
 110                     ;                  _OSTCBHighRdy->OSTCBStkPtr +  0       PPAGE
 111                     ;                                             +  1       CCR
 112                     ;                                             +  2       B
 113                     ;                                             +  3       A
 114                     ;                                             +  4       X (H)
 115                     ;                                             +  5       X (L)
 116                     ;                                             +  6       Y (H)
 117                     ;                                             +  7       Y (L)
 118                     ;                                             +  8       PC(H)
 119                     ;                                             +  9       PC(L)
 120                     ;
 121                     ;               2) OSStartHighRdy() MUST:
 122                     ;                      a) Call OSTaskSwHook() then,
 123                     ;                      b) Set OSRunning to TRUE,
 124                     ;                      c) Switch to the highest priority task by loading the stack pointer of the
 125                     ;                         highest priority task into the SP register and execute an RTI instruction.
 126                     ;********************************************************************************************************
 127                     
 128  0008               _OSStartHighRdy:
 129                     ;    call   _OSTaskSwHook               ;  4~, Invoke user "defined" context switch hook
 130  0008 160000            jsr    _OSTaskSwHook               ;  4~, Invoke user "defined" context switch hook
 131                     
 132  000b c601              ldab   #$01                        ;  2~, Indicate that we are multitasking
 133  000d 7b0000            stab   _OSRunning                  ;  4~
 134                     
 135  0010 fe0000            ldx    _OSTCBHighRdy               ;  3~, Point to TCB of highest priority task ready to run
 136  0013 ef00              lds    0,x                         ;  3~, Load SP into 68HC12
 137                     
 138  0015 32                pula                               ;  3~, Get value of PPAGE register
 139  0016 5a30              staa   PPAGE                       ;  3~, Store into CPU''s PPAGE register
 140                     
 141  0018 0b                rti                                ;  4~, Run task
 142                     
 143                     ;********************************************************************************************************
 144                     ;                                       TASK LEVEL CONTEXT SWITCH
 145                     ;
 146                     ; Description : This function is called when a task makes a higher priority task ready-to-run.
 147                     ;
 148                     ; Arguments   : none
 149                     ;
 150                     ; Note(s)     : 1) Upon entry,
 151                     ;                  _OSTCBCur     points to the OS_TCB of the task to suspend
 152                     ;                  _OSTCBHighRdy points to the OS_TCB of the task to resume
 153                     ;
 154                     ;               2) The stack frame of the task to suspend looks as follows:
 155                     ;
 156                     ;                  SP +  0       PC(H)
 157                     ;                     +  1       PC(L)
 158                     ;
 159                     ;               3) The stack frame of the task to resume looks as follows:
 160                     ;
 161                     ;                  _OSTCBHighRdy->OSTCBStkPtr +  0       PPAGE
 162                     ;                                             +  1       CCR
 163                     ;                                             +  2       B
 164                     ;                                             +  3       A
 165                     ;                                             +  4       X (H)
 166                     ;                                             +  5       X (L)
 167                     ;                                             +  6       Y (H)
 168                     ;                                             +  7       Y (L)
 169                     ;                                             +  8       PC(H)
 170                     ;                                             +  9       PC(L)
 171                     ;********************************************************************************************************
 172                     
 173  0019               _OSCtxSw:
 174  0019 9630              ldaa   PPAGE                       ;  3~, Get current value of PPAGE register
 175  001b 36                psha                               ;  2~, Push PPAGE register onto current task''s stack
 176                     
 177  001c fd0000            ldy    _OSTCBCur                   ;  3~, _OSTCBCur->OSTCBStkPtr = Stack Pointer
 178  001f 6f40              sts    0,y                         ;  3~,
 179                     
 180                     ;    call   _OSTaskSwHook               ;  4~, Call user task switch hook
 181  0021 160000            jsr   _OSTaskSwHook                ;  4~, Call user task switch hook
 182                     
 183  0024 fe0000            ldx    _OSTCBHighRdy               ;  3~, _OSTCBCur  = _OSTCBHighRdy
 184  0027 7e0000            stx    _OSTCBCur                   ;  3~
 185                     
 186  002a f60000            ldab   _OSPrioHighRdy              ;  3~, _OSPrioCur = _OSPrioHighRdy
 187  002d 7b0000            stab   _OSPrioCur                  ;  3~
 188                     
 189  0030 ef00              lds    0,x                         ;  3~, Load SP into 68HC12
 190                     
 191  0032 32                pula                               ;  3~, Get value of PPAGE register
 192  0033 5a30              staa   PPAGE                       ;  3~, Store into CPU''s PPAGE register
 193                     
 194  0035 0b                rti                                ;  8~, Run task
 195                     
 196                     ;********************************************************************************************************
 197                     ;                                    INTERRUPT LEVEL CONTEXT SWITCH
 198                     ;
 199                     ; Description : This function is called by OSIntExit() to perform a context switch to a task that has
 200                     ;               been made ready-to-run by an ISR. The PPAGE register of the preempted task has already
 201                     ;               been stacked during the start of the ISR that is currently running.
 202                     ;
 203                     ; Arguments   : none
 204                     ;********************************************************************************************************
 205                     
 206  0036               _OSIntCtxSw:
 207                     ;    call   _OSTaskSwHook               ;  4~, Call user task switch hook
 208  0036 160000            jsr    _OSTaskSwHook               ;  4~, Call user task switch hook
 209                     
 210  0039 fe0000            ldx    _OSTCBHighRdy               ;  3~, _OSTCBCur  = _OSTCBHighRdy
 211  003c 7e0000            stx    _OSTCBCur                   ;  3~
 212                     
 213  003f f60000            ldab   _OSPrioHighRdy              ;  3~, _OSPrioCur = _OSPrioHighRdy
 214  0042 7b0000            stab   _OSPrioCur                  ;  3~
 215                     
 216  0045 ef00              lds    0,x                         ;  3~, Load the SP of the next task
 217                     
 218  0047 32                pula                               ;  3~, Get value of PPAGE register
 219  0048 5a30              staa   PPAGE                       ;  3~, Store into CPU''s PPAGE register
 220                     
 221  004a 0b                rti                                ;  8~, Run task
 222                     
 223                     ;********************************************************************************************************
 224                     ;                                           SYSTEM TICK ISR
 225                     ;
 226                     ; Description : This function is the ISR used to notify uC/OS-II that a system tick has occurred.  You
 227                     ;               must setup the S12XE''s interrupt vector table so that an OUTPUT COMPARE interrupt
 228                     ;               vectors to this function.
 229                     ;
 230                     ; Arguments   : none
 231                     ;
 232                     ;********************************************************************************************************
 233                     
 234  004b               _OSTickISR:
 235  004b 9630              ldaa   PPAGE                       ;  3~, Get current value of PPAGE register
 236  004d 36                psha                               ;  2~, Push PPAGE register onto current task''s stack
 237                     
 238  004e 720000            inc    _OSIntNesting               ;  4~, Notify uC/OS-II about ISR
 239                     
 240  0051 f60000            ldab   _OSIntNesting               ;  4~, if (OSIntNesting == 1) {
 241  0054 c101              cmpb   #$01                        ;  2~
 242  0056 2605              bne    OSTickISR1                  ;  3~
 243                     
 244  0058 fd0000            ldy    _OSTCBCur                   ;  3~,     _OSTCBCur->OSTCBStkPtr = Stack Pointer
 245  005b 6f40              sts    0,y                         ;  3~, }
 246                     
 247  005d               OSTickISR1:
 248  005d 160000            jsr    _OSTimeTick                 ; OSTimeTick can be called here or from within OSTickISRHandler
 249                     
 250  0060 160000            jsr    _OSTickISRHandler           ; (original code used call instead of jsr)
 251                     
 252                     ;   cli                                ;  2~, Enable interrupts to allow interrupt nesting
 253                     
 254  0063 160000            jsr    _OSIntExit                  ;  6~+, Notify uC/OS-II about end of ISR
 255                                                            ;       (original code used call instead of jsr)
 256                     
 257  0066 32                pula                               ;  3~, Get value of PPAGE register
 258  0067 5a30              staa   PPAGE                       ;  3~, Store into CPU''s PPAGE register
 259                     
 260  0069 0b                rti                                ;  12~, Return from interrupt, no higher priority tasks ready.
