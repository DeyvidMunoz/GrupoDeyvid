
; PIC16F887 Configuration Bit Settings

; ASM source line config statements

#include "p16F887.inc"

; CONFIG1
; __config 0xE0D5
 __CONFIG _CONFIG1, _FOSC_INTRC_CLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

   LIST p= 16F887
  
N EQU 0xD0
cont1 EQU 0x20
cont2 EQU 0x21
var1 EQU 0x22

var3 EQU 0x24

 org 0x00
 
    BSF STATUS, RP0 ;Bank1
    MOVLW 0x71
    MOVWF OSCCON ;FOSC INTERNA 8MHZ
    CLRF TRISB ;TRISB = 0  salida

 
    BSF STATUS, RP1 ;Bank3
    CLRF ANSELH ;Poerto B digital
    
    BCF STATUS,RP0 ; BANK0
    BCF STATUS,RP1
    
    
    
IHOJA3
    movlw 0x80
    movwf PORTB
    movlw 0x08
    movwf var3
    
HOJA3
    CALL RETARDO
    movf PORTB,0
    RRF PORTB
    IORWF PORTB,1
    DECFSZ var3,1
    GOTO HOJA3
    GOTO IHOJA3
    

RETARDO
    MOVLW N
    MOVWF cont1
    
REP_1
    MOVLW N
    MOVWF cont2
    
REP_2
    DECFSZ cont2,1
    GOTO REP_2
    DECFSZ cont1,1
    GOTO REP_1
    RETURN


end



