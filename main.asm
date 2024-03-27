; Based on actraiser/dust-tutorial-c64-first-intro
; https://github.com/actraiser/dust-tutorial-c64-first-intro/blob/master/code/init_static_text.asm
!to "main.prg", cbm
* = $801
; This will auto run the program by calling sys2068
!byte $0c,$08,$0a,$00 ; load from drive 8
!byte $9e ; sys 
!text "2068" ; execute command sys2068

*=$0814 ; Assigns program to 2068

; our code starts here

main               jsr init_screen
                   jsr init_text
                   jmp *

init_screen        ldx #$00     ; set X to zero (black color code)
                   stx $d021    ; set background color
                   stx $d020    ; set border color

clear              lda #$20     ; #$20 is the spacebar Screen Code
                   sta $0400,x  ; fill four areas with 256 spacebar characters
                   sta $0500,x 
                   sta $0600,x 
                   sta $06e8,x 
                   lda #$01     ; set foreground to white in Color Ram 
                   sta $d800,x  
                   sta $d900,x
                   sta $da00,x
                   sta $dae8,x
                   inx           ; increment X
                   bne clear     ; did X turn to zero yet?
                                 ; if not, continue with the loop
                   rts           ; return from this subroutin

init_text          ldx #$00         ; init X register with $00

loop_text          lda line1,x    ; Load a char from each line and put it on a line
                   sta $0590,x      
                   lda line2,x      
                   sta $05b8,x    ; 1 line below (+40 chars)
                   lda line3,x      
                   sta $05e0,x    ; 1 line below 
                   lda line4,x      
                   sta $0608,x    ; 1 line below

                   inx 
                   cpx #$28         ; finished when all 40 cols of a line are processed
                   bne loop_text    ; loop if we are not done yet
                   rts

line1            !scr "   888   88 ,8b.     888   88            "
line2            !scr "   888ooo88 88'8o    888ooo88            " 
line3            !scr "         88 88ppy8.        88            " 
line4            !scr "   pppppp8p 8b   'y' pppppp8p            " 
