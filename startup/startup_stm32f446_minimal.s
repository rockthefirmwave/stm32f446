.syntax unified
.cpu cortex-m4
.thumb

.section .isr_vector, "a", %progbits
.type g_pfnVectors, %object
.size g_pfnVectors, .-g_pfnVectors

g_pfnVectors:
    .word _estack                 // initial stack pointer
    .word Reset_Handler           // reset vector


.section .text.Reset_Handler
.weak Reset_Handler
.type Reset_Handler, %function

Reset_Handler:
    // Копирование .data из FLASH в RAM
    ldr r0, =_sdata
    ldr r1, =_edata
    ldr r2, =_sidata
.LoopCopyData:
    cmp r0, r1
    ittt lt
    ldrlt r3, [r2], #4
    strlt r3, [r0], #4
    blt .LoopCopyData

    // Очистка .bss
    ldr r0, =_sbss
    ldr r1, =_ebss
    movs r2, #0
.LoopBss:
cmp r0, r1
    it lt
    strlt r2, [r0], #4
    blt .LoopBss

    bl main2
    b .