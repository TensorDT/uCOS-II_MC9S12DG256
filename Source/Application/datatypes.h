//********************************************************************
//
//  datatypes.h
//  Header file containing data types used within the project.
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
//********************************************************************

// Avoid multiple inclusions
#ifndef _datatypes_h
#define _datatypes_h

//--------------------------- Included Files --------------------------
// none

//-------------------------- Type Definitions -------------------------
// Use these definitions for portability and clarity
typedef  signed char        CHAR;
typedef  unsigned char      UCHAR;
typedef  signed char        INT8;
typedef  unsigned char      UINT8;
typedef  signed short       INT16;     // also signed int
typedef  unsigned short     UINT16;    // also unsigned int
typedef  signed long        INT32;
typedef  unsigned long      UINT32;
typedef  float              FLOAT32;
typedef  double             FLOAT64;
typedef  unsigned int       BITFIELD;
typedef  signed char        BOOL;

#ifndef BYTE
typedef  signed char        BYTE;
#endif

#ifndef UBYTE
typedef  unsigned char      UBYTE;
#endif

typedef struct {
    UBYTE byte1;  // most-significant byte
    UBYTE byte0;  // least-significant byte
} TWO_BYTE_ST;

typedef struct {
    UBYTE byte3;  // most-significant byte
    UBYTE byte2;
    UBYTE byte1;
    UBYTE byte0;  // least-significant byte
} FOUR_BYTE_ST;

typedef union {
    INT16  valInt16;
    UINT16 valUInt16;
	TWO_BYTE_ST byte_ST;
} CNVRT_16BITS_TO_BYTES_UN;

typedef union {
    INT32  valInt32;
    UINT32 valUInt32;
	FOUR_BYTE_ST byte_ST;
} CNVRT_32BITS_TO_BYTES_UN;

//------------------------ Constant Definitions -----------------------
// NOTE! Do NOT use the COSMIC limits.h file as it defines
//       CHAR_MIN=0 and CHAR_MAX=255 whereas for the datatypes defined
//       above, CHAR_MIN=-128 and CHAR_MAX=127.
#define INT8_MIN            (-128)
#define INT8_MAX            ( 127)
#define UINT8_MAX           ( 255)
#define INT16_MIN           (-32768)
#define INT16_MAX           ( 32767)
#define UINT16_MAX          ( 65535)
#define INT32_MIN           (-2147483648)
#define INT32_MAX           ( 2147483647)
#define UINT32_MAX          ( 4294967295)
#define FLOAT32_MIN         (1.17549435E-38F)
#define FLOAT32_MAX         (3.40282347E+38F)
#define FLOAT64_MIN         (2.225073858507201E-308)
#define FLOAT64_MAX         (1.797693134862315E+308)


#ifndef TRUE
#define TRUE       (1==1)
#define FALSE      (0==1)
#endif

//------------------------------- Macros ------------------------------
// none

//---------------------- Extern Global Variables ----------------------
// none

//------------------------ Function Prototype(s) ----------------------
// none


#endif