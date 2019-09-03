$regfile "m128def.dat"
$crystal = 16000000
$baud = 19200
$framesize = 40
''$sim


Config Lcdpin = Pin , Rs = Porta.3 , E = Porta.4 , Db4 = Porta.5 , Db5 = Porta.6 , Db6 = Porta.7 , Db7 = Portg.2
Config Lcd = 16 * 2
Config Com1 = Dummy , Synchrone = 0 , Parity = None , Stopbits = 1 , Databits = 8 , Clockpol = 0

'Config Timer1 = Timer , Prescale = 1024

Dim A As Double
Dim B As Byte
Dim C As Byte
A = 0
B = 0


On Urxc Rec

Enable Interrupts
Enable Urxc

Do

Loop

Rec:
B = Inkey()
If B = &H3D Then
Set Portg.0
Reset Portg.1
Else
Reset Portg.0
Reset Portg.1
End If
Cls
Lcd B
Waitms 10
Return

End                                                         'end program