//*********************************************************************
//
//  File name:  mc9s12dg256_booting.c
//
//  Purpose:    Boot module
//
//  Target:     MC9S12DG256-based board
//
//  Revisions:
//   ##  dd mmm yyyy  who  description
//    1  03 Nov 2020  GPM  Initial revision (based on CTF Recorder
//                         board booting.c file).
//
//
//  Notes:
//    IMPORTANT!!!
//      This module *MUST* be located following the mc9s12dg256_startup.s
//      module in the sector beginning at physical address 0xFF600
//      (logical address 0xF600).
//
//  (c) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
//  (p) 2020 Tensor Drilling Technologies, Inc. All rights reserved.
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
// Make sure that enums use the smallest data size so that this enum
// is a 1-byte data size.
typedef enum {
    DIR_COMP_GREATER_THAN = 0,
    DIR_COMP_LESS_THAN    = 1
} DIR_COMP_ENUM;

//------------------------ Constant Definitions -----------------------
#define BL_ROM_ADDR_START      (0xF800)
#define BL_RAM_ADDR_START      (0x3A00)
#define BL_RAM_ADDR_END        (0x3EFF)

//------------------------------- Macros ------------------------------
// none

//-------------------------- Module Variables -------------------------
// none

//-------------------------- Global Variables -------------------------
// These variables MUST be located below the RAM area that will be used
// for executing the bootloader code (i.e., below 0x3A00). These
// variables are only used during the bootloading process.
// NOTE: These variable are located in RAM at addresses below where the
//       bootloader code will reside. There are also variables declared
//       in bootloader.c; make sure these variables do not overlap with
//       the ones in bootloader.c.
UINT8         BuffRx[64]     @0x3900;  // Rx buffer, up to 0x393F
UINT8         ByteUpperCase  @0x39E0;
UINT8         CntrTimeout    @0x39E1;
UINT8         IdxByte        @0x39E2;
DIR_COMP_ENUM DirComparison  @0x39E3;
BOOL          WasBLCmdRcvd   @0x39E4;

//------------------------------ Functions ----------------------------
//*********************************************************************
// initHardware
// This function initializes the MC9S12DG256 processor registers
// to define the memory map and properly configure the I/O pins.
//*********************************************************************
_NEAR static void initHardware(void)
{
    //*************** Misc Core Registers ****************
    INTCR  = 0x00;           // External interrupt is disabled
    EBICTL = 0x00;           // NO ECLK stretches

    // use these values for INITRG, INITEE and INITRM
    // memory map is:
    // $0000 to $03FF: registers ( 1 KB)
    // $0400 to $0FFF: EEPROM    ( 3 KB)
    // $1000 to $3FFF: RAM       (12 KB)
    INITRG = 0x00;           // REGISTERS in default location: 0x0000 to 0x03FF
    INITEE = 0x01;           // EEPROM (4KB-1KB=3KB) is at 0x0400 to 0x0FFF
    INITRM = 0x11;           // RAM is aligned upward; is 12KB block: 0x1000 to 0x3FFF

    // MISC:B3  EXSTR1       EXSTR1:0 determine number of E clock stretches
    // MISC:B2  EXSTR0                for accessing external memory
    // MISC:B1  ROMHM        (0) enables access of internal flash lower half ($4000 - $7FFF)
    // MISC:B0  ROMON        (1) enables, (0) disables internal flash
    MISC   = 0x01;           // FLASH enabled in memory map, upper half only.

    // MODE:B7  MODC         MODC:A determine operating mode of processor.
    // MODE:B6  MODB                100 = Normal Single Chip
    // MODE:B5  MODA                101 = Normal Expanded Narrow
    // MODE:B3  IVIS         (1) Makes internal bus operations visible on ext bus
    // MODE:B1  EMK          (1) Removes Port K from memory map in any expanded mode
    // MODE:B0  EME          (1) Removes Port E from memory map in any expanded mode
    MODE   = 0x80;           // Normal Single Chip mode

    MODRR |= 0x10;           // bit 4 is for re-assigning SPI0 to Port M

    //************** CLOCK  REGISTER SETUP *********************
    CRGINT = 0x00;           // All CRG interrupts disabled

    // SYSTEM CLOCK = 4915200 HZ; BUS CLOCK = SYSTEM CLOCK / 2 = 2457600 Hz
    // CLKSEL:B7  PLLSEL     System clock is OSCCLK(0) or PLLCLK(1)
    // CLKSEL:B6  PSTP       Osc enabled(1) or disabled(0) in STOP mode
    // CLKSEL:B5  SYSWAI     System Clock Stops(1) or Runs(0) in WAIT mode
    // CLKSEL:B4  ROAWAI     Reduced(1) Osc Amplitude in WAIT
    // CLKSEL:B3  PLLWAI     PLL stops(1) in WAIT
    // CLKSEL:B2  CWAI       Core clock stops(1) in WAIT
    // CLKSEL:B1  RTIWAI     RTI stops(1) in WAIT
    // CLKSEL:B0  COPWAI     COP stops(1) in WAIT
    CLKSEL = 0x00;           // OSCCLK is system clock - nobody stops ever

    PLLCTL = 0x80;           // Clock monitor on, PLL off
    RTICTL = 0x00;           // No idea what this does?
    COPCTL = 0x00;           // COP control register - COP disabled

    //************** CORE BLOCK REGISTER SETUP *********************
    // Setup pullup and drive levels for ports
    PUCR   = 0x12;           // PORTB/E pullups enabled
    RDRIV  = 0x00;           // Full drive capability

    // Setup PORTA
    // Data Direction Register: 0=input, 1=output
    // PA7 : TP3             output:0
    // PA6 : A2              input
    // PA5 : A1              input
    // PA4 : A0              output:1 ???
    // PA3 : 5VCNTRL         output:0
    // PA2 : ???             output:0
    // PA1 : ???             output:0
    // PA0 : Not Used        input
    DDRA   = 0xFF;  // previously 0x9E
    PORTA  = 0x0F;  // previously 0x10

    // Setup PORTB
    // Data Direction Register: 0=input, 1=output
    // PB7 : NU              input
    // PB6 : NU              input
    // PB5 : NU              input
    // PB4 : NU              input
    // PB3 : NU              input
    // PB2 : NU              input
    // PB1 : MODB_U          input
    // PB0 : MODA_U          input
    DDRB  = 0x00;
    PORTB = 0x00;

    // Setup PORTE
    // PEAR7 : NOACCE        WRITE ONCE! 0 PE7 GPIO,    1 CPU CYCLE FREE INDICATOR
    // PEAR6 : 0
    // PEAR5 : PIPOE         WRITE ONCE! 0 PE5-6 GPIO,  1 CPU INSTR QUEUE
    // PEAR4 : NECLK                     0 PE4 IS ECLK, 1 PE4 IS GPIO
    // PEAR3 : LSTRE         WRITE ONCE! 0 PE3 GPIO,    1 PE4 IS /LSTRB BUS CTRL
    // PEAR2 : RDWE          WRITE ONCE! 0 PE2 GPIO,    1 PE2 IS R/~W BUS CTRL
    // PEAR1 : 0
    // PEAR0 : 0
    PEAR   = 0x10;           // PE4 is GPIO, no R/W for PE2

    // Setup PORTE
    // Data Direction Register: 0=input, 1=output
    // PE7 :                 input
    // PE6 :                 input
    // PE5 :                 input
    // PE4 :                 output ???
    // PE3 : Not Used        input
    // PE2 : Not Used        input
    // PE1 : IRQ\            input (pulled high)
    // PE0 : XIRQ\           input (pulled high)
    DDRE = 0x00;             // previously 0x10
    PORTE = 0x00;

    //**************** EXPANDED PORTS  REGISTER SETUP *********************/

    //************* PORT S SCI0 *******************
    // Setup PORTS
    // Data Direction Register: 0=input, 1=output
    // PS7 : NU              input
    // PS6 : NU              input
    // PS5 : NU              input
    // PS4 : NU              input
    // PS3 : Not Used        input
    // PS2 : Not Used        input
    // PS1 : TX              output
    // PS0 : QBUS_RCVR       input
    DDRS   = 0x02;
    RDRS   = 0x00;           // Full (0) or reduced (1) drive outputs
    PERS   = 0x00;           // Pull up/dwn enabled (1) or disabled (0)
    PPSS   = 0x00;           // Pull up (0) or pull down (1) for pins with PERT enabled
    WOMS   = 0x00;           // Outputs operate open-drain(1), wired-or, or push-pull(0)
    PTS    = 0x02;

    //************* PORT T GPIO *****************************
    // Setup PORTT
    // Data Direction Register: 0=input, 1=output
    // PT7 : GAMMA_U         input
    // PT6 : ST_X            input?
    // PT5 : ST_Z            input?
    // PT4 : No Connect      input
    // PT3 : DCE3\           output:1
    // PT2 : DCE2\           output:1
    // PT1 : DCE1\           output:1
    // PT0 : DCE0\           output:1
    DDRT   = 0x6F;
    RDRT   = 0x00;           // Full (0) or Reduced (1) drive outputs
    PERT   = 0x00;           // Pull up/dwn enabled (1) or disabled (0)
    PPST   = 0x00;           // Pull up (0) or pull down (1) for pins with PERT enabled
    PTT    = 0x0F;

    // Pulse Accumulator Setup
    // PACTL7 : 0            always 0
    // PACTL6 : 0            pulse accumulator system disabled
    // PACTL5 : 0            event counter mode
    // PACTL4 : 0            falling edge sensitive
    // PACTL3 : 0            use prescaler clock as timer counter clock
    // PACTL2 : 0            use prescaler clock as timer counter clock
    // PACTL1 : 0            interrupt if overflow
    // PACTL0 : 0            no interrupt on pulse input
    PACTL = 0x00;

    //************* PORT M GPIO *************************
    // Setup PORTM
    // Data Direction Register: 0=input, 1=output
    // SPI-related pins will be configured via SPI config regs
    // PM7 : Non-existent    input
    // PM6 : Non-existent    input
    // PM5 : SCK0            output:0
    // PM4 : MOSI0           output:1
    // PM3 : Not used        output:1
    // PM2 : MISO0           input
    // PM1 : TX_EN           output:1
    // PM0 : Not used        input
    DDRM  = 0x3A;            // Note SPI, CAN, BDLC registers overide the DDRM
    PTM   = 0x1A;
    RDRM  = 0x00;
    PERM  = 0x00;
    PPSM  = 0x00;
    WOMM  = 0x00;

    //************* PORT P SPI1/GPIO *******************
    // Data Direction Register: 0=input, 1=output
    // PORTP is the default PWM port. Note that PTP:6 does not
    // exist in the 80-pin package. PWM and SPI1 if routed to PTP
    // and ENABLED will overide port settings.
    // Setup PORTP
    // PP7 : Not used        input
    // PP6 : Non-existent    input
    // PP5 : Not used        input
    // PP4 : BATCTR          output:0
    // PP3 : Not used        output:1
    // PP2 : SCK1            output:0
    // PP1 : MOSI1           output:1; default is high
    // PP0 : MISO1           input
    DDRP   = 0x1E;           // Data Direction Register (0)Input, (1) Output
    PTP    = 0x0A;           // Port P
    RDRP   = 0x00;           // Full (0) or reduced (1) drive outputs
    PERP   = 0x00;           // Pull up/down enabled (1) or disabled (0)
    PPSP   = 0x00;           // Pull up (0) or pull down (1) for pins with PERT enabled
    PIEP   = 0x00;           // Enables (1) external int for each pin of Port P
    PIFP   = 0x00;           // Ext port P int flag register, reset by writing "1"

    //************* PORT J I2C BUS *************************
    // Setup PORTJ
    // Data Direction Register: 0=input, 1=output
    // PJ7 : SCL - N/C       input
    // PJ6 : SDA - N/C       input
    // PJ5 : Non-existent    input
    // PJ4 : Non-existent    input
    // PJ3 : Non-existent    input
    // PJ2 : Non-existent    input
    // PJ1 : Non-existent    input
    // PJ0 : Non-existent    input
    DDRJ   = 0x00;           // Data Direction Register (0)Input, (1) Output
    PTJ    = 0x00;
    RDRJ   = 0x00;
    PERJ   = 0x00;
    PPSJ   = 0x00;

    // ATD CTL2 Setup:
    // ATD0CTL2.7            ADPU off
    // ATD0CTL2.6            AFFC off (fast flag clear flag)
    // ATD0CTL2.5            AWAI off (stop during wait mode)
    // ATD0CTL2.4            always 0
    // ATD0CTL2.3            always 0
    // ATD0CTL2.2            always 0
    // ATD0CTL2.1            ASCIE off (sequence complete interrupt enable)
    // ATD0CTL2.0            ASCIF (read only)
    ATD0CTL2 = 0x00;

    // enable free-running timer and access it via TCNT register
    // TSCR1 Setup:
    // TSCR1.7               TEN enabled (timer enable bit)
    // TSCR1.6               TSWAI continuous during wait
    // TSCR1.5               TSBCK run in background mode
    // TSCR1.4               TFFCA normal flag clearing
    // TSCR1.3               always 0
    // TSCR1.2               always 0
    // TSCR1.1               always 0
    // TSCR1.0               always 0
    TSCR1  = 0x80;

    // TSCR2 Setup:
    // TSCR2.7               if =0, TOI inhibited (timer overflow interrupt)
    // TSCR2.6               always 0
    // TSCR2.5               PUPT pullup disabled (timer pullup resister enable)
    // TSCR2.4               RDPT normal drive (timer drive reduction)
    // TSCR2.3               TCRE counter freeruns (timer counter reset enable)
    // TSCR2.2               PR2 prescaler factor (timer prescaler select)
    // TSCR2.1               PR1 prescaler factor (timer prescaler select)
    // TSCR2.0               PR0 prescaler factor (timer prescaler select)
    TSCR2  = 0x02;           // tmr clock = BUS CLOCK / 4 = 2457600 / 4 = 614400 HZ

    // disable all timer functions from pin logic
    TCTL1  = 0x00;
    TCTL2  = 0x00;
    TCTL3  = 0x00;
    TCTL4  = 0x00;

    // Set baud rate...
    SCI0BD = BAUD19200;

    // SCI1 is not used (no connect)

    // SCI0CR1 Setup:
    // SCI0CR1.7             LOOPS tx/rx normal (single wire mode)
    // SCI0CR1.6             WOMS normal drive (wired-or mode)
    // SCI0CR1.5             RSRC na
    // SCI0CR1.4             M 1 start, 1 stop, 8 data bits
    // SCI0CR1.3             WAKE na
    // SCI0CR1.2             ILT na
    // SCI0CR1.1             PE parity disabled
    // SCI0CR1.0             PT na
    SCI0CR1 = 0x00;

    // SCI0CR2 Setup:
    // SCI0CR2.7             TIE disabled (enabled by SCI ISR)
    // SCI0CR2.6             TCIE disabled (enabled by SCI ISR)
    // SCI0CR2.5             RIE disabled when in receive mode
    // SCI0CR2.4             ILIE disabled
    // SCI0CR2.3             TE disabled
    // SCI0CR2.2             RE disabled
    // SCI0CR2.1             RWU normal SCI receiver
    // SCI0CR2.0             SBK break generator off
    SCI0CR2 = 0x04;          // Enable receiver

    // SPI0CR2 Setup:
    // SPI0CR2.7             always 0
    // SPI0CR2.6             always 0
    // SPI0CR2.5             always 0
    // SPI0CR2.4             MODFEN (0=SS pin not used by SPI)
    // SPI0CR2.3             BIDIROE (0=output buffer disabled)
    // SPI0CR2.2             always 0
    // SPI0CR2.1             SPISWAI
    // SPI0CR2.0             SPC0 normal MISO, MOSI
    SPI0CR2 = 0x00;          // CHECK ME!!! CTF inits this to 0x08 (output buffer enabled)

    // SPI0CR1 Setup:
    // SPI0CR1.7 : 0         SPIE disabled (SPI interrupt enable bit)
    // SPI0CR1.6 : 1         SPE enabled (SPI system enable bit)
    // SPI0CR1.5 : 0         SPTEF interrupt disabled
    // SPI0CR1.4 : 0         Slave mode (master/slave select bit)
    // SPI0CR1.3 : 1         CPOL = 1 (SCLK polarity)
    // SPI0CR1.2 : 1         CPHA = 1 (SCLK phase)
    // SPI0CR1.1 : 0         SSOE disabled (SS output enable bit)
    // SPI0CR1.0 : 0         LSBF msb first (LSB first enable bit)
    SPI0CR1 = 0x4C;

    // SPI0 baud rate = bus clock / baud rate divisor
    // baud rate divisor = (SPPR+1)x2^(SPR+1)
    // Set SPPR = 0, SPR = 1 so baud rate divisor is 4
    SPI0BR  = 0x01;

    // clear SPIF flag
    ByteUpperCase = SPI0SR;
    ByteUpperCase = SPI0DR;

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
    UINT8  cntr1msLoop;
    
    for (cntr_ms=0; cntr_ms<delay_ms; cntr_ms++) {
        for (cntr1msLoop=0; cntr1msLoop<149; cntr1msLoop++) {
            NOP();
        }
    }

    return;
}

//*********************************************************************
// copyBootloaderToRAM
// This function copies the bootloader (up to 1280 bytes) code from
// flash memory to RAM so that the flash memory can be erased and
// re-programed with the new code downloaded.
//
// The bootloader is copied from flash (ROM) addresses 0xFA00-0xFEFF
// to RAM addresses 0x3A00-0x3EFF.
//*********************************************************************
_NEAR static void copyBootloaderToRAM(void)
{
    volatile UINT16* pROM;   // pointer to ROM boot code address
    volatile UINT16* pRAM;   // pointer to RAM boot code address

    pROM = (UINT16*)BL_ROM_ADDR_START;  // load start of ROM boot code
    pRAM = (UINT16*)BL_RAM_ADDR_START;  // load start of RAM boot code

    while(pRAM <= (volatile UINT16*)BL_RAM_ADDR_END) {
        // Load word of ROM boot code to RAM and update pointers.
        *pRAM++ = *pROM++;   
    }

    return;
}

//*********************************************************************
// Booting
// This function is the first step before a possible bootloading
// right after a power reset.
//*********************************************************************
_NEAR void Booting(void)
{
#define TIMEOUT_20_CENTISEC  (20)

    CntrTimeout = 0;
    IdxByte = 0;
    DirComparison = DIR_COMP_GREATER_THAN;
    WasBLCmdRcvd = BFALSE;

    // Turn of interrupts before initialization.
    INTR_OFF();

    // Initialize the processor's internal hardware.
    // Default to receiving and a free-running, 16-bit timer
    initHardware();

    while ((CntrTimeout < TIMEOUT_20_CENTISEC) && // a timeout of about 2sec
            !WasBLCmdRcvd) {                      // no Enq received
        if (SCI0SR1 & 0x20)  {                    // received a byte?
            // Yes, get the byte.
            ByteUpperCase = SCI0DRL;

            switch (IdxByte) {
                case 0:
                     if (ByteUpperCase == 'B') { // don't increment IdxByte until receiving 'B'
                         IdxByte++;
                     }
                     break;

                case 1:
                     if (ByteUpperCase != 'L') {
                         // Skip bootloading; jump to application code start.
                         #pragma asm
                             jmp $4000
                         #pragma endasm
                     }
                     IdxByte++;
                     break;

                case 2:
                     if (ByteUpperCase != '2') {
                         // The bootload isn't for this device (node 0x20).
                         //   Wait for reset following other qBUS node
                         //   bootloading completion.
                         while(BTRUE);
                     }
                     IdxByte++;
                     break;

                case 3:
                     if (ByteUpperCase != '0') {
                         // The bootload isn't for this device (node 0x20).
                         //   Wait for reset following other qBUS node
                         //   bootloading completion.
                        while(BTRUE);
                     }
                     else {
                         WasBLCmdRcvd = BTRUE;
                     }
                     break;

            }  // end of switch (IdxByte)

        }  // end of 'if byte received'

        // Increment timeout whenever the 16-bit timer crosses 0x8000
        if (DirComparison == DIR_COMP_GREATER_THAN) {  // '>' comparison
            if (TCNT > 0x8000) {
                CntrTimeout++;
                DirComparison = DIR_COMP_LESS_THAN;    // changed to '<'
            }
        }
        else { // '<' comparison
            if (TCNT < 0x8000) {
                DirComparison = DIR_COMP_GREATER_THAN; // changed to '>'
            }
        }

    }  // end of while() loop

    // Jump to application start if there is no bootloading process going on
    if (!WasBLCmdRcvd) {
        #pragma asm
            jmp $4000
        #pragma endasm
    }

#if defined DEBUG
    delayMilliseconds(1);    // Shortened delay due to debugger sluggishness
#else
    delayMilliseconds(30);   // Delay 30ms before sending an ACK
#endif

    TX_MODE();               // Switch to transmit mode

    SCI0DRL = ACK;           // Send an ACK
    // Wait for ACK transmission to complete
    while (!(SCI0SR1 & 0x40));

    RX_MODE();               // Return back to receive mode
    // Read SCI0 status and data registers to clear any interrupt bit
    ByteUpperCase = SCI0SR1;
    ByteUpperCase = SCI0DRL;

    // Copy the bootloader code from flash to RAM (beginning at RAM
    // address 0x3A00).
    copyBootloaderToRAM();

// Make sure that the bootloader RAM start address is 0x3A00
// so we jump to the right address below.
#if (BL_RAM_ADDR_START != 0x3A00)
#error BL_RAM_ADDR_START invalid
#endif

    // Re-initialize the stack pointer and jump to RAM address 0x3A00
    // to execute bootloader code.
    #pragma asm
        xref __stack
        lds #__stack
        jmp $3A00
    #pragma endasm

    return;
}
