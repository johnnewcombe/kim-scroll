;=============================================================================
; Display Example (c) J.L.Newcombe 2024 (mostly)
;
; Based on examples by Aart Bik
;      https://github.com/maksimKorzh/KIM-1/blob/main/software/Hello/hello.asm
;
; Licence:
;       None
;
; Assembler:
;       Merlin32 compiler by Brutal Delux
;       https://www.brutaldeluxe.fr/products/crossdevtools/merlin/index.html
;       Load to $0200
;
;-----------------------------------------------------------------------------
; Date          Comment
;-----------------------------------------------------------------------------
; 10.08.2024    Created for the Merlin32 compiler by Brutal Delux
;
;
;=============================================================================

            PUT include/kim-symbols.asm

            MX  %11             ; 11 tells Merlin32 that A, X and Y are
                                ;   8 bit registers

            cli
            cld

;-----------------------------------------------------------------------------
; Initialise
;-----------------------------------------------------------------------------
            lda #$7f            ; set directional registers
            sta PADD
            lda #$3f
            sta PBDD

DISPLOOP
            ldx #$00              ; initialise character offset
            ldy #$09              ; init 7 segment offset

CHARLOOP
            lda #$00
            sta SAD             ; do it this way
            sty SBD             ;   to remove flicker
            lda DATA, x
            sta SAD

            txa                 ; delay added to allow the led to fully light
            ldx #$04            ;   helps a little with the genuine KIM-1
CHARDELAY
            dex
            bne CHARDELAY       ; glow up character
            tax

            inx
            iny
            iny
            cpx #6
            bne CHARLOOP
            jmp DISPLOOP        ; refresh the display

DATA        DB LH, LE, LL, LL, LO, LSPC, LG, LL, LA, LS, LS, LSPC, Lt, Lt, LY
            DB $EA

