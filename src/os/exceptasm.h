#ifndef _EXCEPTASM_H
#define _EXCEPTASM_H
#include <ultratypes.h>// Offsets of members in the OSThread struct
#define THREAD_NEXT      0
#define THREAD_PRI       4
#define THREAD_QUEUE     8
#define THREAD_TLNEXT    12
#define THREAD_STATE     16
#define THREAD_FLAGS     18
#define THREAD_ID        20
#define THREAD_FP        24
#define THREAD_GP1       32
#define THREAD_GP2       40
#define THREAD_GP3       48
#define THREAD_GP4       56
#define THREAD_GP5       64
#define THREAD_GP6       72
#define THREAD_GP7       80
#define THREAD_GP8       88
#define THREAD_GP9       96
#define THREAD_GP10      104
#define THREAD_GP11      112
#define THREAD_GP12      120
#define THREAD_GP13      128
#define THREAD_GP14      136
#define THREAD_GP15      144
#define THREAD_GP16      152
#define THREAD_GP17      160
#define THREAD_GP18      168
#define THREAD_GP19      176
#define THREAD_GP20      184
#define THREAD_GP21      192
#define THREAD_GP22      200
#define THREAD_GP23      208
#define THREAD_GP24      216
#define THREAD_GP25      224
// k0 and k1 are reserved for the kernel
#define THREAD_GP28      232
#define THREAD_GP29      240
#define THREAD_GP30      248
#define THREAD_GP31      256
#define THREAD_LO        264
#define THREAD_HI        272
#define THREAD_SR        280
#define THREAD_PC        284
#define THREAD_CAUSE     288
#define THREAD_BADVADDR  292
#define THREAD_RCP       296
#define THREAD_FPCSR     300
#define THREAD_FP0       304
#define THREAD_FP2       312
#define THREAD_FP4       320
#define THREAD_FP6       328
#define THREAD_FP8       336
#define THREAD_FP10      344
#define THREAD_FP12      352
#define THREAD_FP14      360
#define THREAD_FP16      368
#define THREAD_FP18      376
#define THREAD_FP20      384
#define THREAD_FP22      392
#define THREAD_FP24      400
#define THREAD_FP26      408
#define THREAD_FP28      416
#define THREAD_FP30      424

#define MESG(type) (type << 3)

#define MQ_MTQUEUE 0
#define MQ_FULLQUEUE 4
#define MQ_VALIDCOUNT 8
#define MQ_FIRST 12
#define MQ_MSGCOUNT 16
#define MQ_MSG 20

#define OS_EVENTSTATE_MESSAGE_QUEUE 0
#define OS_EVENTSTATE_MESSAGE 4

// __osHwInt struct member offsets
#define HWINTR_CALLBACK 0x00
#define HWINTR_SP       0x04

// __osHwInt struct size
#define HWINTR_SIZE     0x8

#ifdef _LANGUAGE_C
extern s32 (*__osHwIntTable[])(void); //maybe 6? or 9
#endif 

#endif
