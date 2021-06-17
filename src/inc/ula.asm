TLEFTH:     equ 64/2
TLEFT:      equ 72/2
TSCR:       equ 256/2
TRIGHT:     equ 56/2
TLINE:      equ TLEFTH + TLEFT + TSCR + TRIGHT
TTOPH:      equ 32
TTOP:       equ 48
TROW:       equ 192
TBOTTOM:    equ 48

TFIRSTVIS:  equ  TLINE * TTOPH + TLEFTH ;https://zxuno.com/forum/viewtopic.php?t=122

wHL256:
        dec     h               ;<0>  | <4>
        ld      a,256-4-4-12-4-7-17-81       ; 81 is wA overhead
                                ;<0>  | <7>
        call    wA              ;<0>  | <17+A>
wHL:    inc     h               ;<4>  | <4>
        dec     h               ;<4>  | <4>
        jr      nz,wHL256       ;<7>  | <12>
        ld      a,l             ;<4>
wA:     rrca                    ;<4>
        jr      c,wHL_0s        ;<7>  | <12> 1 extra cycle if bit 0 set
        nop                     ;<4>  | <0>
wHL_0s: rrca                    ;<4>
        jr      nc,wHL_1c       ;<12> | <7>  2 extra cycles if bit 1 set
        jr      nc,wHL_1c       ;<0>  | <7>
wHL_1c: rrca                    ;<4>
        jr      nc,wHL_2c       ;<12> | <7>  4 extra cycles if bit 2 set
        ret     nc              ;<0>  | <5>
        nop                     ;<0>  | <4>
wHL_2c: rrca                    ;<4>
        jr      nc,wHL_3c       ;<12> | <7>  8 extra cycles if bit 3 set
        ld      (0),a           ;<0>  | <13>
wHL_3c: and     #0f             ;<7>
        ret     z               ;<11> | <5>  done if no other bits set
wHL_16: dec     a               ;<0>  | <4>  loop away 16 for remaining count
        jr      nz,wHL_16       ;<0>  | <12>
        ret     z               ;<0>  | <11>
; Last jr was 7, but the extra 5 from "ret z" keeps us at 16 * A.
; The "ret z" cost balances the previous "ret z" in the 0 case.

    MACRO WASTE t
        IF t = 0
        ELSEIF t = 19
                LD B,(IX)
        ELSEIF t = 21
                PUSH HL
                POP HL
        ELSEIF t < 127 && 0 = (t % 4)
                DUP t / 4
                NOP
                EDUP
        ELSE
/*      0 => '',                                                                                                                                                            
        4 => 'NOP',                                                                                                                                                         
        5 => 'RET NC',                                                                                                                                                      
        6 => 'DEC DE',                                                                                                                                                      
        7 => 'LD B,#7F',                                                                                                                                                    
        8 => 'NOP:NOP',                                                                                                                                                     
        9 => 'LD A,R',                                                                                                                                                      
        10 => 'RET NC:RET NC',                                                                                                                                              
        11 => 'NOP:LD B,#7F',                                                                                                                                               
        12 => 'NOP:NOP:NOP',                                                                                                                                                
        13 => 'LD A,R:NOP',                                                                                                                                                 
        14 => 'LD A,R:RET NC',                                                                                                                                              
        15 => 'RET NC:RET NC:RET NC',                                                                                                                                       
        16 => 'NOP:NOP:NOP:NOP',                                                                                                                                            
        17 => 'LD A,R:NOP:NOP',                                                                                                                                             
        18 => 'LD A,R:LD A,R',                                                                                                                                              
        19 => 'LD A,R:RET NC:RET NC',
        20 => 'RET NC:RET NC:RET NC:RET NC',                                                                                                                                
        21 => 'RET NC:RET NC:NOP:LD B,#7F',
        22 => 'RET NC:RET NC:RET NC:LD B,#7F',                                                                                                                              
        23 => 'LD A,R:LD A,R:RET NC',                                                                                                                                       
        24 => 'LD A,R:RET NC:RET NC:RET NC',                                                                                                                                
        25 => 'LD A,R:LD A,R:LD B,#7F',                                                                                                                                     
        26 => 'LD A,R:LD A,R:NOP:NOP',                                                                                                                                      
        27 => 'LD A,R:LD A,R:LD A,R',                                                                                                                                       
        28 => 'LD A,R:LD A,R:RET NC:RET NC',                                                                                                                                
        29 => 'LD A,R:LD A,R:NOP:LD B,#7F',                                                                                                                                 
        30 => 'LD A,R:LD A,R:RET NC:LD B,#7F',                                                                                                                              
        32 => 'NOP:NOP:NOP:NOP:NOP:NOP:NOP:NOP',                                                                                                                            
        33 => 'NOP:NOP:NOP:NOP:NOP:NOP:NOP:RET NC',                                                                                                                         
        34 => 'NOP:NOP:NOP:NOP:NOP:NOP:RET NC:RET NC',                                                                                                                      
        36 => 'NOP:NOP:NOP:NOP:NOP:NOP:NOP:NOP:NOP',                                                                                                                        
        40 => 'LD A,R:LD A,R:LD A,R:LD A,R:NOP',                                                                                                                            
        60 => 'LD A,R:LD A,R:RET NC:LD B,#7F:LD A,R:LD A,R:RET NC:LD B,#7F',
        
        4 => 'NOP',                                                                                                                                                         
        5 => 'RET C',                                                                                                                                                       
        6 => 'DEC BC',                                                                                                                                                      
        7 => 'OR 0',                                                                                                                                                        
        8 => 'NOP:NOP',                                                                                                                                                     
        9 => 'LD R,A',                                                                                                                                                      
        10 => 'NOP:DEC BC',                                                                                                                                                 
        11 => 'NOP:OR 0',                                                                                                                                                   
        12 => 'DEC BC:DEC BC',                                                                                                                                              
        13 => 'DEC BC:OR 0',                                                                                                                                                
        14 => 'DEC BC:NOP:NOP',                                                                                                                                             
        15 => 'LD R,A:DEC BC',                                                                                                                                              
        16 => 'NOP:NOP:NOP:NOP',                                                                                                                                            
        17 => 'LD R,A:NOP:NOP',                                                                                                                                             
        18 => 'DEC BC:DEC BC:DEC BC',          */
        ; LD (0), HL ; 16
        ; LD (0), A  ; 13
        ; JR $+2     ; 12
                LD HL, t-100-27
                CALL wHL
        ENDIF
    ENDM
