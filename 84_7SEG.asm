
_CODBIN:

;84_7SEG.mbas,10 :: 		SUB PROCEDURE CODBIN
;84_7SEG.mbas,11 :: 		CENTENA   = (CONTADOR / 100)MOD 10
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	MOVF       _CONTADOR+0, 0
	MOVWF      R0+0
	MOVF       _CONTADOR+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _CENTENA+0
;84_7SEG.mbas,12 :: 		DECENA    = (CONTADOR/10)MOD 10
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	MOVF       _CONTADOR+0, 0
	MOVWF      R0+0
	MOVF       _CONTADOR+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _DECENA+0
;84_7SEG.mbas,13 :: 		UNIDAD    =  CONTADOR MOD 10
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	MOVF       _CONTADOR+0, 0
	MOVWF      R0+0
	MOVF       _CONTADOR+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _UNIDAD+0
;84_7SEG.mbas,14 :: 		END SUB
L_end_CODBIN:
	RETURN
; end of _CODBIN

_main:

;84_7SEG.mbas,16 :: 		MAIN:
;84_7SEG.mbas,20 :: 		TRISA  =   %00101000   ' A3 COMO  ENTRADA AN3
	MOVLW      40
	MOVWF      TRISA+0
;84_7SEG.mbas,21 :: 		TRISB  = %00000000   ' PUERTO B TODO  SALIDAS
	CLRF       TRISB+0
;84_7SEG.mbas,22 :: 		CONTADOR  = 0
	CLRF       _CONTADOR+0
	CLRF       _CONTADOR+1
;84_7SEG.mbas,23 :: 		PORTB = 0
	CLRF       PORTB+0
;84_7SEG.mbas,24 :: 		N = 0
	CLRF       _N+0
	CLRF       _N+1
;84_7SEG.mbas,27 :: 		WHILE 1
L__main3:
;84_7SEG.mbas,28 :: 		N = 0
	CLRF       _N+0
	CLRF       _N+1
;84_7SEG.mbas,29 :: 		CODBIN
	CALL       _CODBIN+0
;84_7SEG.mbas,30 :: 		DO
L__main7:
;84_7SEG.mbas,31 :: 		PORTB = DISPLAY[UNIDAD]
	MOVF       _UNIDAD+0, 0
	ADDLW      _DISPLAY+0
	MOVWF      R0+0
	MOVLW      hi_addr(_DISPLAY+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTB+0
;84_7SEG.mbas,32 :: 		PORTA = %1
	MOVLW      1
	MOVWF      PORTA+0
;84_7SEG.mbas,33 :: 		PAUSA
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L__main12:
	DECFSZ     R13+0, 1
	GOTO       L__main12
	DECFSZ     R12+0, 1
	GOTO       L__main12
	NOP
	NOP
;84_7SEG.mbas,35 :: 		IF (CENTENA > 0) OR (DECENA > 0) THEN
	MOVF       _CENTENA+0, 0
	SUBLW      0
	MOVLW      255
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R1+0
	MOVF       _DECENA+0, 0
	SUBLW      0
	MOVLW      255
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	IORWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main14
;84_7SEG.mbas,36 :: 		PORTB = DISPLAY[DECENA]
	MOVF       _DECENA+0, 0
	ADDLW      _DISPLAY+0
	MOVWF      R0+0
	MOVLW      hi_addr(_DISPLAY+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTB+0
;84_7SEG.mbas,37 :: 		PORTA = %10
	MOVLW      2
	MOVWF      PORTA+0
L__main14:
;84_7SEG.mbas,39 :: 		PAUSA
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L__main16:
	DECFSZ     R13+0, 1
	GOTO       L__main16
	DECFSZ     R12+0, 1
	GOTO       L__main16
	NOP
	NOP
;84_7SEG.mbas,41 :: 		IF CENTENA > 0 THEN
	MOVF       _CENTENA+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__main18
;84_7SEG.mbas,42 :: 		PORTB = DISPLAY[CENTENA]
	MOVF       _CENTENA+0, 0
	ADDLW      _DISPLAY+0
	MOVWF      R0+0
	MOVLW      hi_addr(_DISPLAY+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTB+0
;84_7SEG.mbas,43 :: 		PORTA = %100
	MOVLW      4
	MOVWF      PORTA+0
L__main18:
;84_7SEG.mbas,45 :: 		PAUSA
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L__main20:
	DECFSZ     R13+0, 1
	GOTO       L__main20
	DECFSZ     R12+0, 1
	GOTO       L__main20
	NOP
	NOP
;84_7SEG.mbas,47 :: 		N = N+1
	INCF       _N+0, 1
	BTFSC      STATUS+0, 2
	INCF       _N+1, 1
;84_7SEG.mbas,48 :: 		LOOP UNTIL N  = 20
	MOVLW      0
	XORWF      _N+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main26
	MOVLW      20
	XORWF      _N+0, 0
L__main26:
	BTFSC      STATUS+0, 2
	GOTO       L__main10
	GOTO       L__main7
L__main10:
;84_7SEG.mbas,49 :: 		CONTADOR = CONTADOR + 1
	INCF       _CONTADOR+0, 1
	BTFSC      STATUS+0, 2
	INCF       _CONTADOR+1, 1
;84_7SEG.mbas,51 :: 		IF CONTADOR > 999 THEN
	MOVF       _CONTADOR+1, 0
	SUBLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main27
	MOVF       _CONTADOR+0, 0
	SUBLW      231
L__main27:
	BTFSC      STATUS+0, 0
	GOTO       L__main22
;84_7SEG.mbas,52 :: 		CONTADOR = 0
	CLRF       _CONTADOR+0
	CLRF       _CONTADOR+1
L__main22:
;84_7SEG.mbas,56 :: 		WEND
	GOTO       L__main3
L_end_main:
	GOTO       $+0
; end of _main
