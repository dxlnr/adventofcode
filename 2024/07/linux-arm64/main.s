.global  _start
.p2align 2

_printf:
  mov x8, 0x40 /* SYSCALL_WRITE */
  mov x0, #1
  ldr x1, =mbuf
  ldr x2, =mbuf_len
  svc #0

_exit:
  mov x8, 0x5d  /* SYSCALL_EXIT */
  mov x0, 10
  svc #0

_start:
  b _printf
  b _exit

.data
mbuf:
  .ascii "advent of code 2024(7)"
mbuf_len = .-mbuf

