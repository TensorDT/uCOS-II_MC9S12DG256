#ifndef INCLUDES_H
#define INCLUDES_H

/*
*********************************************************************************************************
*                                           Master Include File (from uCOS-II)
*
* File : includes.h
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*                                           FILES TO INCLUDE
*********************************************************************************************************
*/

                                                                /* ---------------- STD INCLUDE FILES ----------------- */
#include  <string.h>                                            
#include  <stddef.h>

                                                                /* ---------------- CPU INCLUDE FILES ----------------- */    
#include "iosdg256.h"

                                                                /* -------------- MICRIUM INCLUDE FILES --------------- */
#include "os_cpu.h"
/* #include "..\..\ucos_ii.h" */
                                                                
#include  "cpu_def.h"	                                        /* uC/CPU, processor specifics.                         */
#include  "cpu.h"
#include  <ucos_ii.h>				                            /* uC/OS-II.         		                            */			  	   

#endif                                                          /* End of file.                                         */


