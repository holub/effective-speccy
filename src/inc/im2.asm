    LD      HL,#FE00
    LD      DE,#FE01
    LD      BC,#100
    LD      (HL),#FF
    LDIR
    LD      HL,#FFFF
    LD      (HL),#C9

    DI
    LD      A,#FE
    LD      I,A
    IM      2
