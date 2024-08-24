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

LOOP        LDX #$00            ; init character offset
            LDY #$09            ; init segment offset
LOOP2       LDA #$7F            ; set directional
            STA PADD            ;    register

PRINT       STY SBD             ; set up segment to write character to
            LDA DATA,X          ; load next character

            ; if next char is $EA i.e. end of string, move X back to the beginning of the data

            CMP #$EA
            BNE NONZ            ; check for terminating character
            LDX #$00            ; set char offset back to beginning of the data
            JMP TERM            ;  and carry on

NONZ        STA SAD             ; output character
            INX                 ; increment character offset
            INY                 ; increment segment offset
            INY                 ; increment segment offset

TERM        CPY #$15            ; have we moved passed last segment
            BCC PRINT           ; < last seg so print again
            LDY #$09            ; init segment offset

            JSR DELAY
            JMP LOOP2           ; otherwise print next character

;=============================================================================
DELAY
;=============================================================================

            PHA
            TXA
            PHA
            TYA
            PHA

            LDA #02             ; Cycles
            STA $0000
DELAY1      DEC $0000           ;6
            BEQ DELAYDONE       ;2 (3 when $0000=0)
            LDX #$00            ;2
DELAY2      LDY #$00            ;2
DELAY3      DEY                 ;2
            BNE DELAY3          ;3 (2 when Y=0)
            DEX                 ;2
            BNE DELAY2          ;3 (2 when X=0)
            JMP DELAY1          ;3
DELAYDONE   PLA
            TAY
            PLA
            TAX
            PLA
            RTS

;=============================================================================
DATA
;=============================================================================

            DB LSPC, LSPC, LSPC, LSPC, LSPC, LH
            DB LSPC, LSPC, LSPC, LSPC, LH, LE
            DB LSPC, LSPC, LSPC, LH, LE, LL
            DB LSPC, LSPC, LH, LE, LL, LL
            DB LSPC, LH, LE, LL, LL, LO
            DB LH, LE, LL, LL, LO, LSPC
            DB LE, LL, LL, LO, LSPC, LSPC
            DB LL, LL, LO, LSPC, LSPC, LSPC
            DB LL, LO, LSPC, LSPC, LSPC, LSPC
            DB LO, LSPC, LSPC, LSPC, LSPC, LSPC
            DB LSPC, LSPC, LSPC, LSPC, LSPC, LSPC

            DB LSPC, LSPC, LSPC, LSPC, LSPC, LG
            DB LSPC, LSPC, LSPC, LSPC, LG, LL
            DB LSPC, LSPC, LSPC, LG, LL, LA
            DB LSPC, LSPC, LG, LL, LA, LS
            DB LSPC, LG, LL, LA, LS, LS
            DB LG, LL, LL, LS, LS, Lt
            DB LL, LA, LS, LS, Lt, Lt
            DB LA, LS, LS, Lt, Lt, LY
            DB LS, LS, Lt, Lt, LY, LSPC
            DB LS, Lt, Lt, LY, LSPC, LSPC
            DB Lt, Lt, LY, LSPC, LSPC, LSPC
            DB Lt, LY, LSPC, LSPC, LSPC, LSPC
            DB LY, LSPC, LSPC, LSPC, LSPC, LSPC
            DB LSPC, LSPC, LSPC, LSPC, LSPC, LSPC




            DB $EA

            PUT ./include/lib.asm


