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
  24                     ; 2020-10-27  GPM
  25                     ; * Replaced lone single quote (such as in a contraction) with two single quotes to keep assembler
  26                     ;   "happy".
  27                     ; * Put double quotes around word "defined" so assembler does not think that it is a keyword. This
  28                     ;   happens even if the word is in a comment.
  29                     ;********************************************************************************************************
  30                     ; Notes    : THIS FILE *MUST* BE LINKED INTO NON_BANKED MEMORY!
  31                     ;********************************************************************************************************
  32                     
  33                     NON_BANKED:       section
  34                     
  35                     ;********************************************************************************************************
  36                     ;                                           I/O PORT ADDRESSES
  37                     ;********************************************************************************************************
  38                     
  39       00000030      PPAGE:            equ    $0030         ; Addres of PPAGE register (assuming MC9S12 (non XGATE part))
  40                     
  41                     ;********************************************************************************************************
  42                     ;                                          PUBLIC DECLARATIONS
  43                     ;********************************************************************************************************
  44                     
  45                         xdef   _OS_CPU_SR_Save
  46                         xdef   _OS_CPU_SR_Restore
  47                         xdef   _OSStartHighRdy
  48                         xdef   _OSCtxSw
  49                         xdef   _OSIntCtxSw
  50                         xdef   _OSTickISR
  51                     
  52                     ;********************************************************************************************************
  53                     ;                                         EXTERNAL DECLARATIONS
  54                     ;********************************************************************************************************
  55                     
  56                         xref   _OSIntExit
  57                         xref   _OSIntNesting
  58                         xref   _OSPrioCur
  59                         xref   _OSPrioHighRdy
  60                         xref   _OSRunning
  61                         xref   _OSTaskSwHook
  62                         xref   _OSTCBCur
  63                         xref   _OSTCBHighRdy
  64                         xref   _OSTickISRHandler
  65                         xref   _OSTimeTick
  66                     
  67                     ;********************************************************************************************************
  68                     ;                                  SAVE THE CCR AND DISABLE INTERRUPTS
  69                     ;                                                  &
  70                     ;                                              RESTORE CCR
  71                     ;
  72                     ; Description : These function implements OS_CRITICAL_METHOD #3
  73                     ;
  74                     ; Arguments   : The function prototypes for the two functions are:
  75                     ;               1) OS_CPU_SR  OSCPUSaveSR(void)
  76                     ;                             where OS_CPU_SR is the contents of the CCR register prior to disabling
  77                     ;                             interrupts.
  78                     ;               2) void       OSCPURestoreSR(OS_CPU_SR os_cpu_sr);
  79                     ;                             'os_cpu_sr' the the value of the CCR to restore.
  80                     ;
  81                     ; Note(s)     : 1) It''s assumed that the compiler uses the D register to pass a single 16-bit argument
  82                     ;                  to and from an assembly language function.
  83                     ;********************************************************************************************************
  84                     
  85  0000               _OS_CPU_SR_Save:
  86  0000 b721              tfr  ccr,b                         ; It''s assumed that 8-bit return value is in register B
  87  0002 1410              sei                                ; Disable interrupts
  88                     ;    rtc                                ; Return to caller with D containing the previous ccr
  89  0004 3d                rts
  90                     
  91  0005               _OS_CPU_SR_Restore:
  92  0005 b712              tfr  b,ccr                         ; B contains the CCR value to restore, move to CCR
  93                     ;    rtc
  94  0007 3d                rts
  95                     
  96                     ;********************************************************************************************************
  97                     ;                               START HIGHEST PRIORITY TASK READY-TO-RUN
  98                     ;
  99                     ; Description : This function is called by OSStart() to start the highest priority task that was created
 100                     ;               by your application before calling OSStart().
 101                     ;
 102                     ; Arguments   : none
 103                     ;
 104                     ; Note(s)     : 1) The stack frame is assumed to look as follows:
 105                     ;
 106                     ;                  _OSTCBHighRdy->OSTCBStkPtr +  0       PPAGE
 107                     ;                                             +  1       CCR
 108                     ;                                             +  2       B
 109                     ;                                             +  3       A
 110                     ;                                             +  4       X (H)
 111                     ;                                             +  5       X (L)
 112                     ;                                             +  6       Y (H)
 113                     ;                                             +  7       Y (L)
 114                     ;                                             +  8       PC(H)
 115                     ;                                             +  9       PC(L)
 116                     ;
 117                     ;               2) OSStartHighRdy() MUST:
 118                     ;                      a) Call OSTaskSwHook() then,
 119                     ;                      b) Set OSRunning to TRUE,
 120                     ;                      c) Switch to the highest priority task by loading the stack pointer of the
 121                     ;                         highest priority task into the SP register and execute an RTI instruction.
 122                     ;********************************************************************************************************
 123                     
 124  0008               _OSStartHighRdy:
 125                     ;    call   _OSTaskSwHook               ;  4~, Invoke user "defined" context switch hook
 126  0008 160000            jsr    _OSTaskSwHook               ;  4~, Invoke user "defined" context switch hook
 127                     
 128  000b c601              ldab   #$01                        ;  2~, Indicate that we are multitasking
 129  000d 7b0000            stab   _OSRunning                  ;  4~
 130                     
 131  0010 fe0000            ldx    _OSTCBHighRdy               ;  3~, Point to TCB of highest priority task ready to run
 132  0013 ef00              lds    0,x                         ;  3~, Load SP into 68HC12
 133                     
 134  0015 32                pula                               ;  3~, Get value of PPAGE register
 135  0016 5a30              staa   PPAGE                       ;  3~, Store into CPU''s PPAGE register
 136                     
 137  0018 0b                rti                                ;  4~, Run task
 138                     
 139                     ;********************************************************************************************************
 140                     ;                                       TASK LEVEL CONTEXT SWITCH
 141                     ;
 142                     ; Description : This function is called when a task makes a higher priority task ready-to-run.
 143                     ;
 144                     ; Arguments   : none
 145                     ;
 146                     ; Note(s)     : 1) Upon entry,
 147                     ;                  _OSTCBCur     points to the OS_TCB of the task to suspend
 148                     ;                  _OSTCBHighRdy points to the OS_TCB of the task to resume
 149                     ;
 150                     ;               2) The stack frame of the task to suspend looks as follows:
 151                     ;
 152                     ;                  SP +  0       PC(H)
 153                     ;                     +  1       PC(L)
 154                     ;
 155                     ;               3) The stack frame of the task to resume looks as follows:
 156                     ;
 157                     ;                  _OSTCBHighRdy->OSTCBStkPtr +  0       PPAGE
 158                     ;                                             +  1       CCR
 159                     ;                                             +  2       B
 160                     ;                                             +  3       A
 161                     ;                                             +  4       X (H)
 162                     ;                                             +  5       X (L)
 163                     ;                                             +  6       Y (H)
 164                     ;                                             +  7       Y (L)
 165                     ;                                             +  8       PC(H)
 166                     ;                                             +  9       PC(L)
 167                     ;********************************************************************************************************
 168                     
 169  0019               _OSCtxSw:
 170  0019 9630              ldaa   PPAGE                       ;  3~, Get current value of PPAGE register
 171  001b 36                psha                               ;  2~, Push PPAGE register onto current task''s stack
 172                     
 173  001c fd0000            ldy    _OSTCBCur                   ;  3~, _OSTCBCur->OSTCBStkPtr = Stack Pointer
 174  001f 6f40              sts    0,y                         ;  3~,
 175                     
 176                     ;    call   _OSTaskSwHook               ;  4~, Call user task switch hook
 177  0021 160000            jsr   _OSTaskSwHook                ;  4~, Call user task switch hook
 178                     
 179  0024 fe0000            ldx    _OSTCBHighRdy               ;  3~, _OSTCBCur  = _OSTCBHighRdy
 180  0027 7e0000            stx    _OSTCBCur                   ;  3~
 181                     
 182  002a f60000            ldab   _OSPrioHighRdy              ;  3~, _OSPrioCur = _OSPrioHighRdy
 183  002d 7b0000            stab   _OSPrioCur                  ;  3~
 184                     
 185  0030 ef00              lds    0,x                         ;  3~, Load SP into 68HC12
 186                     
 187  0032 32                pula                               ;  3~, Get value of PPAGE register
 188  0033 5a30              staa   PPAGE                       ;  3~, Store into CPU''s PPAGE register
 189                     
 190  0035 0b                rti                                ;  8~, Run task
 191                     
 192                     ;********************************************************************************************************
 193                     ;                                    INTERRUPT LEVEL CONTEXT SWITCH
 194                     ;
 195                     ; Description : This function is called by OSIntExit() to perform a context switch to a task that has
 196                     ;               been made ready-to-run by an ISR. The PPAGE register of the preempted task has already
 197                     ;               been stacked during the start of the ISR that is currently running.
 198                     ;
 199                     ; Arguments   : none
 200                     ;********************************************************************************************************
 201                     
 202  0036               _OSIntCtxSw:
 203                     ;    call   _OSTaskSwHook               ;  4~, Call user task switch hook
 204  0036 160000            jsr    _OSTaskSwHook               ;  4~, Call user task switch hook
 205                     
 206  0039 fe0000            ldx    _OSTCBHighRdy               ;  3~, _OSTCBCur  = _OSTCBHighRdy
 207  003c 7e0000            stx    _OSTCBCur                   ;  3~
 208                     
 209  003f f60000            ldab   _OSPrioHighRdy              ;  3~, _OSPrioCur = _OSPrioHighRdy
 210  0042 7b0000            stab   _OSPrioCur                  ;  3~
 211                     
 212  0045 ef00              lds    0,x                         ;  3~, Load the SP of the next task
 213                     
 214  0047 32                pula                               ;  3~, Get value of PPAGE register
 215  0048 5a30              staa   PPAGE                       ;  3~, Store into CPU''s PPAGE register
 216                     
 217  004a 0b                rti                                ;  8~, Run task
 218                     
 219                     ;********************************************************************************************************
 220                     ;                                           SYSTEM TICK ISR
 221                     ;
 222                     ; Description : This function is the ISR used to notify uC/OS-II that a system tick has occurred.  You
 223                     ;               must setup the S12XE''s interrupt vector table so that an OUTPUT COMPARE interrupt
 224                     ;               vectors to this function.
 225                     ;
 226                     ; Arguments   : none
 227                     ;
 228                     ; Notes       :  1) The 'tick ISR' assumes the we are using the Output Compare specified by OS_TICK_OC
 229                     ;                   (see APP_CFG.H and this file) to generate a tick that occurs every OS_TICK_OC_CNTS
 230                     ;                   (see APP_CFG.H) which corresponds to the number of FRT (Free Running Timer)
 231                     ;                   counts to the next interrupt.
 232                     ;
 233                     ;                2) All USER interrupts should be modeled EXACTLY like this where the only
 234                     ;                   line to be modified is the call to your ISR_Handler and perhaps the call to
 235                     ;                   the label name OSTickISR1.
 236                     ;********************************************************************************************************
 237                     
 238  004b               _OSTickISR:
 239  004b 9630              ldaa   PPAGE                       ;  3~, Get current value of PPAGE register
 240  004d 36                psha                               ;  2~, Push PPAGE register onto current task''s stack
 241                     
 242  004e 720000            inc    _OSIntNesting               ;  4~, Notify uC/OS-II about ISR
 243                     
 244  0051 f60000            ldab   _OSIntNesting               ;  4~, if (OSIntNesting == 1) {
 245  0054 c101              cmpb   #$01                        ;  2~
 246  0056 2605              bne    OSTickISR1                  ;  3~
 247                     
 248  0058 fd0000            ldy    _OSTCBCur                   ;  3~,     _OSTCBCur->OSTCBStkPtr = Stack Pointer
 249  005b 6f40              sts    0,y                         ;  3~, }
 250                     
 251  005d               OSTickISR1:
 252                     ;    call   _OSTickISRHandler
 253  005d 160000            jsr    _OSTickISRHandler
 254                     
 255                     ;   cli                                ;  2~, Enable interrupts to allow interrupt nesting
 256                     
 257                     ;    call   _OSIntExit                  ;  6~+, Notify uC/OS-II about end of ISR
 258  0060 160000            jsr    _OSIntExit                  ;  6~+, Notify uC/OS-II about end of ISR
 259                     
 260  0063 32                pula                               ;  3~, Get value of PPAGE register
 261  0064 5a30              staa   PPAGE                       ;  3~, Store into CPU''s PPAGE register
 262                     
 263  0066 0b                rti                                ;  12~, Return from interrupt, no higher priority tasks ready.
