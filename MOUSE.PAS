unit Mouse;
 
Interface
 
Uses Crt,Dos;
 
Type
GraphCursMaskType = Record
Mask : Array[0..1,0..15] of word;
HorzHotSpot,
VertHotSpot : Integer;
end;
 
Var
StandardShapeCurs,
UpArrowCurs,
LeftArrowCurs,
CheckMarkCurs,
PointingHandCurs,
DiagonalCrossCurs,
RectangularCrossCurs,
HourGlassCurs : GraphCursMaskType;
 
MouseX,
MouseY,
ButtonPressCount,
ButtonReleaseCount,
TextScrMask,
TextCursMask : Word;
NumMouseKeys : Byte;
MousePresent : Boolean;
Mkey : (None,Left,Right,Center,LeftRight,LeftCenter,RightCenter,AllThree);
 
Procedure ResetMouse;
 
Procedure VirtualScreenSize(Var MaxX,MaxY,CellsizeX,CellsizeY : Word);
 
Procedure ShowMouseCursor;
 
Procedure HideMouseCursor;
 
Procedure GetButtonStatus;
 
Procedure SetMouseCursorPos(x,y : Word);
 
Procedure GetButtonPressInfo(KeyNum : Word);
 
Procedure GetButtonReleaseInfo(KeyNum : Word);
 
Procedure SetMinMaxHorzCursPos(Min,Max : Word);
 
Procedure SetMinMaxVertCursPos(Min,Max : Word);
 
Function BintoWord(S : String) : Word;
 
Procedure SetGraphicsCursor(var Mask : GraphCursMaskType);
 
Procedure SetSoftTextCursor(TextScrMask,TextCursMask : Word);
 
Procedure SetHardTextCursorBig;
 
Procedure SetHardTextCursorSmall;
 
Procedure ReadMouseMotionCounters(Var Hcount, Vcount : Word);
 
Procedure LightPenEmulOn;
 
Procedure LightPenEmulOff;
 
Procedure SetMickeytoPixels(HRatio,Vratio : Word);
 
Procedure ConditionalOff(x1,y1,x2,y2 : Word);
 
Procedure SetDoubleSpeed(Speed : Word);
 
Procedure SaveMouseDriverState;
 
Procedure RestoreMouseDriverState;
 
Procedure SetCrtPageNumber(Page : Word);
 
Procedure GetCrtPageNumber(Var Page : Word);
 
Function AnyMouseKeyPressed : Boolean;
 
Function LeftMouseKeyPressed : Boolean;
 
Function RightMouseKeyPressed : Boolean;
 
Function CenterMouseKeyPressed : Boolean;
 
Function LeftRightMouseKeysPressed : Boolean;
 
Function LeftCenterMouseKeysPressed : Boolean;
 
Function RightCenterMouseKeysPressed : Boolean;
 
Function AllThreeMouseKeysPressed : Boolean;
 
Implementation
 
Const
MouseDelay = 250;
 
Var
MouseSaveBuffer : Pointer;
MKP,MouseVisible : Boolean;
MouseBufferSize : Word;
Regs : Registers;
 
Function BintoWord(S : String) : Word;
 
Var
w,i,j : word;
 
Begin
W := 0;
J := 1;
for i := Length(s) Downto 1 Do
begin
w := w + (ord(s[i])-48) * j;
j := j * 2;
end;
BintoWord := w;
end;
 
Procedure DefineStandardShape;
Begin
With StandardShapeCurs Do
begin
Mask[0,0]  := BintoWord('0011111111111111');
Mask[0,1]  := BintoWord('0001111111111111');
Mask[0,2]  := BintoWord('0000111111111111');
Mask[0,3]  := BintoWord('0000011111111111');
Mask[0,4]  := BintoWord('0000001111111111');
Mask[0,5]  := BintoWord('0000000111111111');
Mask[0,6]  := BintoWord('0000000011111111');
Mask[0,7]  := BintoWord('0000000001111111');
Mask[0,8]  := BintoWord('0000000000111111');
Mask[0,9]  := BintoWord('0000000000011111');
Mask[0,10] := BintoWord('0000000111111111');
Mask[0,11] := BintoWord('0001000011111111');
Mask[0,12] := BintoWord('0011000011111111');
Mask[0,13] := BintoWord('1111100001111111');
Mask[0,14] := BintoWord('1111100001111111');
Mask[0,15] := BintoWord('1111110000111111');
 
Mask[1,0] :=  BintoWord('0000000000000000');
Mask[1,1] :=  BintoWord('0100000000000000');
Mask[1,2] :=  BintoWord('0110000000000000');
Mask[1,3] :=  BintoWord('0111000000000000');
Mask[1,4] :=  BintoWord('0111100000000000');
Mask[1,5] :=  BintoWord('0111110000000000');
Mask[1,6] :=  BintoWord('0111111000000000');
Mask[1,7] :=  BintoWord('0111111100000000');
Mask[1,8] :=  BintoWord('0111111110000000');
Mask[1,9] :=  BintoWord('0111111111000000');
Mask[1,10] := BintoWord('0111110000000000');
Mask[1,11] := BintoWord('0100110000000000');
Mask[1,12] := BintoWord('0000110000000000');
Mask[1,13] := BintoWord('0000011000000000');
Mask[1,14] := BintoWord('0000011000000000');
Mask[1,15] := BintoWord('0000001100000000');
 
HorzHotSpot := - 1;
VertHotSpot := - 1;
End;
End;
 
Procedure DefineUpArrow;
Begin
With UpArrowCurs Do
Begin
Mask[0,0]  := BintoWord('1111100111111111');
Mask[0,1]  := BintoWord('1111000011111111');
Mask[0,2]  := BintoWord('1110000001111111');
Mask[0,3]  := BintoWord('1110000001111111');
Mask[0,4]  := BintoWord('1100000000111111');
Mask[0,5]  := BintoWord('1100000000111111');
Mask[0,6]  := BintoWord('1000000000011111');
Mask[0,7]  := BintoWord('1000000000011111');
Mask[0,8]  := BintoWord('0000000000001111');
Mask[0,9]  := BintoWord('0000000000001111');
Mask[0,10] := BintoWord('1111000011111111');
Mask[0,11] := BintoWord('1111000011111111');
Mask[0,12] := BintoWord('1111000011111111');
Mask[0,13] := BintoWord('1111000011111111');
Mask[0,14] := BintoWord('1111000011111111');
Mask[0,15] := BintoWord('1111000011111111');
 
Mask[1,0] :=  BintoWord('0000000000000000');
Mask[1,1] :=  BintoWord('0000011000000000');
Mask[1,2] :=  BintoWord('0000111100000000');
Mask[1,3] :=  BintoWord('0000111100000000');
Mask[1,4] :=  BintoWord('0001111110000000');
Mask[1,5] :=  BintoWord('0001111110000000');
Mask[1,6] :=  BintoWord('0011111111000000');
Mask[1,7] :=  BintoWord('0011111111000000');
Mask[1,8] :=  BintoWord('0111111111100000');
Mask[1,9] :=  BintoWord('0000011000000000');
Mask[1,10] := BintoWord('0000011000000000');
Mask[1,11] := BintoWord('0000011000000000');
Mask[1,12] := BintoWord('0000011000000000');
Mask[1,13] := BintoWord('0000011000000000');
Mask[1,14] := BintoWord('0000011000000000');
Mask[1,15] := BintoWord('0000000000000000');
 
HorzHotSpot :=5;
VertHotSpot :=0;
End;
End;
 
Procedure DefineLeftArrow;
Begin
With LeftArrowCurs Do
Begin
Mask[0,0]  := BintoWord('1111111000011111');
Mask[0,1]  := BintoWord('1111000000011111');
Mask[0,2]  := BintoWord('0000000000000000');
Mask[0,3]  := BintoWord('0000000000000000');
Mask[0,4]  := BintoWord('0000000000000000');
Mask[0,5]  := BintoWord('1111000000011111');
Mask[0,6]  := BintoWord('1111111000011111');
Mask[0,7]  := BintoWord('1111111111111111');
Mask[0,8]  := BintoWord('1111111111111111');
Mask[0,9]  := BintoWord('1111111111111111');
Mask[0,10] := BintoWord('1111111111111111');
Mask[0,11] := BintoWord('1111111111111111');
Mask[0,12] := BintoWord('1111111111111111');
Mask[0,13] := BintoWord('1111111111111111');
Mask[0,14] := BintoWord('1111111111111111');
Mask[0,15] := BintoWord('1111111111111111');
 
Mask[1,0] :=  BintoWord('0000000000000000');
Mask[1,1] :=  BintoWord('0000000011000000');
Mask[1,2] :=  BintoWord('0000011111000000');
Mask[1,3] :=  BintoWord('0111111111111110');
Mask[1,4] :=  BintoWord('0000011111000000');
Mask[1,5] :=  BintoWord('0000000011000000');
Mask[1,6] :=  BintoWord('0000000000000000');
Mask[1,7] :=  BintoWord('0000000000000000');
Mask[1,8] :=  BintoWord('0000000000000000');
Mask[1,9] :=  BintoWord('0000000000000000');
Mask[1,10] := BintoWord('0000000000000000');
Mask[1,11] := BintoWord('0000000000000000');
Mask[1,12] := BintoWord('0000000000000000');
Mask[1,13] := BintoWord('0000000000000000');
Mask[1,14] := BintoWord('0000000000000000');
Mask[1,15] := BintoWord('0000000000000000');
 
HorzHotSpot :=0;
VertHotSpot :=3;
End;
End;
 
Procedure DefineCheckMark;
Begin
With CheckMarkCurs Do
Begin
Mask[0,0]  := BintoWord('1111111111110000');
Mask[0,1]  := BintoWord('1111111111100000');
Mask[0,2]  := BintoWord('1111111111000000');
Mask[0,3]  := BintoWord('1111111110000001');
Mask[0,4]  := BintoWord('1111111100000011');
Mask[0,5]  := BintoWord('0000011000000111');
Mask[0,6]  := BintoWord('0000000000001111');
Mask[0,7]  := BintoWord('0000000000011111');
Mask[0,8]  := BintoWord('1100000000111111');
Mask[0,9]  := BintoWord('1111000001111111');
Mask[0,10] := BintoWord('1111111111111111');
Mask[0,11] := BintoWord('1111111111111111');
Mask[0,12] := BintoWord('1111111111111111');
Mask[0,13] := BintoWord('1111111111111111');
Mask[0,14] := BintoWord('1111111111111111');
Mask[0,15] := BintoWord('1111111111111111');
 
Mask[1,0] :=  BintoWord('0000000000000000');
Mask[1,1] :=  BintoWord('0000000000000110');
Mask[1,2] :=  BintoWord('0000000000001100');
Mask[1,3] :=  BintoWord('0000000000011000');
Mask[1,4] :=  BintoWord('0000000000110000');
Mask[1,5] :=  BintoWord('0000000001100000');
Mask[1,6] :=  BintoWord('0111000011000000');
Mask[1,7] :=  BintoWord('0001110110000000');
Mask[1,8] :=  BintoWord('0000011100000000');
Mask[1,9] :=  BintoWord('0000000000000000');
Mask[1,10] := BintoWord('0000000000000000');
Mask[1,11] := BintoWord('0000000000000000');
Mask[1,12] := BintoWord('0000000000000000');
Mask[1,13] := BintoWord('0000000000000000');
Mask[1,14] := BintoWord('0000000000000000');
Mask[1,15] := BintoWord('0000000000000000');
 
HorzHotSpot :=6;
VertHotSpot :=7;
End;
End;
 
Procedure DefinePointingHand;
Begin
With PointingHandCurs Do
Begin
Mask[0,0]  := BintoWord('1110000111111111');
Mask[0,1]  := BintoWord('1110000111111111');
Mask[0,2]  := BintoWord('1110000111111111');
Mask[0,3]  := BintoWord('1110000111111111');
Mask[0,4]  := BintoWord('1110000111111111');
Mask[0,5]  := BintoWord('1110000000000000');
Mask[0,6]  := BintoWord('1110000000000000');
Mask[0,7]  := BintoWord('1110000000000000');
Mask[0,8]  := BintoWord('0000000000000000');
Mask[0,9]  := BintoWord('0000000000000000');
Mask[0,10] := BintoWord('0000000000000000');
Mask[0,11] := BintoWord('0000000000000000');
Mask[0,12] := BintoWord('0000000000000000');
Mask[0,13] := BintoWord('0000000000000000');
Mask[0,14] := BintoWord('0000000000000000');
Mask[0,15] := BintoWord('0000000000000000');
 
Mask[1,0] :=  BintoWord('0001111000000000');
Mask[1,1] :=  BintoWord('0001001000000000');
Mask[1,2] :=  BintoWord('0001001000000000');
Mask[1,3] :=  BintoWord('0001001000000000');
Mask[1,4] :=  BintoWord('0001001000000000');
Mask[1,5] :=  BintoWord('0001001111111111');
Mask[1,6] :=  BintoWord('0001001001001001');
Mask[1,7] :=  BintoWord('0001001001001001');
Mask[1,8] :=  BintoWord('1111001001001001');
Mask[1,9] :=  BintoWord('1001000000000001');
Mask[1,10] := BintoWord('1001000000000001');
Mask[1,11] := BintoWord('1001000000000001');
Mask[1,12] := BintoWord('1000000000000001');
Mask[1,13] := BintoWord('1000000000000001');
Mask[1,14] := BintoWord('1000000000000001');
Mask[1,15] := BintoWord('1111111111111111');
 
HorzHotSpot :=5;
VertHotSpot :=0;
End;
End;
 
Procedure DefineDiagonalCross;
Begin
With DiagonalCrossCurs Do
Begin
Mask[0,0]  := BintoWord('0000011111100000');
Mask[0,1]  := BintoWord('0000000110000000');
Mask[0,2]  := BintoWord('0000000000000000');
Mask[0,3]  := BintoWord('1100000000000011');
Mask[0,4]  := BintoWord('1111000000001111');
Mask[0,5]  := BintoWord('1100000000000011');
Mask[0,6]  := BintoWord('0000000000000000');
Mask[0,7]  := BintoWord('0000000110000000');
Mask[0,8]  := BintoWord('0000011111100000');
Mask[0,9]  := BintoWord('1111111111111111');
Mask[0,10] := BintoWord('1111111111111111');
Mask[0,11] := BintoWord('1111111111111111');
Mask[0,12] := BintoWord('1111111111111111');
Mask[0,13] := BintoWord('1111111111111111');
Mask[0,14] := BintoWord('1111111111111111');
Mask[0,15] := BintoWord('1111111111111111');
 
Mask[1,0] :=  BintoWord('0000000000000000');
Mask[1,1] :=  BintoWord('0111000000001110');
Mask[1,2] :=  BintoWord('0001110000111000');
Mask[1,3] :=  BintoWord('0000011001100000');
Mask[1,4] :=  BintoWord('0000001111000000');
Mask[1,5] :=  BintoWord('0000011001100000');
Mask[1,6] :=  BintoWord('0001110000111000');
Mask[1,7] :=  BintoWord('0111000000001110');
Mask[1,8] :=  BintoWord('0000000000000000');
Mask[1,9] :=  BintoWord('0000000000000000');
Mask[1,10] := BintoWord('0000000000000000');
Mask[1,11] := BintoWord('0000000000000000');
Mask[1,12] := BintoWord('0000000000000000');
Mask[1,13] := BintoWord('0000000000000000');
Mask[1,14] := BintoWord('0000000000000000');
Mask[1,15] := BintoWord('0000000000000000');
 
HorzHotSpot :=7;
VertHotSpot :=4;
End;
End;
 
Procedure DefineRectangularCross;
Begin
With RectangularCrossCurs Do
Begin
Mask[0,0]  := BintoWord('1111110001111111');
Mask[0,1]  := BintoWord('1111110001111111');
Mask[0,2]  := BintoWord('1111110001111111');
Mask[0,3]  := BintoWord('1111110001111111');
Mask[0,4]  := BintoWord('1111110001111111');
Mask[0,5]  := BintoWord('1111110001111111');
Mask[0,6]  := BintoWord('1111110001111111');
Mask[0,7]  := BintoWord('0000000000000000');
Mask[0,8]  := BintoWord('0000000000000000');
Mask[0,9]  := BintoWord('1111110001111111');
Mask[0,10] := BintoWord('1111110001111111');
Mask[0,11] := BintoWord('1111110001111111');
Mask[0,12] := BintoWord('1111110001111111');
Mask[0,13] := BintoWord('1111110001111111');
Mask[0,14] := BintoWord('1111110001111111');
Mask[0,15] := BintoWord('1111110001111111');
 
Mask[1,0] :=  BintoWord('0000000100000000');
Mask[1,1] :=  BintoWord('0000000100000000');
Mask[1,2] :=  BintoWord('0000000100000000');
Mask[1,3] :=  BintoWord('0000000100000000');
Mask[1,4] :=  BintoWord('0000000100000000');
Mask[1,5] :=  BintoWord('0000000100000000');
Mask[1,6] :=  BintoWord('0000000100000000');
Mask[1,7] :=  BintoWord('1111111111111111');
Mask[1,8] :=  BintoWord('0000000100000000');
Mask[1,9] :=  BintoWord('0000000100000000');
Mask[1,10] := BintoWord('0000000100000000');
Mask[1,11] := BintoWord('0000000100000000');
Mask[1,12] := BintoWord('0000000100000000');
Mask[1,13] := BintoWord('0000000100000000');
Mask[1,14] := BintoWord('0000000100000000');
Mask[1,15] := BintoWord('0000000100000000');
 
HorzHotSpot :=7;
VertHotSpot :=7
End;
End;
 
Procedure DefineHourGlass;
Begin
With HourGlassCurs Do
Begin
Mask[0,0]  := BintoWord('0000000000000000');
Mask[0,1]  := BintoWord('0000000000000000');
Mask[0,2]  := BintoWord('0000000000000000');
Mask[0,3]  := BintoWord('0000000000000000');
Mask[0,4]  := BintoWord('1000000000000001');
Mask[0,5]  := BintoWord('1100000000000011');
Mask[0,6]  := BintoWord('1110000000000111');
Mask[0,7]  := BintoWord('1111000000001111');
Mask[0,8]  := BintoWord('1110000000000111');
Mask[0,9]  := BintoWord('1100000000000011');
Mask[0,10] := BintoWord('1000000000000001');
Mask[0,11] := BintoWord('0000000000000000');
Mask[0,12] := BintoWord('0000000000000000');
Mask[0,13] := BintoWord('0000000000000000');
Mask[0,14] := BintoWord('0000000000000000');
Mask[0,15] := BintoWord('1111111111111111');
 
Mask[1,0] :=  BintoWord('0000000000000000');
Mask[1,1] :=  BintoWord('0111111111111110');
Mask[1,2] :=  BintoWord('0110000000000110');
Mask[1,3] :=  BintoWord('0011000000001100');
Mask[1,4] :=  BintoWord('0001100000011000');
Mask[1,5] :=  BintoWord('0000110000110000');
Mask[1,6] :=  BintoWord('0000011001100000');
Mask[1,7] :=  BintoWord('0000001111000000');
Mask[1,8] :=  BintoWord('0000011001100000');
Mask[1,9] :=  BintoWord('0000110000110000');
Mask[1,10] := BintoWord('0001100000011000');
Mask[1,11] := BintoWord('0011000000001100');
Mask[1,12] := BintoWord('0110000000000110');
Mask[1,13] := BintoWord('0111111111111110');
Mask[1,14] := BintoWord('0000000000000000');
Mask[1,15] := BintoWord('0000000000000000');
 
HorzHotSpot :=7;
VertHotSpot :=7;
End;
End;
 
Procedure SetKeyStatus(Mstatus : Word);
Begin
Case Mstatus of
0 : Mkey := None;
1 : Mkey := Left;
2 : Mkey := Right;
3 : Mkey := LeftRight;
4 : Mkey := Center;
5 : Mkey := LeftCenter;
6 : Mkey := RightCenter;
7 : Mkey := AllThree;
End;
End;
 
Procedure ResetMouse;
Begin
Regs.AX := 0;
Intr($33,Regs);
With Regs Do
Begin
MousePresent := AX > 0;
If MousePresent Then NumMouseKeys := BX
Else
NumMouseKeys := 0;
End;
MouseVisible := False;
End;
 
Procedure VirtualScreenSize(Var MaxX, MaxY, CellSizeX, CellSizeY : Word);
Begin
Regs.AH := $0F;
Intr($10,Regs);
Case Regs.AL Of
0,1:
    Begin
         MaxX := 640;
         MaxY := 200;
         CellSizeX := 16;
         CellSizeY := 8;
         End;
 
2,3,7:
      Begin
           MaxX := 640;
           MaxY := 200;
           CellSizeX := 8;
           CellSizeY := 8;
           End;
 
4,5:
    Begin
         MaxX := 640;
         MaxY := 200;
         CellSizeX := 2;
         CellSizeY := 1;
         End;
 
6:
  Begin
       MaxX := 640;
       MaxY := 200;
       CellSizeX := 1;
       CellSizeY := 1;
       End;
 
13:
   Begin
        MaxX := 640;
        MaxY := 200;
        CellSizeX := 16;
        CellSizeY := 8;
        End;
 
14,15:
      Begin
           MaxX := 640;
           MaxY := 350;
           CellSizeX := 1;
           CellSizeY := 1;
           End;
 
      End;
End;
 
Procedure ShowMouseCursor;
Begin
If Not MouseVisible Then
   Begin
   Regs.AX := 1;
   Intr($33,Regs);
   MouseVisible := True;
   End;
End;
 
Procedure HideMouseCursor;
Begin
If MouseVisible Then
   Begin
   Regs.AX := 2;
   Intr($33,Regs);
   MouseVisible := False;
   End;
End;
 
Procedure GetButtonStatus;
Begin
     Regs.AX := 3;
     Intr($33,Regs);
     With Regs Do
          Begin
          SetKeyStatus(BX);
          MouseX := CX;
          MouseY := DX;
          End;
End;
 
Procedure SetMouseCursorPos(X,Y : Word);
Begin
     With Regs Do
          Begin
          AX := 4;
          CX := X;
          DX := Y;
          End;
 
     Intr($33,Regs);
     MouseX := X;
     MouseY := Y;
End;
 
Procedure GetButtonPressInfo(KeyNum : Word);
Begin
With Regs Do
Begin
AX := 5;
BX := KeyNum - 1;
End;
Intr($33,Regs);
With Regs Do
Begin
SetKeyStatus(AX);
ButtonPressCount := BX;
MouseX := CX;
MouseY := DX;
End;
End;
 
Procedure GetButtonReleaseInfo(KeyNum : Word);
Begin
With Regs Do
Begin
AX := 6;
BX := KeyNum - 1;
End;
Intr($33,Regs);
With Regs Do
Begin
SetKeyStatus(AX);
ButtonReleaseCount := BX;
MouseX := CX;
MouseY := DX;
End;
End;
 
Procedure SetMinMaxHorzCursPos(Min,Max : Word);
Begin
With Regs Do
Begin
AX := 7;
CX := Min;
DX := Max;
End;
Intr($33,Regs);
End;
 
Procedure SetMinMaxVertCursPos(Min,Max : Word);
Begin
With Regs Do
Begin
AX := 7;
CX := Min;
DX := Max;
End;
Intr($33,Regs);
End;
 
Procedure SetGraphicsCursor(Var Mask: GraphCursMaskType);
Begin
With Regs Do
Begin
AX := 9;
BX := Word(Mask.HorzHotSpot);
CX := Word(Mask.VertHotSpot);
DX := Ofs(Mask);
ES := Seg(Mask);
End;
Intr($33,Regs);
End;
 
Procedure SetSoftTextCursor(TextScrMask, TextCursMask : Word);
Begin
With Regs Do
Begin
AX := 10;
BX := 0;
CX := TextScrMask;
DX := TextCursMask;
End;
Intr($33,Regs);
End;
 
Procedure SetHardTextCursorBig;
Begin
With Regs Do
Begin
AX := 10;
BX := 1;
CX := 0;
DX := 7;
End;
Intr($33,Regs);
End;
 
Procedure SetHardTextCursorSmall;
Begin
With Regs Do
Begin
AX := 10;
BX := 1;
CX := 6;
DX := 7;
End;
Intr($33,Regs);
End;
 
Procedure ReadMouseMotionCounters(Var Hcount,Vcount : Word);
Begin
Regs.AX := 11;
Intr($33,Regs);
With Regs Do
Begin
Hcount := CX;
Vcount := DX;
End;
End;
 
Procedure LightPenEmulOn;
Begin
Regs.AX := 13;
Intr($33,Regs);
End;
 
Procedure LightPenEmulOff;
Begin
Regs.AX := 14;
Intr($33,Regs);
End;
 
Procedure SetMickeytoPixels(HRatio,VRatio : Word);
Begin
With Regs Do
Begin
AX := 15;
CX := HRAtio;
DX := VRatio;
End;
Intr($33,Regs);
End;
 
Procedure ConditionalOff(X1,Y1,X2,Y2 : Word);
Begin
With Regs Do
Begin
AX := 16;
CX := X1;
DX := Y2;
SI := X1;
DI := Y2;
End;
Intr($33,Regs);
End;
 
Procedure SetDoubleSpeed(Speed : Word);
Begin
With Regs Do
Begin
AX := 19;
DX := Speed;
End;
Intr($33,Regs);
End;
 
Procedure GetMouseSaveSize;
Begin
Regs.AX := 21;
Intr($33,Regs);
MouseBufferSize := Regs.BX;
End;
 
Procedure SaveMouseDriverState;
Begin
GetMem(MouseSaveBuffer,MouseBufferSize);
With Regs Do
Begin
AX := 22;
DX := Ofs(MouseSaveBuffer^);
ES := Seg(MouseSaveBuffer^);
End;
Intr($33,Regs);
End;
 
Procedure RestoreMouseDriverState;
Begin
With Regs Do
Begin
AX := 23;
DX := Ofs(MouseSaveBuffer^);
ES := Seg(MouseSaveBuffer^);
End;
Intr($33,Regs);
FreeMem(MouseSaveBuffer,MouseBufferSize);
End;
 
Procedure SetCrtPageNumber(Page : Word);
Begin
With Regs Do
Begin
AX := 29;
BX := Page;
End;
Intr($33,Regs);
End;
 
Procedure GetCrtPageNumber(Var Page : Word);
Begin
Regs.AX := 23;
Intr($33,Regs);
Page := Regs.BX;
End;
 
Function AnyMouseKeyPressed : Boolean;
Begin
If MKP Then Delay(MouseDelay);
GetButtonStatus;
MKP := Mkey <> None;
AnyMouseKeyPressed := MKP;
End;
 
Function LeftMouseKeyPressed : Boolean;
Begin
If MKP Then Delay(MouseDelay);
GetButtonStatus;
MKP := Mkey = Left;
LeftMouseKeyPressed := MKP;
End;
 
Function RightMouseKeyPressed : Boolean;
Begin
If MKP Then Delay(MouseDelay);
GetButtonStatus;
MKP := Mkey = Right;
RightMouseKeyPressed := MKP;
End;
 
Function CenterMouseKeyPressed : Boolean;
Begin
If MKP Then Delay(MouseDelay);
GetButtonStatus;
MKP := Mkey = Center;
CenterMouseKeyPressed := MKP;
End;
 
Function LeftRightMouseKeysPressed : Boolean;
Begin
If MKP Then Delay(MouseDelay);
GetButtonStatus;
MKP := Mkey = LeftRight;
LeftRightMouseKeysPressed := MKP;
End;
 
Function LeftCenterMouseKeysPressed : Boolean;
Begin
If MKP Then Delay(MouseDelay);
GetButtonStatus;
MKP := Mkey = LeftCenter;
LeftCenterMouseKeysPressed := MKP;
End;
 
Function RightCenterMouseKeysPressed : Boolean;
Begin
If MKP Then Delay(MouseDelay);
GetButtonStatus;
MKP := Mkey = RightCenter;
RightCenterMouseKeysPressed := MKP;
End;
 
Function AllThreeMouseKeysPressed : Boolean;
Begin
If MKP Then Delay(MouseDelay);
GetButtonStatus;
MKP := Mkey = AllThree;
AllThreeMouseKeysPressed := MKP;
End;
 
Begin
ResetMouse;
DefineStandardShape;
DefineUpArrow;
DefineLeftArrow;
DefineCheckMark;
DefinePointingHand;
DefineDiagonalCross;
DefineRectangularCross;
DefineHourGlass;
MKP := False;
End.