
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
var6 EQU 0x32
 org 0x00
 
    BSF STATUS, RP0 ;Bank1
    MOVLW 0x71
    MOVWF OSCCON ;FOSC INTERNA 8MHZ
    CLRF TRISB ;TRISB = 0  salida

 
    BSF STATUS, RP1 ;Bank3
    CLRF ANSELH ;Poerto B digital
    
    BCF STATUS,RP0 ; BANK0
    BCF STATUS,RP1
    
    
    
ISEC3
    movlw 0x0A
    movwf var1
    movlw 0x80
    movwf var2
    movlw 0x0F
    movwf var3
    movlw 0x02
    movwf var4
    movlw 0x04
    movwf var6
    MOVLW 0x85
    MOVWF PORTB
    CALL RETARDO
    
SECUENCIA3
    movf var1,0
    iorwf var2,0
    MOVWF PORTB
    CALL RETARDO         
    MOVLW 0x0F            
    XORWF var1, 1 
    DECFSZ var4,1
    GOTO IND1
    movf var5,0
    MOVWF var2
    movlw 0x02
    movwf var4
    DECFSZ var6,1
    GOTO SECUENCIA3
    GOTO ISEC3
    
    

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

IND1
    movf var2,0
    MOVWF var5
    RRF var5
    RRF var2
    IORWF var2,1
    GOTO SECUENCIA3
   
end
