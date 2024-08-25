
;        ROM ROUTINES

AK      EQU  $1EFE          ; Check for key depressed. A non-zero: no key down. A equal 0, key down.
SCAND   EQU  $1F19          ; Display address and contents.
SCANDS  EQU  $1F1F          ; Output six hex characters on display. Stored in $00F9, $00FA, $00FB.
CONVD   EQU  $1F48          ; Output HEX digit
OUTPUT  EQU  $1F4E          ; Output 7 segment code stored in A register (to lit up a custom segment)
KEYIN   EQU  $1F40          ; Open up keyboard channel. Call before using GETKEY (or call SCANDS).
INCPT   EQU  $1F63          ; Increment display address.
GETKEY  EQU  $1F6A          ; Return key from keyboard. Value 0-F, 10(AD), 11(DA), 12(+), 13(GO), 14(PC), 15 (no keypress).
TABLE   EQU  $1FE7          ; Table of 7-segment patterns.
SAVE    EQU  $1C00          ; Normal interrupt entry point.
RST     EQU  $1C22          ; Reset return to monitor.
START   EQU  $1C4F          ; Return to monitor entry

; IO

SAD     EQU $1740           ; 6530 A DATA
PADD    EQU $1741           ; 6530 A DATA DIRECTION
SBD     EQU $1742           ; 6530 B DATA
PBDD    EQU $1743           ; 6530 B DATA DIRECTION
CLK1T   EQU $1744           ; DIV BY 1 TIME
CLK8T   EQU $1745           ; DIV BY 8 TIME
CLK64T  EQU $1746           ; DIV BY 64 TIME
CLKKT   EQU $1747           ; DIV BY 1024 TIME
CLKRDI  EQU $1747           ; READ TIME OUT BIT
CLKRDT  EQU $1746           ; READ TIME

;       MPU REG.  SAVX AREA IN PAGE 0

PCL     EQU $EF             ; PROGRAM CNT LOW
PCH     EQU $F0             ; PROGRAM CNT HI
PREG    EQU $F1             ; CURRENT STATUS REG
SPUSER  EQU $F2             ; CURRENT STACK POINTER
ACC     EQU $F3             ; ACCUMULATOR
YREG    EQU $F4             ; Y INDEX
XREG    EQU $F5             ; X INDEX

;       KIM FIXED AREA IN PAGE 0

CHKHI   EQU $F6
CHKSUM  EQU $F7
INL     EQU $F8             ; INPUT BUFFER
INH     EQU $F9             ; INPUT BUFFER
POINTL  EQU $FA             ; LSB OF OPEN CELL
POINTH  EQU $FB             ; MSB OF OPEN CELL
TEMP    EQU $FC
TMPX    EQU $FD
CHAR    EQU $FE
MODE    EQU $FF

;       KIM FIXED AREA IN PAGE 23

CHKL    EQU $17E7
CHKH    EQU $17E8           ; CHKSUM
SAVX    EQU $17E9
VEB     EQU $17EC           ; VOLATILE EXECUTION BLOCK
CNTL30  EQU $17F2           ; TTY DELAY
CNTH30  EQU $17F3           ; TTY DELAY
TIMH    EQU $7F4
SAL     EQU $17F5           ; LOW STARTING ADDRESS
SAH     EQU $17F6           ; HI STARTING ADDRESS
EAL     EQU $17F7           ; LOW ENDING ADDRESS;
EAH     EQU $17F8           ; HI ENDING ADDRESS
ID      EQU $17F9           ; TAPE PROGRAM ID NUMBER

;       INTERRUPT VECTORS

NMIV    EQU $17FA           ; STOP VECTOR (STOP=1C00)
RSTV    EQU $17FC           ; RST VECTOR
IRQV    EQU $17FE           ; IRQ VECTOR (BRK= 1C00)

;       SEVEN SEGMENT DISPLAYS

SEG-1   EQU $09
SEG-2   EQU $0B
SEG-3   EQU $0D
SEG-4   EQU $0F
SEG-5   EQU $11
SEG-6   EQU $13

;       SEGMENT LED LETTERS

; Relationship between bit and segment
;
;  | -0- |
;  5     1
;  | -6- |
;  4     2
;  | -3- |

; e.g. a lower case 'd' would include bits 1,2,3,4,6 = 1101 1110 = $5E

; Upper Case Letters

LA EQU $F7
LB EQU $FF
LC EQU $B9
LD EQU $BF
LE EQU $79
LF EQU $F1
LG EQU $BD
LH EQU $76
LI EQU $86
LJ EQU $9E
; LK
LL EQU $38
; LL
; LM
LO EQU $3F
LP EQU $F3
; LQ
; DEG-R
LS EQU $ED
; LT
LU EQU $BE
; LV
; LW
; LX
LY EQU $EE
; LZ

; Lower Case Letters

La EQU $DE
Lb EQU $FC
Lc EQU $D8
Ld EQU $DE
; Le
Lf EQU $F1
Lg EQU $EF
Lh EQU $F4
Li EQU $84
; Lj
; Lk
Ll EQU $86
; Lm
Ln EQU $D4
Lo EQU $DC
Lp EQU $F3
; Lq
Lr EQU $D0
; Ls
Lt EQU $F8
Lu EQU $9C
; Lv
; Lw
; Lx
Ly EQU $EE
; Lz

L1 EQU $86
L2 EQU $DB
L3 EQU $CF
L4 EQU $E6
L5 EQU $ED
L6 EQU $FD
L7 EQU $87
L8 EQU $FF
L9 EQU $EF
L0 EQU $BF

LSPC EQU $00
LDASH EQU $40


