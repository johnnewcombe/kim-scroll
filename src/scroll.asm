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
            PUT include/defs.asm
            PUT include/macros.asm

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

            ;LDA <#DATA          ; set up a vector to point to the data
            ;STA DATAINDEX
            ;LDA >#DATA
            ;STA DATAINDEX + 1

            lda #$00            ; store initial value for Y in zero page
            sta $00

            lda #$FF
            sta $1707          ; set timer division

DISPLOOP
            ldy $00             ; initialise character offset from Zero Page
            ldx #$09              ; init 7 segment offset

CHARLOOP
            lda #$00
            sta SAD             ; do it this way
            stx SBD             ;   to remove flicker
            lda DATA,y
            cmp #$EA            ; check for data terminator
            bne NOTERM
            LDA #$00            ; no more data so reset ZP index
            STA $00
            JMP DISPLOOP        ; start again

NOTERM      sta SAD

;-----------------------------------------------------------------------------
; delay to allow the leds to reach full brightness
;-----------------------------------------------------------------------------
            tya                 ; delay added to allow the led to fully light
            ldy #$04            ;   helps a little with the genuine KIM-1
CHARDELAY
            dey
            bne CHARDELAY       ; glow up character
            tay
;-----------------------------------------------------------------------------

            iny
            inx
            inx
            cpx #$15            ; beyond last segment
            bne CHARLOOP

;-----------------------------------------------------------------------------
; all segments done, check timer, and start again to refresh display
;-----------------------------------------------------------------------------
            LDA $1707           ; check the timer
            BEQ DONE
            LDA $1706           ; restore divider etc (a read will accomplish this)
            INC $00             ; increment index low byte

DONE        jmp DISPLOOP        ; refresh the display


DATA        DB LSPC, LSPC, LSPC, LSPC, LSPC, LH, LE, LL, LL, LO, LSPC, LG, LL, LA, LS, LS, LSPC, Lt, Lt, LY
            DB $EA

