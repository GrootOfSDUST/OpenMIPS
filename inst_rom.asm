
inst_rom.om:     file format elf32-tradbigmips


Disassembly of section .text:

00000000 <_start>:
   0:	34011100 	li	at,0x1100
   4:	34210020 	ori	at,at,0x20
   8:	34214400 	ori	at,at,0x4400
   c:	34210044 	ori	at,at,0x44

Disassembly of section .reginfo:

00000010 <.reginfo>:
  10:	00000002 	srl	zero,zero,0x0
	...

Disassembly of section .MIPS.abiflags:

00000028 <_ram_end-0x18>:
  28:	00002001 	movf	a0,zero,$fcc0
  2c:	01010001 	movt	zero,t0,$fcc0
	...
  38:	00000001 	movf	zero,zero,$fcc0
  3c:	00000000 	nop

Disassembly of section .gnu.attributes:

00000000 <.gnu.attributes>:
   0:	41000000 	bc0f	4 <_start+0x4>
   4:	0f676e75 	jal	d9db9d4 <_ram_end+0xd9db994>
   8:	00010000 	sll	zero,at,0x0
   c:	00070401 	0x70401
