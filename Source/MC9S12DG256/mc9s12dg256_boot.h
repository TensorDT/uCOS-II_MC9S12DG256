//*********************************************************************
//
//  File name:  mc9s12dg256_boot.h
//
//  Purpose:    Boot module header file.
//
//  Target:     MC9S12DG256-based board
//
//  Revisions:
//   ##  dd mmm yyyy  who  description
//    1  03 Nov 2020  GPM  Initial revision (based on CTF Recorder
//                         board boot.h file).
//
//  Notes:
//  (c) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
//  (p) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
//
//  Tensor Drilling Technologies
//  2418 North Frazier St., Suite 100
//  Conroe, TX 77303
//*********************************************************************

// Avoid multiple inclusions.
#ifndef _boot_h
#define _boot_h

//--------------------------- Included Files --------------------------
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "iosdg256.h"
#include "datatypes.h"


//-------------------------- Type Definitions -------------------------
// none
    
//------------------------ Constant Definitions -----------------------
// Boolean true and false definitions
#define BTRUE                (1==1)
#define BFALSE               (0==1)

// Baud rates based on 4.9152MHz crystal
// SCI baud rate = bus clock / (16 x BR) where BR are the bits
// [SBR12:SBR0] om the SCI baud rate register, SCIBD.
// Recall that the bus clock is half the crystal frequency.
// The baud rate register is 16-bits. If the upper byte
// is written, then the lower byte must be written as well.
// However, the lower byte can be written without writing to
// the higher byte. We only need to write to the lower byte.
#define BAUD38400              ((UINT8)4)        // 0x04
#define BAUD19200              ((UINT8)8)        // 0x08
#define BAUD9600               ((UINT8)16)       // 0x10
#define BAUD4800               ((UINT8)32)       // 0x20
#define BAUD2400               ((UINT8)64)       // 0x40
#define BAUD1200               ((UINT8)128)      // 0x80

// qBUS-related constants
#define SOH                    (0x01)
#define STX                    (0x02)
#define ETX                    (0x03)
#define EOT                    (0x04)
#define ENQ                    (0x05)
#define ACK                    (0x06)
#define DLE                    (0x10)
#define NAK                    (0x15)
#define ETB                    (0x17)
#define DRD                    (0x3C)            // ASCII '<'
#define DWR                    (0x3E)            // ASCII '>'

#define EE_START_ADDR          ((UINT16)0x0400)  
#define EE_END_ADDR            ((UINT16)0x0FEF)  // do not use the reserved area from 0x0FF0 to 0x0FFF

// commands for accessing the internal 4KB EEPROM of MC9S12DG256
#define EE_VRFY_MASS_ERASE     (0x05)            // verify if the EEPROM was mass-erased
#define EE_PROGRAM_WORD        (0x20)            // program an aligned word (2 bytes) to the EEPROM 
#define EE_SECTOR_ERASE        (0x40)            // erase a sector (2 words) of EEPROM
#define EE_MASS_ERASE          (0x41)            // erase the entire 4KB of EEPROM
#define EE_SECTOR_MODIFY       (0x60)            // do a sector-erase and then program the 1st word

// for bootloader firmware
#define FLASH_VRFY_MASS_ERASE  (0x05)            // verify if the currrent flash block was mass-erased
#define FLASH_PROGRAM_WORD     (0x20)            // program an aligned word (2 bytes) to the current flash block 
#define FLASH_SECTOR_ERASE     (0x40)            // erase 256 words in the current flash block
#define FLASH_MASS_ERASE       (0x41)            // erase the entire current flash block
#define FLASH_PAGE_START_ADDR  (0x8000)          // starting and ending addresses for banked pages
#define FLASH_PAGE_END_ADDR    (0xBFFF)
#define BT_PAGE_ST_ADDR_BNKD   (0xB600)          // the (banked) starting address of boot code in page 0x3F
#define BT_PAGE_ST_ADDR_UNBNKD (0xF600)          // the (unbanked) starting address of boot code in page 0x3F

#define BYTES_PER_WORD         (2)

//------------------------------- Macros ------------------------------
#define NOP()                  _asm("NOP")       // no operation
#define INTR_OFF()             _asm("SEI")       // disable interrupts
#define INTR_ON()              _asm("CLI")       // enable interrupts

// used in bootloader only
#define RX_MODE()              {PTM |=  (0x02); SCI0CR2 = SCISCR2_RE;}
#define TX_MODE()              {PTM &= ~(0x02); SCI0CR2 = SCISCR2_TE;}

//-------------------------- Module Variables -------------------------
// for bootloader
extern UINT8 BuffRx[64];

//------------------------ Function Prototype(s) ----------------------
extern void Booting(void);
extern void BootLoaderToRunFromRAM(void);

#endif   // _boot_h
