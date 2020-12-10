//*********************************************************************
//
//  File name:  mc9s12dg256_bootloader.c
//
//  Purpose:    Bootloader module
//
//  Target:     MC9S12DG256-based board
//
//  Revisions:
//   ##  dd mmm yyyy  who  description
//    1  03 Nov 2020  GPM  Initial revision (based on CTF Recorder
//                         board bootloader.c file).
//
//  (c) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
//  (p) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
//
//  Notes:
//  As this is bootloader code that will be copied to and run from
//  RAM, we want to minimize the stack size required. Thus, local
//  variables and passed parameters are minimized (although this
//  leads to less-than-ideal code).
//
//  Tensor Drilling Technologies
//  2418 North Frazier St., Suite 100
//  Conroe, TX 77303
//********************************************************************/

//--------------------------- Included Files --------------------------
#include "mc9s12dg256_boot.h"
#include "iosdg256.h"
#include "datatypes.h"

//-------------------------- Type Definitions -------------------------
// none

//------------------------ Constant Definitions -----------------------
// Boolean true and false definitions
#define BTRUE                          (1==1)
#define BFALSE                         (0==1)

// Bootloader RAM start and end addresses
#define BL_RAM_ADDR_START              (0x3A00)
#define BL_RAM_ADDR_END                (0x3EFF)

// Erase memory (EEPROM or flash) error codes
#define ERASE_MEM_NO_ERROR             (0)    // erase successful
#define ERASE_MEM_PVIOL_ACCERR_ERR     (1)    // erase protection violation or access error
#define ERASE_MEM_BUFF_NOT_EMPTY       (2)    // erase buffer not empty error

// Write memory (EEPROM or flash) error codes
#define WRITE_MEM_NO_ERROR             (0)    // write successful
#define WRITE_MEM_PVIOL_ACCERR_ERR     (1)    // write protection violation or access error
#define WRITE_MEM_RESERVED_ERR         (2)    // reserved (previously CLKDIV not written yet)
#define WRITE_MEM_RANGE_ERR            (3)    // address or page out of range
#define WRITE_MEM_VERIFY_ERR           (4)    // written value verification error

#define CHECKSUM_ERR                   (0xFF)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//  Bootloader command format:
//
//   Framing |  Msg   | Command | ....Data....  | Checksum |
//    Byte   |  Len   |  Byte   | ...Byte(s)... |   Byte   |
//    STX    |  Byte  |  0x55   |               |  (see    |
//    or     | (see   |  0x66   |               |   note)  |
//    ETB    |  note) |  0x99   |               |          |
//           |        |   or    |               |          |
//           |        |  0xAA   |               |          |
//
//  NOTES:
//    * The message length is the number of bytes from (and including)
//      the command byte to (and including) the checksum byte. Thus,
//      it is equal to (2 + number of data bytes).
//    * The number of data bytes can vary from 0 to 253.
//    * The checksum is the one's complement of the sum of the
//      message bytes excluding the framing and checksum bytes.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#define IDX_FRAMING_BYTE               (0)  // index of "framing" byte (STX or ETB)
#define IDX_MSG_LEN_BYTE               (1)  // index of message length (in bytes) byte
#define IDX_CMD_BYTE                   (2)  // index of command byte
#define IDX_ADDR_START_BYTE_2          (3)  // most-significant start addr byte
#define IDX_ADDR_START_BYTE_1          (4)
#define IDX_ADDR_START_BYTE_0          (5)  // least-significant start addr byte
                                            // (only sent for flash addresses!)

// The fewest number of bytes in a valid command
// (The +1 is for the checksum byte)
#define CMD_NUM_BYTES_MIN              (IDX_CMD_BYTE+1)

// Bootloader commands
#define BT_CMD_FLASH_ERASE             (0x55)
#define BT_CMD_FLASH_PGM_VER           (0x66)
#define BT_CMD_EEPROM_PGM_VER          (0x99)
#define BT_CMD_EEPROM_ERASE            (0xAA)

#define NUM_MSG_HDR_BYTES_FLASH        (IDX_ADDR_START_BYTE_0 + 1)
#define NUM_MSG_HDR_BYTES_EEPROM       (IDX_ADDR_START_BYTE_1 + 1)

#define BYTES_PER_WORD                 (2)

//------------------------------- Macros ------------------------------
// none

//-------------------------- Module Variables -------------------------
// none

//-------------------------- Global Variables -------------------------
// These are "temporary" global variables used only during bootloading
// process.
// NOTE: These variable are located in RAM at addresses below where the
//       bootloader code will reside. There are also variables declared
//       in booting.c; make sure these variables do not overlap with
//       the ones in booting.c.
//
UINT8         TempUINT8      @0x39F0;
UINT8         Index          @0x39F1;
BOOL          WasBTCmdRcvd   @0x39F2;
UINT8         ErrorNum       @0x39F3;
UINT8         Checksum       @0x39F4;
UINT8         PageFlash      @0x39F5;
UINT8         CntrBytes      @0x39F6;

UINT16        TempUINT16     @0x39F8;
UINT16        Addr1          @0x39FA;
UINT16        Addr2          @0x39FC;

//------------------------------ Functions ----------------------------
// Protypes
// Ordinarily the functions would be ordered so that prototypes are
// unnecessary. However, in this case, the bootloader function
// *MUST* be the first one listed so that it starts at the beginning
// of the bootloader RAM code space. Hence, the need to prototype
// the local functions called by the bootloader function.
_NEAR static void delayMilliseconds(UINT16 delay_ms);
_NEAR static void processCommand(void);

//*********************************************************************
// BootLoaderToRunFromRAM
// This is the bootloader function to be copied to and executed from
// RAM.
//*********************************************************************
_NEAR void BootLoaderToRunFromRAM(void)
{
#define NO_ERROR               (0)

    // Initialize internal EEPROM registers
    ECLKDIV = 0x1A;          // ECLK = OSC/(26+1) = 4915200/27 = 182044 Hz
                             //   (must be between 150KHz and 200KHz)
    ECNFG   = 0x00;          // Disable both CBEIE and CCIE
    EPROT   = 0xFF;          // This value is loaded from an EEPROM byte at 0x4FFD at startup
    ESTAT  |= (ESTAT_PVIOL | // Clear PVIOL and ACCERR flags
               ESTAT_ACCERR); 

    // Initialize internal flash registers
    FCLKDIV = 0x1A;          // ECLK = OSC/(26+1) = 4915200/27 = 182044 Hz
                             //   (must be between 150KHz and 200KHz)
    FCNFG   = 0x00;          // Disable related interrupts and security key writing
    FPROT   = 0xFF;          // No flash protection
    FSTAT  |= (FSTAT_PVIOL | // Clear PVIOL and ACCERR flags
               FSTAT_ACCERR);

    PPAGE   = 0;             // Reset to page 0 (default)

    // Reset these variables for receiving multiple commands
    BuffRx[0] = 0;
    Index = 0;
    WasBTCmdRcvd = BFALSE;
    CntrBytes = 0;

    while (BuffRx[IDX_FRAMING_BYTE] != ETB) {

        if (SCI0SR1 & 0x20) {     // received a byte?

            BuffRx[Index] = SCI0DRL;

            if (Index == IDX_FRAMING_BYTE) {

                // The first character must be STX (if we will be receiving
                // a command) or ETB (if we're done bootloading). If it
                // isn't, perhaps it's noise so we'll keep looking for
                // STX or ETB in the next 255 characters before giving up
                // and jumping to the application code.
                if ((BuffRx[IDX_FRAMING_BYTE] != STX) &&
                    (BuffRx[IDX_FRAMING_BYTE] != ETB)) {

                    if (CntrBytes < UINT8_MAX) {
                        // Increment the byte counter and keep looking
                        // for the next STX or ETB.
                        CntrBytes++;
                    }
                    else {
                        // Give up and jump to execute the application
                        // (hopefully it hasn't been erased).
                        #pragma asm
                            jmp $4000
                        #pragma endasm
                    }  // end of else (CntrBytes == UINT8_MAX)
                }  // end of framing byte not STX nor ETB
                else {
                    // Found an STX or ETB. Reset the counter for looking
                    // for STX or ETB.
                    CntrBytes = 0;
                }
            }
            else if (Index >= CMD_NUM_BYTES_MIN) {
                // Check if all the command bytes have been received
                // (based on the message length byte).
                if ((Index-1) == BuffRx[IDX_MSG_LEN_BYTE]) {
                    // Yes, the command receipt is done.
                    WasBTCmdRcvd = BTRUE;
                }
            }
            Index++;
        }

        if (WasBTCmdRcvd) {

            // A command was received. Calculate the message checksum and
            // compare it to transmitted checksum (sent in the last
            // command message byte). 
            // Calculate the checksum as the one's complement of the
            // sum of the message bytes (excluding the framing and
            // the checksum bytes). 
            Checksum = 0;
            Index = BuffRx[IDX_MSG_LEN_BYTE]+1; // Get the checksum byte index.
            for (TempUINT8=IDX_MSG_LEN_BYTE;
                 TempUINT8 < Index;
                 TempUINT8++) {
                Checksum += BuffRx[TempUINT8];
            }
            Checksum = 0xFF - Checksum;     // One's complement

            if (Checksum == BuffRx[Index]) {
                // The checksum values match; process the command.
                // It will put the error indicator in ErrorNum.
                processCommand();
            }
            else {
                // Error - the checksum values don't match.
                ErrorNum = CHECKSUM_ERR;
            }

            TX_MODE();             // Switch to transmit mode

#if defined DEBUG
            delayMilliseconds(1);  // Shorter delay due to debugger slowness.
#else			
            delayMilliseconds(20); // Delay 20ms before sending an ACK or NACK.
#endif

            if (ErrorNum == NO_ERROR) {

                // No error occurred so send an ACK. Wait for the
                // character transmission to complete.
                SCI0DRL = ACK;
                while (!(SCI0SR1 & SCISCR1_SCISWAI)) {;}

                // Return to receive mode. Read the SCI's status and data
                // registers to clear any interrupt flag.
                RX_MODE();
                TempUINT8 = SCI0SR1;
                TempUINT8 = SCI0DRL;
            }

            else {

                // An error occurred so send a NACK. Wait for the
                // character transmission to complete.
                SCI0DRL = NAK;
                while (!(SCI0SR1 & SCISCR1_SCISWAI)) {;}

                // Return to receive mode. Read the SCI's status and data
                // registers to clear any interrupt flag.
                RX_MODE();
                TempUINT8 = SCI0SR1;
                TempUINT8 = SCI0DRL;

                // If it's not a checksum error, skip bootloading -
                // jump to the application code start.
                if (ErrorNum != CHECKSUM_ERR) {
                    #pragma asm
                        jmp $4000
                    #pragma endasm
                }
            }

            // Reset variables for receiving multiple commands.
            BuffRx[0] = 0;
            Index = 0;
            WasBTCmdRcvd = BFALSE;
        }
    }

    // We're done bootloading; jump to the application code start.
    #pragma asm
        jmp $4000
    #pragma endasm

    return;
}

//*********************************************************************
// delayMilliseconds
// This function creates a delay of length (in milliseconds)
// equal to the specified parameter.
//
// NOTE: This function does NOT use a processor timer. Rather,
//       it is simply a "NOP" loop tuned to be approximately a
//       millisecond in duration when the crystal frequency is
//       4.9152 MHz.
//*********************************************************************
_NEAR static void delayMilliseconds(
    UINT16 delay_ms)         // software delay in milliseconds
{
    UINT16 cntr_ms;
    UINT8  cntr1msLp;
    
    for (cntr_ms = 0;
         cntr_ms < delay_ms;
         cntr_ms++) {
        // This loops takes ~1ms to execute
        for (cntr1msLp = 0; cntr1msLp < 221; cntr1msLp++) {
            NOP();
        }
    }

    return;
}


//*********************************************************************
// eraseFlash
// This function erases all the MC9S12DG256 internal flash except
// the boot code area from 0xF800 to 0xFFFF (page 0x3F).
// This function assumes that the FCLKDIV register has already been
// set to divide the oscillator down to within [150,200] kHz.
// This function returns an error indicator as follows:
//   0 - erase successful (no error)
//   1 - PVIOL/ACCERR flag(s) set
//   2 - address, data, and/or command buffer not empty
//*********************************************************************
#ifdef USE_SLOWER_FLASH_ERASE
_NEAR static UINT8 eraseFlash(void)
{
#define CALC_BLOCK_FROM_PG(page)       ((0x3F - (page)) >> 2)

    for (PageFlash = 0x30; PageFlash <= 0x3F; PageFlash++) {

        // Set the Flash Configuration Register to disable related interrupts,
        // disable writing security keys, and select the memory bank (block)
        // to be erased.
        FCNFG = CALC_BLOCK_FROM_PG(PageFlash);

        // Select the page.
        PPAGE = PageFlash;

        // This version is NOT concerned about preserving flash page 0x38.
        // Erase the page one sector (256 words or 512 bytes) at a time.
        // Note than when placing an unbanked page number (i.e., 0x3E or 0x3F)
        // in the PPAGE register, that page can be seen twice in the MCU
        // memory map - once within the unbanked logical address (i.e.,
        // within [0x4000,0x7FFF] for page 0x3E or within [0xC000,0xFFFF] for
        // page 0x3F) and again within the paged logical address range
        // [0x8000,0xBFFF]. (See S12FTS256KV3/D V03.01 p. 15 NOTE 1)
        for (Addr1 = FLASH_PAGE_START_ADDR;
             Addr1 < FLASH_PAGE_END_ADDR;
             Addr1 += NUM_FLASH_BYTES_PER_SECTOR) {

            // Do not erase the boot code area
            // Since the boot code area contains the vectable, this is
            // why we must use a jump table (the vectable can't be changed
            // via the firmware loader).
            if ((PageFlash == 0x3F) && (Addr1 >= BT_PAGE_ST_ADDR_BNKD)) {
                break;
            }

            // Start the sector erase sequence:
            // (1) Write a dummy value to anywhere within the page.
            // (2) Write the sector erase command to the command buffer.
            // (3) Launch the command by writing a '1' to the CBEIF flag.
            *((volatile UINT16 *)Addr1) = 0xFFFF;
            FCMD   = FLASH_SECTOR_ERASE;
            FSTAT |= FSTAT_CBEIF;

            // Delay a little bit.
            NOP();
            NOP();

            // Check for protection violation and access error indications.
            // If any error is indicated, clear the error flag.
            if (FSTAT & (FSTAT_PVIOL | FSTAT_ACCERR)) {
                if (FSTAT & FSTAT_PVIOL)  { FSTAT |= FSTAT_PVIOL;  }
                if (FSTAT & FSTAT_ACCERR) { FSTAT |= FSTAT_ACCERR; }
                return (ERASE_MEM_PVIOL_ACCERR_ERR);
            }

            // Wait for the flash command buffer to be ready for the next
            // command sequence.
            while (!(FSTAT & FSTAT_CBEIF)) {;}

            // Wait for the sector erase command to complete.
            while (!(FSTAT & FSTAT_CCIF))  {;}

        }  // end of for Addr1 loop

    }  // end of PageFlash loop

    return (ERASE_MEM_NO_ERROR);
}

#else

_NEAR static UINT8 eraseFlash(void)
{
#define CALC_BLK_START_PG(blk)         (0x3C - ((blk) << 2))

    // Clear any previous protection and/or access error flag.
    FSTAT |= (FSTAT_PVIOL | FSTAT_ACCERR);
    
    // Wait for the flash command buffer to be ready to accept a new command.
    while (!(FSTAT & FSTAT_CBEIF)) {;}

    //***** Erase blocks 1, 2, and 3 first *****
    for (TempUINT8=1; TempUINT8 <= 3; TempUINT8++) {
        // Set the Flash Configuration Register to disable related interrupts,
        // disable writing security keys, and select the memory bank (block)
        // to be erased.
        FCNFG = TempUINT8;

        // Select a page within the block to be erased. Here we select the
        // first page of the block.
        PPAGE = CALC_BLK_START_PG(TempUINT8);

        // Verify that the buffers are ready to accept a new command.
        if ((FSTAT & FSTAT_CBEIF) == 0) {
            return (ERASE_MEM_BUFF_NOT_EMPTY);
        }

        // Buffers are ready so start the block erase sequence:
        // (1) Write a dummy value to anywhere within the flash.
        // (2) Write the (block/mass) erase command to the command buffer.
        // (3) Launch the command by writing a '1' to the CBEIF flag.
        *((volatile UINT16 *)FLASH_PAGE_START_ADDR) = 0xFFFF;
        FCMD  = FLASH_MASS_ERASE;
        FSTAT|= FSTAT_CBEIF;

        // Delay a little bit.
        NOP();
        NOP();

        // Check for protection violation and access error indications.
        // If any error is indicated, clear the error flag.
        if (FSTAT & (FSTAT_PVIOL | FSTAT_ACCERR)) {
            if (FSTAT & FSTAT_PVIOL)  { FSTAT |= FSTAT_PVIOL;  }
            if (FSTAT & FSTAT_ACCERR) { FSTAT |= FSTAT_ACCERR; }
            return (ERASE_MEM_PVIOL_ACCERR_ERR);
        }

        // Wait for the flash command buffer to be ready for the next
        // command sequence.
        while (!(FSTAT & FSTAT_CBEIF));
    }

    //***** Erase block 0 one sector at a time *****
    // Do not erase the entire block as we do not want to erase the
    // boot code area. Recall that block 0 consists of pages
    // 0x3C-0x3F.
    for (PageFlash = 0x3C; PageFlash <= 0x3F; PageFlash++) {
        // Set the Flash Configuration Register to disable related interrupts,
        // disable writing security keys, and select the memory bank (block)
        // (block 0) containing sectors to be erased.
        FCNFG = 0;

        // Select the page within the block.
        PPAGE = PageFlash;

        // Verify that the buffers are ready to accept a new command.
        if ((FSTAT & FSTAT_CBEIF) == 0) {
            return (ERASE_MEM_BUFF_NOT_EMPTY);
        }

        // Erase the entire page one sector (256 words or 512 bytes) at a time.
        // Note than when placing an unbanked page number (i.e., 0x3E or 0x3F)
        // in the PPAGE register, that page can be seen twice in the MCU
        // memory map - once within the unbanked logical address (i.e.,
        // within [0x4000,0x7FFF] for page 0x3E or within [0xC000,0xFFFF] for
        // page 0x3F) and again within the paged logical address range
        // [0x8000,0xBFFF]. (See S12FTS256KV3/D V03.01 p. 15 NOTE 1)
        for (Addr1 = FLASH_PAGE_START_ADDR;
             Addr1 < FLASH_PAGE_END_ADDR;
             Addr1 += NUM_FLASH_BYTES_PER_SECTOR) {

            // Do not erase the boot code area
            if ((PageFlash == 0x3F) && (Addr1 >= BT_PAGE_ST_ADDR_BNKD)) {
                break;
            }

            // Buffers are ready so start the sector erase sequence:
            // (1) Write a dummy value to anywhere within the page.
            // (2) Write the sector erase command to the command buffer.
            // (3) Launch the command by writing a '1' to the CBEIF flag.
            *((volatile UINT16 *)Addr1) = 0xFFFF;
            FCMD   = FLASH_SECTOR_ERASE;
            FSTAT |= FSTAT_CBEIF;

            // Delay a little bit.
            NOP();
            NOP();

            // Check for protection violation and access error indications.
            // If any error is indicated, clear the error flag.
            if (FSTAT & (FSTAT_PVIOL | FSTAT_ACCERR)) {
                if (FSTAT & FSTAT_PVIOL)  { FSTAT |= FSTAT_PVIOL;  }
                if (FSTAT & FSTAT_ACCERR) { FSTAT |= FSTAT_ACCERR; }
                return (ERASE_MEM_PVIOL_ACCERR_ERR);
            }

            // Wait for the flash command buffer to be ready for the next
            // command sequence.
            while (!(FSTAT & FSTAT_CBEIF)) {;}
        }
    }

    // Wait for the last command to be completed.
    while (!(FSTAT & FSTAT_CCIF));

    return (ERASE_MEM_NO_ERROR);
}

#endif


//*********************************************************************
// eraseEEPROM
// This function mass erases the MC9S12DG256 internal EEPROM.
// This function assumes that the ECLKDIV register has already been
// set to divide the oscillator down to within [150,200] kHz.
// Function reference: S12EETS4KV1 pp. 16-19
// This function returns an error indicator as follows:
//   ERASE_MEM_NO_ERROR:          0   erase successful (no error)
//   ERASE_MEM_PVIOL_ACCERR_ERR:  1   PVIOL/ACCERR flag(s) set
//*********************************************************************
_NEAR static UINT8 eraseEEPROM(void)
{
    // Clear any previous protection and/or access error flag.
    ESTAT |= (ESTAT_PVIOL | ESTAT_ACCERR);

    // Wait for the EEPROM command buffer to be ready to accept a new command.
    while (!(ESTAT & ESTAT_CBEIF)) {;}

    // Buffers are ready so start the mass erase sequence:
    // (1) Write a dummy value to anywhere within the EEPROM.
    // (2) Write the mass erase command to the command buffer.
    // (3) Launch the command by writing a '1' to the CBEIF flag.
    *((volatile UINT16 *)EE_START_ADDR) = 0xFFFF;
    ECMD   = EE_MASS_ERASE;
    ESTAT |= ESTAT_CBEIF;

    // Delay a little bit.
    NOP();
    NOP();

    // Check for protection violation and access error indications.
    // If any error is indicated, clear the error flag.
    if (ESTAT & (ESTAT_PVIOL | ESTAT_ACCERR)) {
        if (ESTAT & ESTAT_PVIOL)  { ESTAT |= ESTAT_PVIOL;  }
        if (ESTAT & ESTAT_ACCERR) { ESTAT |= ESTAT_ACCERR; }
        return (ERASE_MEM_PVIOL_ACCERR_ERR);
    }

    // Wait for the mass erase command to complete.
    while (!(ESTAT & ESTAT_CCIF));

    return (ERASE_MEM_NO_ERROR);
}


//*********************************************************************
// programThenVerifyFlash
// This function programs data received in the FLASH-PROGRAM-THEN-VERIFY
// command one word at time, verifying each word after programming it.
// This function returns an error indicator as follows:
//   WRITE_MEM_NO_ERROR          0  write successful
//   WRITE_MEM_PVIOL_ACCERR_ERR  1  write protection violation or access error
//   WRITE_MEM_RESERVED_ERR      2  reserved (previously CLKDIV not written yet)
//   WRITE_MEM_RANGE_ERR         3  address or page out of range
//   WRITE_MEM_VERIFY_ERR        4  written value verification error
//*********************************************************************
_NEAR static UINT8 programThenVerifyFlash(void)
{
    // Determine the flash page number from the two address upper bytes.
    // Save the page number in TempUINT8.
	TempUINT16 =
        ((UINT16)BuffRx[IDX_ADDR_START_BYTE_2] << 8) +
        BuffRx[IDX_ADDR_START_BYTE_1];
    TempUINT8 = (UINT8)(TempUINT16 >> 6);

    // Check that the page number is valid.
    if ((TempUINT8 < 0x30) || (TempUINT8 > 0x3F)) {
        return(WRITE_MEM_RANGE_ERR);
    }

    // Calculate the logical (banked) start address. Note that the unbanked
    // pages (0x3E and 0x3F) will still show up in the banked memory
    // [0x8000,0xBFFF] if the page number is set in PPAGE. So, as long as
    // we always set PPAGE in this function, we can always work within
    // the banked memory range. (See S12FTS256KV3/D V03.01 p. 15 NOTE 1)
    // Use the lower 6 bits of BuffRx[IDX_ADDR_START_BYTE_1] and
    // all of BuffRx[IDX_ADDR_START_BYTE_0] to calculate the offset into the
    // bank window [0x8000, 0xBFFF].
	BuffRx[IDX_ADDR_START_BYTE_1] &= 0x3F;
	Addr1 = *((UINT16 *)&BuffRx[IDX_ADDR_START_BYTE_1]) + 0x8000; 

    // Calculate the logical end address (the address for writing
    // the last data byte).
    // Recall that the message length value is the number of bytes
    // excluding the framing byte so there is a "natural" minus 1
    // in the calculation.
    Addr2 = Addr1 + BuffRx[IDX_MSG_LEN_BYTE] - NUM_MSG_HDR_BYTES_FLASH;

    // Check the validity of the start and end addresses.
	if ((Addr1 < FLASH_PAGE_START_ADDR) ||
		(Addr2 > FLASH_PAGE_END_ADDR)) {
        return(WRITE_MEM_RANGE_ERR);
    }

    // Attempting to program in boot code area is ignored, but return
    // success value so an ACK will be sent back.
    if ((TempUINT8 == 0x3F) && (Addr2 >= BT_PAGE_ST_ADDR_BNKD)) {
        return (WRITE_MEM_NO_ERROR);
    }

    // Set the Flash Configuration Register to disable related interrupts,
    // disable writing security keys, and select the memory bank (block)
    // to be programmed.
    if      (TempUINT8 < 0x34) { FCNFG = 3; } // flash block 3
    else if (TempUINT8 < 0x38) { FCNFG = 2; } // flash block 2
    else if (TempUINT8 < 0x3C) { FCNFG = 1; } // flash block 1
    else                       { FCNFG = 0; } // flash block 0

    // Set the page to be programmed. This must be done even for the
    // unbanked pages so we can use banked memory logical addresses
    // for all pages.
    PPAGE = TempUINT8;

    // Now that PPAGE is set, we will use TempUINT8 to store the index
    // (within the received message buffer) of the data to program.

    // If the starting address is not on a word boundary (i.e., it is
    // an odd address), force it to be on a word boundary by decrementing
    // it (by 1) and pre-pend the value of the byte at the new start address
    // to the array of bytes to be programmed. (This will mean overwriting
    // the last header byte but we've already used the header bytes so
    // overwriting it is okay at this point.)
    if (Addr1 & 0x0001) {
        TempUINT8 = NUM_MSG_HDR_BYTES_FLASH - 1;
        Addr1--;
        BuffRx[TempUINT8] = *((volatile UINT8 *)Addr1);
    }
    else { // an even starting address
        TempUINT8 = NUM_MSG_HDR_BYTES_FLASH;
    }

    // If the ending address is not the end of a word (i.e., not an odd
    // address), force it to be odd by incrementing it (by 1) and appending
    // the value of the byte at the new end address to the array of bytes to
    // be programmed. (This will mean overwriting the checksum byte but we've
    // already used it so it's okay to overwrite it at this point.)
    if (!(Addr2 & 0x0001)) {
        Addr2++;
        BuffRx[BuffRx[IDX_MSG_LEN_BYTE]+1] = *((volatile UINT8*)Addr2);
    }

    // Wait for any flash command in progress to complete.
    while (!(FSTAT & FSTAT_CCIF));

    // Program the data one word at a time. After writing, verify that the
    // word was programmed correctly.
    while (Addr1 < Addr2) {

		// high + low bytes of a data word
		TempUINT16 = ((UINT16)BuffRx[TempUINT8] << 8) + BuffRx[TempUINT8+1];

        // Start the word programming sequence:
        // (1) Write the word to the desired address.
        // (2) Write the program word command to the command buffer.
        // (3) Launch the command by writing a '1' to the CBEIF flag.
        *((volatile UINT16 *)Addr1) = TempUINT16;
        FCMD   = FLASH_PROGRAM_WORD; // start command
        FSTAT |= FSTAT_CBEIF;        // Launch command by setting CBEIF

        // Delay a little bit.
        NOP();
        NOP();

        // Check for protection violation and access error indications.
        // If any error is indicated, clear the error flag.
        if (FSTAT & (FSTAT_PVIOL | FSTAT_ACCERR)) {
            if (FSTAT & FSTAT_PVIOL)  { FSTAT |= FSTAT_PVIOL;  }
            if (FSTAT & FSTAT_ACCERR) { FSTAT |= FSTAT_ACCERR; }
            return (ERASE_MEM_PVIOL_ACCERR_ERR);
        }

        // Wait for the word programming to complete.
        while (!(FSTAT & FSTAT_CCIF));

        // Verify that the word was correctly programmed.
        if (*((volatile UINT16*)Addr1) != TempUINT16) {
            return (WRITE_MEM_VERIFY_ERR);
        }

        // Increment data byte index and address to program for next time.
        TempUINT8 += BYTES_PER_WORD;
        Addr1     += BYTES_PER_WORD;

	}  // end of while (Addr1 < Addr2)

    return (WRITE_MEM_NO_ERROR);
}


//*********************************************************************
// programThenVerifyEEPROM
// This function programs data received in the EEPROM-PROGRAM-THEN-VERIFY
// command one word at time, verifying each word after programming it.
// This function returns an error indicator as follows:
//   WRITE_MEM_NO_ERROR          0  write successful
//   WRITE_MEM_PVIOL_ACCERR_ERR  1  write protection violation or access error
//   WRITE_MEM_RESERVED_ERR      2  reserved (previously CLKDIV not written yet)
//   WRITE_MEM_RANGE_ERR         3  address or page out of range
//   WRITE_MEM_VERIFY_ERR        4  written value verification error
//*********************************************************************
_NEAR static UINT8 programThenVerifyEEPROM(void)
{
    // Calculate the memory to program starting address. Note that only
    // bytes 2 and 1 are used (i.e., address start byte 0 is not sent).
    Addr1 = ((UINT16)BuffRx[IDX_ADDR_START_BYTE_2] << 8) +
            BuffRx[IDX_ADDR_START_BYTE_1];

    // Calculate the program ending address.
    Addr2 = Addr1 + BuffRx[IDX_MSG_LEN_BYTE] - NUM_MSG_HDR_BYTES_EEPROM;

    // Check the address validity.
    if ((Addr1 < EE_START_ADDR) ||
        (Addr2 > EE_END_ADDR)) {
        return (WRITE_MEM_RANGE_ERR);
    }

    // We will use TempUINT8 to store the index (within the received
    // message buffer) of the data to program.

    // If the starting address is not on a word boundary (i.e., it is
    // an odd address), force it to be on a word boundary by decrementing
    // it (by 1) and pre-pend the value of the byte at the new start address
    // to the array of bytes to be programmed. (This will mean overwriting
    // the last header byte but we've already used the header bytes so
    // overwriting it is okay at this point.)
    if (Addr1 & 0x0001) {
        TempUINT8 = NUM_MSG_HDR_BYTES_EEPROM - 1;
        Addr1--;
        BuffRx[TempUINT8] = *((volatile UINT8*)Addr1);
    }
    else { // an even starting address
        TempUINT8 = NUM_MSG_HDR_BYTES_EEPROM;
    }

    // If the ending address is not the end of a word (i.e., not an odd
    // address), force it to be odd by incrementing it (by 1) and appending
    // the value of the byte at the new end address to the array of bytes to
    // be programmed. (This will mean overwriting the checksum byte but we've
    // already used it so it's okay to overwrite it at this point.)
    if (!(Addr2 & 0x0001)) {
        Addr2++;
        BuffRx[BuffRx[IDX_MSG_LEN_BYTE]+1] = *((volatile UINT8*)Addr2);
    }

    // Wait for any EEPROM command in progress to complete.
    while (!(ESTAT & ESTAT_CCIF));

    // Program the data one word at a time. After writing, verify that the
    // word was programmed correctly.
    while (Addr1 < Addr2) {

        // Create the word to program from its component bytes.
        TempUINT16 = ((UINT16)BuffRx[TempUINT8] << 8) + BuffRx[TempUINT8+1];

        // Start the word programming sequence:
        // (1) Write the word to the desired address.
        // (2) Write the program word command to the command buffer.
        // (3) Launch the command by writing a '1' to the CBEIF flag.
        *((volatile UINT16*)Addr1) = TempUINT16;
        ECMD   = EE_PROGRAM_WORD;
        ESTAT |= ESTAT_CBEIF;

        // Delay a little bit.
        NOP();
        NOP();

        // Check for protection violation and access error indications.
        // If any error is indicated, clear the error flag.
        if (ESTAT & (ESTAT_PVIOL | ESTAT_ACCERR)) {
            if (ESTAT & ESTAT_PVIOL)  { ESTAT |= ESTAT_PVIOL;  }
            if (ESTAT & ESTAT_ACCERR) { ESTAT |= ESTAT_ACCERR; }
            return (ERASE_MEM_PVIOL_ACCERR_ERR);
        }

        // Wait for the word programming to complete.
        while (!(ESTAT & ESTAT_CCIF));

        // Verify that the word was correctly programmed.
        if (*((volatile UINT16*)Addr1) != TempUINT16) {
            return (WRITE_MEM_VERIFY_ERR);
        }

        // Increment data byte index and address to program for next time.
        TempUINT8 += BYTES_PER_WORD;
        Addr1     += BYTES_PER_WORD;
    }

    return (WRITE_MEM_NO_ERROR);
} 

//*********************************************************************
// processCommand
// This function processes a received bootloading command and puts a
// value in ErrorNum indicating whether an error occurred. A non-zero
// value indicates an error.
//*********************************************************************
_NEAR static void processCommand(void)
{
    switch (BuffRx[IDX_CMD_BYTE]) {
        case BT_CMD_FLASH_ERASE:
             ErrorNum = eraseFlash();
             break;

        case BT_CMD_EEPROM_ERASE:
             ErrorNum = eraseEEPROM();
             break;

        case BT_CMD_FLASH_PGM_VER:
             ErrorNum = programThenVerifyFlash();
             break;

        case BT_CMD_EEPROM_PGM_VER:
             ErrorNum = programThenVerifyEEPROM();
             break;

        default: // wrong command received
             ErrorNum = 1;
             break;
    }

    PPAGE = 0; // reset to page 0 (default)
    FCNFG = 0; // reset to block 0

    return;
}
