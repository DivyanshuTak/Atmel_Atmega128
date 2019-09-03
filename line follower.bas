$regfile "m128def.dat"
$crystal = 16000000
$baud = 19200
$swstack = 10
$hwstack = 32
$framesize = 40

Config Porta = Output
Config Portc = Input

While Pinc.4 = 0

If Pinc.7 = 1 Then
Set Porta.1
Reset Porta.2
Reset Porta.3
Reset Porta.4

Elseif Pinc.1 = 1 Then
Reset Porta.1
Reset Porta.2
Set Porta.3
Reset Porta.4

Elseif Pinc.6 = 1 Then
Set Porta.1
Reset Porta.2
Reset Porta.3
Reset Porta.4

Elseif Pinc.2 = 1 Then
Reset Porta.1
Reset Porta.2
Set Porta.3
Reset Porta.4

Elseif Pinc.5 = 1 Then
Set Porta.1
Reset Porta.2
Reset Porta.3
Reset Porta.4

Elseif Pinc.3 = 1 Then
Reset Porta.1
Reset Porta.2
Set Porta.3
Reset Porta.4

End If
Wend

If Pinc.4 = 1
Set Porta.1
Reset Porta.2
Set Porta.3
Reset Porta.4

End If
End
