*
*  linkscript.asm
*  Merlin32 Cross Compiler
*
*  Created by John Newcombe on 21/08/24.

    typ $06         ; file type (06=bin, FF=sys)
    dsk scroll      ; name of binary file
    org $0200       ;

    asm scroll.asm
    sna scroll     ; segment name

