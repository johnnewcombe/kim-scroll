;=============================================================================
; Display Example (c) J.L.Newcombe 2024 (mostly)
;
; Licence:
;       None
;
; Assembler:
;       Merlin32 compiler by Brutal Delux
;       https://www.brutaldeluxe.fr/products/crossdevtools/merlin/index.html
;
;-----------------------------------------------------------------------------
; Date          Comment
;-----------------------------------------------------------------------------
; 10.02.2024    Created for the Merlin32 compiler by Brutal Delux
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
LOOP        LDX #$00            ; init character offset
            LDY #$09            ; init segment offset

            ;LDA #$FF
            ;STA $1707           ; set timer division

            LDA #$FF            ; set directional
            STA PADD            ;    register

            LDY #$09
PRINT
            ;JSR DELAY
            STY SBD
            LDA DATA,X
            STA SAD
            INX
            INY
            INY
            CMP #$13
            BEQ LOOP
            JMP PRINT

;-----------------------------------------------------------------------------
; Main display loop
;-----------------------------------------------------------------------------

LOOP2

            STY SBD             ; set up segment to write character to
            LDA DATA,X          ; load next character

            ; if next char is $EA i.e. end of string, move X back to the beginning of the data

            ;CMP #$EA
            ;BNE NONZ            ; check for terminating character
            ;LDX #$00            ; set char offset back to beginning of the data
            ;JMP LOOP2           ;  and carry on

NONZ        STA SAD             ; output character
            INX                 ; increment character offset
            INY                 ; increment segment offset
            INY                 ; increment segment offset

TERM        CPX #$06            ; have we moved passed last segment
            BCC LOOP2           ; < last seg so print again
            LDY #$09            ; reset segment offset
            LDX #$00            ; reset character offset
            JMP LOOP2           ; otherwise print next character



;            ; TODO Use Timer to increase X and Y
;            LDA $1707
;            BEQ LOOP2
;            LDA $1706           ; restore divider etc (a read will accomplish this)

DELAY       LDA $00
DELAY1      dec
            bne DELAY1
            RTS

;=============================================================================
DATA
;=============================================================================

            DB LH, LE, LL, LL, LO, LDASH
            ;DB $EA

            ;DB LSPC, LSPC, LSPC, LSPC, LSPC, LH
            ;DB LSPC, LSPC, LSPC, LSPC, LH, LE
            ;DB LSPC, LSPC, LSPC, LH, LE, LL
            ;DB LSPC, LSPC, LH, LE, LL, LL
            ;DB LSPC, LH, LE, LL, LL, LO
            ;DB LH, LE, LL, LL, LO, LSPC
            ;DB LE, LL, LL, LO, LSPC, LSPC
            ;DB LL, LL, LO, LSPC, LSPC, LSPC
            ;DB LL, LO, LSPC, LSPC, LSPC, LSPC
            ;DB LO, LSPC, LSPC, LSPC, LSPC, LSPC
            ;DB LSPC, LSPC, LSPC, LSPC, LSPC, LSPC

            ;DB LSPC, LSPC, LSPC, LSPC, LSPC, LG
            ;DB LSPC, LSPC, LSPC, LSPC, LG, LL
            ;DB LSPC, LSPC, LSPC, LG, LL, LA
            ;DB LSPC, LSPC, LG, LL, LA, LS
            ;DB LSPC, LG, LL, LA, LS, LS
            ;DB LG, LL, LL, LS, LS, Lt
            ;DB LL, LA, LS, LS, Lt, Lt
            ;DB LA, LS, LS, Lt, Lt, LY
            ;DB LS, LS, Lt, Lt, LY, LSPC
            ;DB LS, Lt, Lt, LY, LSPC, LSPC
            ;DB Lt, Lt, LY, LSPC, LSPC, LSPC
            ;DB Lt, LY, LSPC, LSPC, LSPC, LSPC
            ;DB LY, LSPC, LSPC, LSPC, LSPC, LSPC
            ;DB LSPC, LSPC, LSPC, LSPC, LSPC, LSPC

            ;DB $EA

            PUT ./include/lib.asm


