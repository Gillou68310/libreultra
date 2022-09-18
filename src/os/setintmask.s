#include "asm_helper.h"
#include <rcp.h>

#define MI_INTR_MASK ((1 << 6) - 1)

.globl __osRcpImTable

.text
.set noreorder
LEAF(osSetIntMask) 
    mfc0 ta0, C0_SR

    andi v0, ta0, OS_IM_CPU

    la t0, __OSGlobalIntMask
    lw t3, 0(t0)
 
    xor t0, t3,-1
    andi t0, t0,(SR_IMASK)
    or v0, v0,t0

    lw t2, PHYS_TO_K1(MI_INTR_MASK_REG)
    beqz t2, 1f
    srl t1, t3,0x10

    xor t1, t1,-1
    andi t1, t1, MI_INTR_MASK
    or t2, t2,t1
1:
    sll t2, t2,0x10
    or v0, v0,t2

    and t0, a0, MI_INTR_MASK<<0x10
    and t0, t0,t3
    srl t0, t0,0xf
    lhu t2, __osRcpImTable(t0)
    sw t2, PHYS_TO_K1(MI_INTR_MASK_REG)
 
    andi t0, a0, OS_IM_CPU
    andi t1, t3, SR_IMASK
    and t0, t0,t1

    and ta0, ta0, ~SR_IMASK
    or ta0, ta0,t0

    mtc0 ta0, C0_SR
    nop
    nop
    jr ra
    nop
END(osSetIntMask)

.rdata
EXPORT(__osRcpImTable)
/* LUT to convert between MI_INTR and MI_INTR_MASK */
/* MI_INTR is status for each interrupt whereas    */
/* MI_INTR_MASK has seperate bits for set/clr      */
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_CLR_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_CLR_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_CLR_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_CLR_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_CLR_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_CLR_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
.half MI_INTR_MASK_SET_SP | MI_INTR_MASK_SET_SI | MI_INTR_MASK_SET_AI | MI_INTR_MASK_SET_VI | MI_INTR_MASK_SET_PI | MI_INTR_MASK_SET_DP
