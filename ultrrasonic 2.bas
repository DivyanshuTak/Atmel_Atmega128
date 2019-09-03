$regfile "m128def.dat"
$crystal = 16000000

Config Lcdpin = Pin , Rs = Porta.3 , E = Porta.4 , Db4 = Porta.5 , Db5 = Porta.6 , Db6 = Porta.7 , Db7 = Portg.2
Config Lcd = 16 * 2

 Config Portd.7 = Output
 Config Pind.6 = Input

Echo1 Alias Pind.6
Trigger Alias Portd.7

Declare Sub Range()

Dim Temp As Integer
Dim Temp2 As Integer
Dim Dist As Integer
Dim A As Integer
Dim Echoval As Integer



Cls
Lcd "starting "
Lowerline
Lcd "ultrasonic "

Waitms 500

Do
A = 0

Set Trigger
Waitus 10
Reset Trigger

Echoval = Echo1
While Echoval = 0
Echoval = Echo1
Wend

If Echoval = 1 Then
Call Range()
End If






 Loop


 End                                                        'end program

Sub Range()
 A = 0
 Do
 A = A + 1
 Loop Until Pinf.3 = 0                                      'count until echo 0'

 Cls
 A = A / 30                                                 'divide value by 30 to get it nearly in cm'
 Lcd A
 Waitms 20

 End Sub Range()







