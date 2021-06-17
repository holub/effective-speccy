    DEVICE ZXSPECTRUM128                                                                                                                                                
    include "src/inc/magic.asm"

    ORG 8000h
main:
    include "src/inc/im2.asm"

LOOP:
    EI
    HALT
    DI
    LD A, GREEN
    OUT (#FE), A
    LD B, 115
    DJNZ $
    LD A, BLUE
    OUT (#FE), A

    LD B, 16
    DJNZ $
    LD A, YELLOW
    OUT (#FE),A

    LD B, 16
    DJNZ $
    LD A, RED
    OUT (#FE),A

    LD B, 16   
    DJNZ $
    LD A, CYAN
    OUT (#FE),A

    LD B, 16
    DJNZ $
    LD A, BLACK
    OUT (#FE),A

    LD B, 16
    DJNZ $
    LD A, WHITE
    OUT (#FE),A

    LD A,#7F
    IN A,(#FE)
    RRA
    JP C,LOOP
    IM 1
    EI
    RET

    SAVESNA "test.sna", main
