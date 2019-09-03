$regfile "m8def.dat"
$crystal = 16000000
$baud = 19200
$framesize = 40
$sim


Config Lcdpin = Pin , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5 , Rs = Portc.0 , E = Portc.1
Config Lcd = 16 * 2
'Config Com1 = Dummy , Synchrone = 0 , Parity = None , Stopbits = 1 , Databits = 8 , Clockpol = 0
'Config Adc = Single , Prescaler = Auto
'Config Timer1 = Timer , Prescale = 1024

Dim A As Double
Dim B As Byte
Dim C As Byte


Dim Pind.1 As Input

'(C = 2
Do
A = Getadc(c)
If A <= 200 Then
Cls
Upperline
Lcd "near"
Lowerline
Lcd A

Elseif A > 200 Then
Cls
Upperline
Lcd "far"
Lowerline
Lcd A

End If

Loop
End  ')                                                       'end program