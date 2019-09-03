$regfile = "attiny85.dat"                                   'ATTINY85

$crystal = 16000000
$hwstack = 32
$swstack = 10
$framesize = 40

A1 Alias Pinb.2
B1 Alias Pinb.0

Dir1 Alias Portb.1

Dim Rising1 As Byte
Dim Rising2 As Byte

Dim I1 As Byte
Dim I2 As Byte

Config Portb = &B00000010



Rising1 = 0
I1 = 0


Do

      Rising1 = 0

      If A1 = 0 Then
            I1 = 0
      Else
         If I1 = 0 Then
            I1 = 1
            Rising1 = 1
         End If
      End If

      If Rising1 = 1 Then

         If B1 = 1 Then
            Set Dir1
         Elseif B1 = 0 Then
            Reset Dir1
         End If

      End If



Loop

End