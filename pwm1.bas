$regfile "m32def.dat"
$baud = 19200
$crystal = 16000000
$hwstack = 32
$swstack = 10
$framesize = 40

Dim X As Integer
Dim Y As Integer

Config Timer1 = Pwm , Pwm = 10 , Compare A Pwm = Clear Down , Compare B Pwm = Clear Down , Prescale = 1024

Dim Time_dummy As Integer
Pwm1a = 66
Do
Waitms 1
Time_dummy + +
Loop Until Dummy_time = 1000

Do
Loop

Do
Pwm1b = Y
Incr Y
Waitms 100
Loop Until Y = 255

End                                                         'end program