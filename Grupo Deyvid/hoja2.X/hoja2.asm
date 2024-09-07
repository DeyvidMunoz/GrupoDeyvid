
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
var2 EQU 0x23
var3 EQU 0x24
var4 EQU 0x25
var5 EQU 0x26

 org 0x00
 
    BSF STATUS, RP0 ;Bank1
    MOVLW 0x71
    MOVWF OSCCON ;FOSC INTERNA 8MHZ
    CLRF TRISB ;TRISB = 0  salida

 
    BSF STATUS, RP1 ;Bank3
    CLRF ANSELH ;Poerto B digital
    
    BCF STATUS,RP0 ; BANK0
    BCF STATUS,RP1
IHOJA2 
    MOVLW 0x01
    MOVWF var1
    MOVLW 0xF0
    MOVWF var2
    MOVLW 0x02
    MOVWF var3
    MOVWF var4
    MOVLW 0x03
    MOVWF var5
    
HOJA2
    MOVF var1,0
    IORWF var2,0
    MOVWF PORTB
    CALL RETARDO
    MOVF var1, 0          
    ADDLW 0x02        
    MOVWF var1  
    DECFSZ var3,1
    CALL XOR2
    DECFSZ var4,1
    GOTO XOR6
    GOTO XORE

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
XOR2  
    MOVF var2, 0         
    MOVLW 0x20             
    XORWF var2, 1
    GOTO HOJA2
XOR6
    MOVF var2, 0         
    MOVLW 0x60             
    XORWF var2, 1
    MOVLW 0x02
    MOVWF var3
    DECFSZ var5,1
    GOTO HOJA2
    GOTO IHOJA2
XORE
    MOVF var2, 0         
    MOVLW 0xE0             
    XORWF var2, 1
    MOVLW 0x02
    MOVWF var3
    GOTO HOJA2
    
end






