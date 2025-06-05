.section __TEXT,__text
.global _main
.p2align 2

#define SYSCALL_CLASS_SHIFT	24
#define SYSCALL_CLASS_MASK	(0xFF << SYSCALL_CLASS_SHIFT)
#define SYSCALL_NUMBER_MASK	(~SYSCALL_CLASS_MASK)

#define SYSCALL_CLASS_NONE	0	/* Invalid */
#define SYSCALL_CLASS_MACH	1	/* Mach */	
#define SYSCALL_CLASS_UNIX	2	/* Unix/BSD */
#define SYSCALL_CLASS_MDEP	3	/* Machine-dependent */
#define SYSCALL_CLASS_DIAG	4	/* Diagnostics */

/* 
    syscall_number = (SYSCALL_CLASS_BSD << 24) | BSD_SYSCALL_NUM 
    ...
    */
#define SYS_EXIT  0x1
#define SYS_WRITE 0x0004

_print:
    movz x8, 0x4
    movk x8, #0x20, lsl #16
    mov x0, #0
    mov x1, mbuf
    mov x2, #22
    svc #0x80

_exit:
    mov  x0, #0
    movz x8, #0x0001
    movk x8, #0x20, lsl #16
    svc #0x80
_main:
    b _print
    ret

; .sectiombufn __TEXT,__cstring
.data
mbuf:
    .ascii "advent of code 2024(7)"
