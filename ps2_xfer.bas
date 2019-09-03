$regfile "m8def.dat"
$crystal = 16000000
$baud = 57600
$hwstack = 32                                               ' Hardware Stack 32
$swstack = 10                                               ' Software Stack 10
$framesize = 40                                             ' Frame space 40

'###########################################      CONFIG PART + DECLARATION      ##############################################################

'------------------------portc only for testing the ps2--------------
Config Portc.0 = Output
Config Portc.1 = Output
Config Portc.2 = Output
Config Portc.3 = Output

Reset Portc.0
Reset Portc.1
Reset Portc.2
Reset Portc.3
'----------------------------------------------------------------------

Config Portb.0 = Input                                      'Portb.6 = Output                                     'ATN
Config Portb.4 = Output                                     'Portd.5 = Output                                     'CLK
Config Portb.5 = Output                                     'Portd.6 = Output                                     'CMD
Config Portd.5 = Output                                     'Portb.6 = Input                                      'DAT
Config Portd.6 = Input                                      'Portb.2 = Input                                      'ACK

Config Com1 = Dummy , Synchrone = 0 , Parity = None , Stopbits = 1 , Databits = 8 , Clockpol = 0
Open "com1:" For Binary


'(
Config Porte.5 = Input                                      'ack
Config Porte.6 = Output                                     'cmd
Config Porte.7 = Input                                      'data
Config Portb.2 = Output                                     'atn
Config Portb.3 = Output                                     'clk


Config Portf.0 = Output
Config Portf.1 = Output
Config Portf.2 = Output
Config Portf.3 = Input
Config Portf.4 = Input
')

Dim D0 As Byte , D1 As Byte , D2 As Byte , D3 As Byte , D4 As Byte , D5 As Byte , D6 As Byte , D7 As Byte , D8 As Byte , D9 As Byte , D10 As Byte , D11 As Byte , D12 As Byte , D13 As Byte , D14 As Byte , D15 As Byte , D16 As Byte , D17 As Byte , D18 As Byte , D19 As Byte , D20 As Byte
Dim C0 As Byte , C1 As Byte , C2 As Byte , C3 As Byte , C4 As Byte , C5 As Byte , C6 As Byte , C7 As Byte , C8 As Byte , C9 As Byte , C10 As Byte , C11 As Byte , C12 As Byte , C13 As Byte , C14 As Byte , C15 As Byte , C16 As Byte , C17 As Byte , C18 As Byte , C19 As Byte , C20 As Byte
Dim Binaryv(8) As Byte , Flag As Byte , Adcval As Single , Datamain As Byte , Count As Integer

Declare Sub Ps2(datum As Byte , Byval Command As Byte )

'###############################################        VALUE ASSIGNMENT          ############################################
'6,7ack,8cmd,9dat,12atn,13clk
'command - pf3 attention- pf1  data- pf2  ack - pf4 clock- pf0  portf.3 not working so using f.5 by shorting it

Datamain = 0
Count = 0

Dat Alias Pinb.0
Clk Alias Portb.4                                           'Portd.6                                           ''
Cmd Alias Portb.5                                           'Portd.5                                           'same as dat but input
Atnt Alias Portd.6                                          'Portb.6
Ackn Alias Pind.5                                           'Pinb.2
'(

Clk Alias Portb.3
Atnt Alias Portb.2
Dat Alias Pine.7
Cmd Alias Porte.6
Ackn Alias Pine.5

Clk Alias Portf.0
Atnt Alias Portf.1
Cmd Alias Portf.2                                           'pf2=DI:pf3=DO:pf4=ACK:pf0=CLK:pf1=CS
Dat Alias Pinf.3
Ackn Alias Pinf.4
')

Set Clk
Set Atnt


Binaryv(1) = 1
Binaryv(2) = 2
Binaryv(3) = 4
Binaryv(4) = 8
Binaryv(5) = 16
Binaryv(6) = 32
Binaryv(7) = 64
Binaryv(8) = 128


'cls
''cls "test"
'Wait 2
'-----------------------------------------short poll - to refresh and initiate ----------------------------------------
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Dim I As Integer
I = 0
For I = 0 To 3
Call Ps2(d1 , &H01)
Call Ps2(d1 , &H42)
Call Ps2(d1 , &H00)
Call Ps2(d1 , &HFF)
Call Ps2(d1 , &HFF)

Next



'-------------------------------------------------------------------------------------------------------------------------
'--------------------------------=====================CONFIG THE PS2==================------------------------------------
'------------------------------=====================go into CONFIG mode==================------------------------------------

'cls
''cls "in 1:"
Printbin 1

Do
D3 = D4 = 0
D1 = D2 = 0
D5 = D6 = 0
Reset Atnt
Waitus 10
Call Ps2(d1 , &H01)
Call Ps2(d2 , &H43)

If D2 = &H73 Then
 Goto 1
Else
 Exit Do
End If

Loop

Call Ps2(d3 , &H00)
Call Ps2(d4 , &H01)
Call Ps2(d5 , &H00)

Set Atnt


'----------------------------===============SET CONTROLLER FOR ANALOGUE MODE================------------------------
Printbin 2
'cls
''cls "in analogue"

Do

Reset Atnt
Waitus 10
D3 = D4 = 0
D1 = D2 = 0
D5 = D6 = 0
D7 = D8 = 0
D9 = 0

Call Ps2(d1 , &H01)
Call Ps2(d2 , &H44)
Call Ps2(d3 , &H00)
If D2 = &HF3 Then                                           '''''''''''''''''''''''''''''''''''''''''''''''''''
 Exit Do
Else
 Printbin D2
End If
Loop


Call Ps2(d4 , &H01)
Call Ps2(d5 , &H03)
Call Ps2(d6 , &H00)
Call Ps2(d7 , &H00)
Call Ps2(d8 , &H00)
Call Ps2(d9 , &H00)
Set Atnt

'--------------------------------==================EXIT THE CONFIG MODE=====================----------------------------------
Printbin 3
'cls
''cls "exit"

'Do
D3 = D4 = 0
D1 = D2 = 0
D5 = D6 = 0
D7 = D8 = 0
Datamain = 0

Waitus 10
Reset Atnt

Call Ps2(d1 , &H01)
Call Ps2(datamain , &H43)
Call Ps2(d2 , &H00)

If Datamain = &H73 Then
 Set Atnt
' Exit Do
End If
Set Atnt
Waitus 20
'Loop


Call Ps2(d3 , &H00)
Call Ps2(d4 , &H5A)
Call Ps2(d5 , &H5A)
Call Ps2(d6 , &H5A)
Call Ps2(d7 , &H5A)
Call Ps2(d8 , &H5A)
Set Atnt


'---------------------------------------------------POLLING STARTS---------------------------------------------------------
1:
'cls
''cls "polling"

Printbin 4

Do

2:
Reset Atnt
Waitus 10
D3 = D4 = 0
D1 = D2 = 0
D5 = D6 = 0
D7 = D8 = 0
D9 = D10 = 0

Call Ps2(d1 , &H01)
Call Ps2(d2 , &H42)
Call Ps2(d3 , &H00)
Call Ps2(d4 , &H00)
Call Ps2(d5 , &H00)
Call Ps2(d6 , &H00)
Call Ps2(d7 , &H00)
Call Ps2(d8 , &H00)
Call Ps2(d9 , &H00)
Call Ps2(d10 , &H00)
Set Atnt

'cls
''cls D4 ; " " ; D5 ; " " ; D6
'''Lowerline
''cls D7 ; " " ; D8 ; " " ; D9

'(If D5 = 223 Then
 Set Portc.0
Else
 Reset Portc.0
End If

If D5 = 239 Then
 Set Portc.1
Else
 Reset Portc.1
End If

If D5 = 127 Then
 Set Portc.2
Else
 Reset Portc.2
End If

If D5 = 191 Then
 Set Portc.3
Else
 Reset Portc.3
End If

')
Waitms 10

Printbin D5

Loop


'++++++++++++++++++++++++++++++++++++++++           sender/receiver function            ++++++++++++++++++++++++++++++++++++++++

Sub Ps2(datum As Byte , Command As Byte)

  Dim A As Integer , C As Byte , D As Bit , E As Byte , B1 As Byte
  A = 1
  Datum = 0

  For A = 1 To 8
  Reset Clk

  B1 = Command Mod 2

  If B1 = 1 Then
    Set Cmd

  Elseif B1 = 0 Then
     Reset Cmd

  End If

  Waitus 2                                                  '2 kar dena baad me
  Set Clk
  Waitus 1

  D = Dat

  If D = 1 Then
    Datum = Datum + Binaryv(a)
  End If

  Command = Command / 2

  Next A

  Waitus 12

End Sub


End                                                         'end program