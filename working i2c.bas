$regfile = "m128def.dat"
$crystal = 16000000

Config Lcdpin = Pin , Db4 = Porta.5 , Db5 = Porta.6 , Db6 = Porta.7 , Db7 = Portg.2 , E = Porta.4 , Rs = Porta.3
Config Lcd = 16 * 2

'Config Portd = Output                                       'complete PortD as output

Dim Twi_control As Byte                                     'Controlregister local copy
Dim Twi_status As Byte
Dim Twi_data As Byte

Dim Newbyte As Byte                                         'Bytemerker

Declare Sub Twi_init_slave

Twi_data = 0
Call Twi_init_slave                                         'Activate TWI

 'All LEDs on
 'Portd = 0

' Main loop
Cls
Lcd "starting 69"
Waitms 1000
 Do
     'Their code could be here


     'Reset the flag
     Newbyte = 0

     'To see if TWINT is set
Twi_control = Twcr And 128                                  'Bit7 of Controlregister

     If Twi_control = &H80 Then
         Twi_status = Twsr And &HF8                         'Status

If Twi_status = &H80 Then                                   'Or Twi_status = &H88 Then
Twi_data = Twdr                                             'memorize new data
Newbyte = 1                                                 'note that a new byte is there
End If

         'TWINT must always be deleted so that it continues on the bus
Twcr = &B11000100                                           'Delete TWINT, creates ACK
End If

     'If a new byte has come, issue this to PortD
     If Newbyte <> 0 Then
                                            'Portd = Twi_data 'Output data to PortD
         Lcd Twi_data

         Waitms 250
     End If
Cls
'Lcd Twi_data
Waitms 100
 Loop

 End


 'Subprograms


 'Activate TWI as slave
 Sub Twi_init_slave
     Twsr = 0                                               'status and Prescaler to 0
     Twdr = &HFF                                            'default
     Twar = &H69                                            'Set slave address
     Twcr = &B01000100                                      'Activate TWI, switch on ACK

 End Sub