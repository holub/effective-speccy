    DEVICE ZXSPECTRUM128 : ORG 8000h

    include "inc/magic.asm"
    include "inc/ula.asm"
main:
    include "inc/im2.asm"

    LD B, 192
    LD HL, SCREEN1 + 15
    LD DE, 32
VL: LD (HL), %00000001
    ADD HL, DE
    DJNZ VL

    LD B, 192
    LD HL, SCREEN1 + 16
    LD DE, 32
VR: LD (HL), %10000000
    ADD HL, DE
    DJNZ VR


    LD B, 32
    LD HL, SCREEN1 + (32*(64+64-5))
HU: 
    LD (HL), %10101010
    INC HL
    DJNZ HU

    LD B, 32
    LD HL, SCREEN1 + (32*(64+4))
HD: 
    LD (HL), %01010101
    INC HL
    DJNZ HD

    MACRO W t, r
        WASTE (t-12)
        OUT (C), r
    ENDM

    MACRO _W
        W 16,A
    ENDM
    MACRO _W12
        W 12,A
    ENDM
    MACRO _W20
        W 20,A
    ENDM
    MACRO _B
        W 16,B
    ENDM
    MACRO _B12
        W 12,B
    ENDM
    MACRO _B20
        W 20,B
    ENDM
    MACRO _R
        W 16,D
    ENDM
    MACRO _R20
        W 20,D
    ENDM
    MACRO _U
        W 16,H
    ENDM
    MACRO _Y
        W 16,L
    ENDM

LOOP:
    EI
    LD A, WHITE
    LD B, BLACK
    LD D, RED
    LD H, BLUE
    LD L, GREEN

    LD C, #FE
    OUT (c), D
    EI
    HALT
        ; 30
        WASTE 224*16-21-16-30   : LD A, WHITE : LD H, BLUE : LD L, GREEN : _Y
        WASTE 224*16-21-16      : LD A, WHITE : LD H, BLUE : LD L, GREEN 
    DUP 4
/*1*/   _U : _Y : _W : _B : _W20 : _B : _W :  W 31,B : W 33,A  : _B : _W : _B12
        _Y : _U : _W : _B : _W20 : _B : _W :  W 33,B : W 31,A  : _B : _W : _B12
        _U : _Y : _B : _B : _W20 : _B : _W :  W 31,B : W 33,A  : _B : _W : _W12
        _Y : _U : _B : _B : _W20 : _B : _W :  W 33,B : W 31,A  : _B : _W : _W12
        _U : _Y : _W : _W : _W20 : _B : _W : _B : _W : _B : _W : _B : _B : _B12
        _Y : _U : _W : _W : _W20 : _B : _W : _B : _W : _B : _W : _B : _B : _B12
        _U : _Y : _B : _W : _W20 : _B : _W : _B : _W : _B : _W : _B : _B : _W12
        _Y : _U : _B : _W : _W20 : _B : _W : _B : _W : _B : _W : _B : _B : _W12
        _U : _Y : _W : _B : _B20 : _B : _W : _B : _W : _B : _W : _W : _W : _B12
        _Y : _U : _W : _B : _B20 : _B : _W : _B : _W : _B : _W : _W : _W : _B12
        _U : _Y : _B : _B : _B20 : _B : _W : _B : _W : _B : _W : _W : _W : _W12
        _Y : _U : _B : _B : _B20 : _B : _W : _B : _W : _B : _W : _W : _W : _W12
        _U : _Y : _W : _W : _B20 : _B : _W : _B : _W : _B : _W : _W : _B : _B12
        _Y : _U : _W : _W : _B20 : _B : _W : _B : _W : _B : _W : _W : _B : _B12
        _U : _Y : _B : _W : _B20 : _B : _W : _B : _W : _B : _W : _W : _B : _W12
/*16*/  _Y : _U : _B : _W : _B20 : _B : _W : _B : _W : _B : _W : _W : _B : _W12
        _U : _Y : _W : _B : _W20 : _W : _W : _B : _W : _B : _B : _B : _W : _B12
        _Y : _U : _W : _B : _W20 : _W : _W : _B : _W : _B : _B : _B : _W : _B12
        _U : _Y : _B : _B : _W20 : _W : _W : _B : _W : _B : _B : _B : _W : _W12
        _Y : _U : _B : _B : _W20 : _W : _W : _B : _W : _B : _B : _B : _W : _W12
        _U : _Y : _W : _W : _W20 : _W : _W : _B : _W : _B : _B : _B : _B : _B12
        _Y : _U : _W : _W : _W20 : _W : _W : _B : _W : _B : _B : _B : _B : _B12
        _U : _Y : _B : _W : _W20 : _W : _W : _B : _W : _B : _B : _B : _B : _W12
        _Y : _U : _B : _W : _W20 : _W : _W : _B : _W : _B : _B : _B : _B : _W12
        _U : _Y : _W : _B : _B20 : _W : _W : _B : _W : _B : _B : _W : _W : _B12
        _Y : _U : _W : _B : _B20 : _W : _W : _B : _W : _B : _B : _W : _W : _B12
        _U : _Y : _B : _B : _B20 : _W : _W : _B : _W : _B : _B : _W : _W : _W12
        _Y : _U : _B : _B : _B20 : _W : _W : _B : _W : _B : _B : _W : _W : _W12
        _U : _Y : _W : _W : _B20 : _W : _W : _B : _W : _B : _B : _W : _B : _B12
        _Y : _U : _W : _W : _B20 : _W : _W : _B : _W : _B : _B : _W : _B : _B12
        _U : _Y : _B : _W : _B20 : _W : _W : _B : _W : _B : _B : _W : _B : _W12
/*32*/  _Y : _U : _B : _W : _B20 : _W : _W : _B : _W : _B : _B : _W : _B : _W12
        _U : _Y : _W : _B : _W20 : _B : _B : _B : _W : _W : _W : _B : _W : _B12
        _Y : _U : _W : _B : _W20 : _B : _B : _B : _W : _W : _W : _B : _W : _B12
        _U : _Y : _B : _B : _W20 : _B : _B : _B : _W : _W : _W : _B : _W : _W12
        _Y : _U : _B : _B : _W20 : _B : _B : _B : _W : _W : _W : _B : _W : _W12
        _U : _Y : _W : _W : _W20 : _B : _B : _B : _W : _W : _W : _B : _B : _B12
        _Y : _U : _W : _W : _W20 : _B : _B : _B : _W : _W : _W : _B : _B : _B12
        _U : _Y : _B : _W : _W20 : _B : _B : _B : _W : _W : _W : _B : _B : _W12
        _Y : _U : _B : _W : _W20 : _B : _B : _B : _W : _W : _W : _B : _B : _W12
        _U : _Y : _W : _B : _B20 : _B : _B : _B : _W : _W : _W : _W : _W : _B12
        _Y : _U : _W : _B : _B20 : _B : _B : _B : _W : _W : _W : _W : _W : _B12
        _U : _Y : _B : _B : _B20 : _B : _B : _B : _W : _W : _W : _W : _W : _W12
        _Y : _U : _B : _B : _B20 : _B : _B : _B : _W : _W : _W : _W : _W : _W12
        _U : _Y : _W : _W : _B20 : _B : _B : _B : _W : _W : _W : _W : _B : _B12
        _Y : _U : _W : _W : _B20 : _B : _B : _B : _W : _W : _W : _W : _B : _B12
        _U : _Y : _B : _W : _B20 : _B : _B : _B : _W : _W : _W : _W : _B : _W12
/* 48*/ _Y : _U : _B : _W : _B20 : _B : _B : _B : _W : _W : _W : _W : _B : _W12
        _U : _Y : _R : _B : _R20 : _W : _B : _B : _W : _W : _B : _B : _W : _B12 ;R 17952ts = 17920+32: начало вывода левого бордюра первой растровой строки
        _Y : _U : _W : _B : _W20 : _W : _B : _B : _W : _W : _B : _B : _W : _B12 ;R 17988ts = 17920+32+36: начало вывода растровой картинки первой растровой строки
        _U : _Y : _B : _B : _W20 : _W : _B : _B : _W : _W : _B : _B : _W : _W12
        _Y : _U : _B : _B : _W20 : _W : _B : _B : _W : _W : _B : _B : _W : _W12
        _U : _Y : _W : _W : _W20 : _W : _B : _B : _W : _W : _B : _B : _B : _B12
        _Y : _U : _W : _W : _W20 : _W : _B : _B : _W : _W : _B : _B : _B : _B12
        _U : _Y : _B : _W : _W20 : _W : _B : _B : _W : _W : _B : _B : _B : _W12
        _Y : _U : _B : _W : _W20 : _W : _B : _B : _W : _W : _B : _B : _B : _W12
        _U : _Y : _W : _B : _B20 : _W : _B : _B : _W : _W : _B : _W : _W : _B12
        _Y : _U : _W : _B : _B20 : _W : _B : _B : _W : _W : _B : _W : _W : _B12
        _U : _Y : _B : _B : _B20 : _W : _B : _B : _W : _W : _B : _W : _W : _W12
        _Y : _U : _B : _B : _B20 : _W : _B : _B : _W : _W : _B : _W : _W : _W12
        _U : _Y : _W : _W : _B20 : _W : _B : _B : _W : _W : _B : _W : _B : _B12
        _Y : _U : _W : _W : _B20 : _W : _B : _B : _W : _W : _B : _W : _B : _B12
        _U : _Y : _B : _W : _B20 : _W : _B : _B : _W : _W : _B : _W : _B : _W12
        _Y : _U : _B : _W : _B20 : _W : _B : _B : _W : _W : _B : _W : _B : _W12
    EDUP

    _R
    LD B, 0

    LD A,#7F
    IN A,(#FE)
    RRA
    JP C,LOOP
    IM 1
    EI
    RET

    SAVESNA "border-checkers.sna", main
