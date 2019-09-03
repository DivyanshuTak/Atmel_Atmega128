$regfile "m128def.dat"
$crystal = 16000000

''Config Lcdpin = Pin , Rs = Porta.3 , E = Porta.4 , Db4 = Porta.5 , Db5 = Porta.6 , Db6 = Porta.7 , Db7 = Portg.2
'Config Lcd = 16 * 2

Declare Sub I2c_reciever_init()
Declare Sub I2c_communicate()
'Declare Sub Interrupt()

''Config Portd = Output
Config Portd = Output
Config Portb = Output

Dim Readl(25) As Integer
Dim Readlength As Integer
Dim I2c_read(25) As Integer
Dim Flag As Integer
Dim B As Byte
Dim Value As Integer
Dim Addr As Byte
Dim Stat As Integer
Dim Temp As Integer

'Readlength = 1
'Cksel = &B00001110                                          '& =(7 << 1)

    Enable Interrupts
    Enable Twi
    On Twi Interrupt

'///**************main ******************************************************************

Call I2c_reciever_init()
Do


   '' Call Interrupt()
      If Flag = 1 Then
          Cls
     Lcd Value
   Portb = Value
     End If
        Flag = 0
        Waitms 100
                                                 'I2c_communica
Loop

                                                'end program
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


'//////////////////////initialise//////////////////////////////////////////////////////
Sub I2c_reciever_init()



''Twsr = 0
 ''Twdr = &HFF
 ''Twcr = &H04                                                'Prescalar value =1
 ''Twar = &H69                                                'adress 0x69
 ''Twcr = &B11000100

Twar = $44
 ''Reset Twcr.twint
Set Twcr.twie
Set Twcr.twen
Set Twcr.twea
Reset Twcr.twsta
Reset Twcr.twsto

    Cls
    Lcd "initialised 69"
    Lowerline
    Lcd "odd"
    Waitms 100

  End Sub I2c_reciever_init()

'///////////////////////////////////////////////////////////////////////////////////////

'|||||||||||||||||||||||||||||||||||communicate|||||||||||||||||||||||||||||||||||||||||
'(Sub I2c_communicate()


 ' If Addr = &B01000101 Then

    Cls
    Lcd Value


    Waitms 100
 ' End If


  End Sub
')

'///////////////////////////////////////////////////////////////////////////////////////


'+++++++++++++++++++++++++++++++++++++++ISR(I2C)++++++++++++++++++++++++++++++++++++++++
Interrupt:

Temp = Twcr And 128

If Temp = &H80 Then
Stat = Twsr And &HF8

''If Stat = &H80 Then



Select Case Stat



Case $60:
Addr = Twdr
''Twcr = Twcr Or &B11000000
''Twcr.6 = 1

''Case $68:
  '' Value = Twdr
''Twcr = Twcr Or &B11000000
''Twcr.6 = 1

Case $80:
  Value = Twdr

''Twcr = Twcr Or &B11000000

  Flag = 1

''Case $a0:
''Twcr = Twcr And &B11000000
''Twcr.6 = 1

End Select


End If
 Twcr = &B11000101
Return

'//////////////////////////////////////