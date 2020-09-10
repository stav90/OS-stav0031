  .file [name="checkpoint3.1.bin", type="bin", segments="XMega65Bin"]
.segmentdef XMega65Bin [segments="Syscall, Code, Data, Stack, Zeropage"]
.segmentdef Syscall [start=$8000, max=$81ff]
.segmentdef Code [start=$8200, min=$8200, max=$bdff]
.segmentdef Data [startAfter="Code", min=$8200, max=$bdff]
.segmentdef Stack [min=$be00, max=$beff, fill]
.segmentdef Zeropage [min=$bf00, max=$bfff, fill]
  .label VIC_MEMORY = $d018
  .label SCREEN = $400
  .label COLS = $d800
  .const WHITE = 1
  .const JMP = $4c
  .const NOP = $ea
  .label current_screen_line = 2
.segment Code
main: {
    rts
}
undefined_trap: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
exit_hypervisor: {
    lda #1
    sta $d67f
    rts
}
CPUKIL: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
VF011WR: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
VF011RD: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
ALTTABKEY: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
RESTORKEY: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
PAGFAULT: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
RESET: {
    lda #$14
    sta VIC_MEMORY
    ldx #' '
    lda #<SCREEN
    sta.z memset.str
    lda #>SCREEN
    sta.z memset.str+1
    lda #<$28*$19
    sta.z memset.num
    lda #>$28*$19
    sta.z memset.num+1
    jsr memset
    ldx #WHITE
    lda #<COLS
    sta.z memset.str
    lda #>COLS
    sta.z memset.str+1
    lda #<$28*$19
    sta.z memset.num
    lda #>$28*$19
    sta.z memset.num+1
    jsr memset
    lda #<$400
    sta.z current_screen_line
    lda #>$400
    sta.z current_screen_line+1
    lda #<MESSAGE
    sta.z print_to_screen.message
    lda #>MESSAGE
    sta.z print_to_screen.message+1
    jsr print_to_screen
    jsr print_newline
    lda #<MESSAGE2
    sta.z print_to_screen.message
    lda #>MESSAGE2
    sta.z print_to_screen.message+1
    jsr print_to_screen
    jsr exit_hypervisor
    rts
}
// print_to_screen(byte* zeropage(4) message)
print_to_screen: {
    .label message = 4
  b1:
    ldx #0
  __b1:
    ldy #0
    lda (message),y
    cmp #0
    bne __b2
    rts
  __b2:
    ldy #0
    lda (message),y
    sta (current_screen_line),y
    inc.z current_screen_line
    bne !+
    inc.z current_screen_line+1
  !:
    inc.z message
    bne !+
    inc.z message+1
  !:
    inx
    cpx #$27+1
    bcc __b1
    jsr print_newline
    jmp b1
}
print_newline: {
    txa
    eor #$ff
    clc
    adc #$28+1
    clc
    adc.z current_screen_line
    sta.z current_screen_line
    bcc !+
    inc.z current_screen_line+1
  !:
    rts
}
// Copies the character c (an unsigned char) to the first num characters of the object pointed to by the argument str.
// memset(void* zeropage(6) str, byte register(X) c, word zeropage(4) num)
memset: {
    .label end = 4
    .label dst = 6
    .label num = 4
    .label str = 6
    lda.z num
    bne !+
    lda.z num+1
    beq __breturn
  !:
    lda.z end
    clc
    adc.z str
    sta.z end
    lda.z end+1
    adc.z str+1
    sta.z end+1
  __b2:
    lda.z dst+1
    cmp.z end+1
    bne __b3
    lda.z dst
    cmp.z end
    bne __b3
  __breturn:
    rts
  __b3:
    txa
    ldy #0
    sta (dst),y
    inc.z dst
    bne !+
    inc.z dst+1
  !:
    jmp __b2
}
syscall3F: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall3E: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall3D: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall3C: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall3B: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall3A: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall39: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall38: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall37: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall36: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall35: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall34: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall33: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall32: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall31: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall30: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall2F: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall2E: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall2D: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall2C: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall2B: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall2A: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall29: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall28: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall27: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall26: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall25: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall24: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall23: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall22: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall21: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall20: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall1F: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall1E: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall1D: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall1C: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall1B: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall1A: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall19: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall18: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall17: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall16: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall15: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall14: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall13: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall10: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall0F: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall0E: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall0D: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall0C: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall0B: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall0A: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall09: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall08: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall07: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall06: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall05: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall04: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall03: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall02: {
    lda #'{'
    sta SCREEN+$4e
    jsr exit_hypervisor
    rts
}
syscall01: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall00: {
    lda #'}'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
.segment Data
  MESSAGE: .text "stav0031 operating system starting"
  .byte 0
  MESSAGE2: .text "testing hardware"
  .byte 0
.segment Syscall
  SYSCALLS: .byte JMP
  .word syscall00
  .byte NOP, JMP
  .word syscall01
  .byte NOP, JMP
  .word syscall02
  .byte NOP, JMP
  .word syscall03
  .byte NOP, JMP
  .word syscall04
  .byte NOP, JMP
  .word syscall05
  .byte NOP, JMP
  .word syscall06
  .byte NOP, JMP
  .word syscall07
  .byte NOP, JMP
  .word syscall08
  .byte NOP, JMP
  .word syscall09
  .byte NOP, JMP
  .word syscall0A
  .byte NOP, JMP
  .word syscall0B
  .byte NOP, JMP
  .word syscall0C
  .byte NOP, JMP
  .word syscall0D
  .byte NOP, JMP
  .word syscall0E
  .byte NOP, JMP
  .word syscall0F
  .byte NOP, JMP
  .word syscall10
  .byte NOP, JMP
  .word syscall13
  .byte NOP, JMP
  .word syscall14
  .byte NOP, JMP
  .word syscall15
  .byte NOP, JMP
  .word syscall16
  .byte NOP, JMP
  .word syscall17
  .byte NOP, JMP
  .word syscall18
  .byte NOP, JMP
  .word syscall19
  .byte NOP, JMP
  .word syscall1A
  .byte NOP, JMP
  .word syscall1B
  .byte NOP, JMP
  .word syscall1C
  .byte NOP, JMP
  .word syscall1D
  .byte NOP, JMP
  .word syscall1E
  .byte NOP, JMP
  .word syscall1F
  .byte NOP, JMP
  .word syscall20
  .byte NOP, JMP
  .word syscall21
  .byte NOP, JMP
  .word syscall22
  .byte NOP, JMP
  .word syscall23
  .byte NOP, JMP
  .word syscall24
  .byte NOP, JMP
  .word syscall25
  .byte NOP, JMP
  .word syscall26
  .byte NOP, JMP
  .word syscall27
  .byte NOP, JMP
  .word syscall28
  .byte NOP, JMP
  .word syscall29
  .byte NOP, JMP
  .word syscall2A
  .byte NOP, JMP
  .word syscall2B
  .byte NOP, JMP
  .word syscall2C
  .byte NOP, JMP
  .word syscall2D
  .byte NOP, JMP
  .word syscall2E
  .byte NOP, JMP
  .word syscall2F
  .byte NOP, JMP
  .word syscall30
  .byte NOP, JMP
  .word syscall31
  .byte NOP, JMP
  .word syscall32
  .byte NOP, JMP
  .word syscall33
  .byte NOP, JMP
  .word syscall34
  .byte NOP, JMP
  .word syscall35
  .byte NOP, JMP
  .word syscall36
  .byte NOP, JMP
  .word syscall37
  .byte NOP, JMP
  .word syscall38
  .byte NOP, JMP
  .word syscall39
  .byte NOP, JMP
  .word syscall3A
  .byte NOP, JMP
  .word syscall3B
  .byte NOP, JMP
  .word syscall3C
  .byte NOP, JMP
  .word syscall3D
  .byte NOP, JMP
  .word syscall3E
  .byte NOP, JMP
  .word syscall3F
  .byte NOP
  .align $100
  TRAPS: .byte JMP
  .word RESET
  .byte NOP, JMP
  .word PAGFAULT
  .byte NOP, JMP
  .word RESTORKEY
  .byte NOP, JMP
  .word ALTTABKEY
  .byte NOP, JMP
  .word VF011RD
  .byte NOP, JMP
  .word VF011WR
  .byte NOP, JMP
  .word CPUKIL
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP
