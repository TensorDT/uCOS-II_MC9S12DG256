REM       COMMAND FILE BUILT BY IDEA 
REM       Thu Dec 10 09:51:15 2020
REM
cx6812 -ep -cl".\Build-Debug" -co".\Build-Debug" -av -l -i".\uC-aOS2" -i".\MC9S12DG256" -i".\Application" -i"c:\program files (x86)\cosmic\cx12\h6812" "mc9s12dg256\crtsi_s256.s"
cx6812 -ep -cl".\Build-Debug" -co".\Build-Debug" -av -l -i".\uC-aOS2" -i".\MC9S12DG256" -i".\Application" -i"c:\program files (x86)\cosmic\cx12\h6812" "mc9s12dg256\mc9s12dg256_startup.s"
cx6812 -ep -cl".\Build-Debug" -co".\Build-Debug" -av -l -i".\uC-aOS2" -i".\MC9S12DG256" -i".\Application" -i"c:\program files (x86)\cosmic\cx12\h6812" "mc9s12dg256\os_cpu_a.s"
cx6812 -v -l +debug -dDEBUG -cl".\Build-Debug" -co".\Build-Debug" -i".\uC-OS2" -i".\MC9S12DG256" -i".\Application" -i"c:\program files (x86)\cosmic\cx12\h6812" "application\software_traps.c" "application\test.c" "application\time.c" "mc9s12dg256\mc9s12dg256_booting.c" "mc9s12dg256\mc9s12dg256_jump_table.c" "mc9s12dg256\mc9s12dg256_vectors.c" "mc9s12dg256\os_cpu_c.c" "uc-os2\os_core.c" "uc-os2\os_dbg_r.c" "uc-os2\os_flag.c" "uc-os2\os_mbox.c" "uc-os2\os_mem.c" "uc-os2\os_mutex.c" "uc-os2\os_q.c" "uc-os2\os_sem.c" "uc-os2\os_task.c" "uc-os2\os_time.c" "uc-os2\os_tmr.c"
cx6812 -v -l +debug +pic -cl".\Build-Debug" -co".\Build-Debug" -i".\uC-OS2" -i".\MC9S12DG256" -i".\Application" -i"c:\program files (x86)\cosmic\cx12\h6812" "mc9s12dg256\mc9s12dg256_bootloader.c"
clnk -l"C:\Program Files (x86)\COSMIC\CX12\LIB" -l".\Build-Debug" -p -o ".\Build-Debug\uCOS-II_MC9S12DG256.h12" -m ".\Build-Debug\uCOS-II_MC9S12DG256.map" -l"C:\Program Files (x86)\COSMIC\CX12\Lib" -l".\Build-Debug" ".\application\ucos-ii_mc9s12dg256-debug.lkf"
chex -fm -pn -o ".\Build-Debug\uCOS-II_MC9S12DG256.s19" ".\Build-Debug\uCOS-II_MC9S12DG256.h12"
clabs ".\Build-Debug\uCOS-II_MC9S12DG256.h12"
