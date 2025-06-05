.global  _start
.p2align 2

/* open, get size, mmap, write out, clean (munmap & close) */
_loadf:
  /* (1) SYSCALL_OPENAT
  	open and possibly create a file */
  mov x8, 0x38
  mov x0, #-100     /* AT_FDCWD */
  ldr x1, =example
  mov x2, 0x0  	    /* flags=O_RDONLY */
  mov x3, 0x0       /* ignored */
  svc #0

  mov x8, 0x5d  /* SYSCALL_EXIT */
  svc #0

  /* (3) SYSCALL_MMAP
	map or unmap files or devices into memory */
  mov x8, 0xde  
  mov x0, 0
  mov x3, 0x1 /* PROT_READ : Page can be read */
  /* SYSCALL_CLOSE
  	fd can be closed without invalidating the mapping */
  mov x8, 0x39
  mov x0, #1

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
  b _loadf
  b _printf
  b _exit

.data
example:
  .asciz "/home/daniel/code/github/adventofcode/2024/07/example"
mbuf:
  .ascii "Advent of code 2024(7):\n"
mbuf_len = .-mbuf


