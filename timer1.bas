$regfile "m8def.dat"
$crystal = 16000000
$baud = 19200
$framesize = 40

Config Lcdpin = Pin , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5 , Rs = Portc.0 , E = Portc.1
Config Lcd = 16 * 2
Config Com1 = Dummy , Synchrone = 0 , Parity = None , Stopbits = 1 , Databits = 8 , Clockpol = 0

'Config Timer1 = Timer , Prescale = 1024

Dim A As Double
Dim B As Byte
Dim C As Byte
A = 0


On Urxc Rec

Enable Interrupts
Enable Urxc

Do
Incr A
Cls
Lcd A
Loop

Rec:
B = Inkey()
Cls
Lcd "hello"
Lowerline
Lcd B
Wait 1
return

End                                                         'end program