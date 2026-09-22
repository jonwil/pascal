uses mouse,graph,crt,bgiref,dos,maptpu;
type brec = record
x1,x2,y1,y2 : integer;
end;
var
   exitx:boolean;
   xyz:boolean;
   rb   : integer;   {radio button data}
   tarr:array[1..3] of pointType;
   t1,t2:integer;
   okey : boolean; {ok?}
   cb1  : boolean; {combo box data}
   l,m,k: integer; {loop vars}
   barr : array[1..16] of brec; {control records}
   check: array[1..5] of boolean; {check box data}
   c:graphcursmasktype; {cursor}
   f    : text; {file}
   kl:integer; {combo box data}
procedure barj(x,y,ex,ey:integer);
var
g:fillsettingstype;
gg:word;
begin
getfillsettings(g);
gg := g.color;
for l := x to ex do
begin
for m := y to ey do
begin
putpixel(l,m,gg);
end;
end;
end;
function inbu(n:integer):boolean;
var a:integer;
begin
with barr[n] do
begin
a := 0;
if mousex < x2+3 then
a := a + 1;
if mousex > x1+3 then
a := a + 1;
if mousey < y2+20 then
a := a + 1;
if mousey > y1+20 then
a := a + 1;
end;
if a = 4 then
inbu := true;
end;
procedure drawbutton(x,y,ex,ey:integer;text:string;bn:integer);
begin;
with barr[bn] do
begin
x1 := x;
x2 := ex;
y1 := y;
y2 := ey;
end;
setfillstyle(emptyfill,7);
barj(x,y,ex,ey);
setfillstyle(emptyfill,8);
barj(x+3,y+3,ex-3,ey-3);
setcolor(black);
setusercharsize(0,4,0,4);
settextstyle(defaultfont,horizdir,3{usercharsize});
setbkcolor(0);
outtextxy(x+7,y+7,text);
end;
procedure drawlbi(x,y,ex,ey:integer;text:string;bn,c:integer);
begin;
with barr[bn] do
begin
x1 := x;
x2 := ex;
y1 := y;
y2 := ey;
end;
setfillstyle(emptyfill,c);
barj(x,y,ex,ey);
setcolor(black);
setusercharsize(0,4,0,4);
settextstyle(defaultfont,horizdir,3);
setbkcolor(0);
outtextxy(x+3,y+3,text);
end;
procedure drawcb(x,y,ex,ey:integer;text:string;bn,cn:integer);
begin;
with barr[bn] do
begin
x1 := x+12;
x2 := x+29;
y1 := y+9;
y2 := y+27;
end;
setfillstyle(emptyfill,15);
barj(x,y,ex,ey);
setfillstyle(emptyfill,7);
barj(x+12,y+9,x+29,y+27);
setcolor(8);
if check[cn] = true then
begin
setlinestyle(0,0,thickwidth);
rectangle(x+14,y+10,x+28,y+26);
line(x+13,y+10,x+28,y+26);
line(x+13,y+26,x+28,y+10);
end;
setcolor(black);
setusercharsize(0,4,0,4);
settextstyle(defaultfont,horizdir,3);
setbkcolor(0);
textcolor(15);
outtextxy(x+35,y+6,text);
end;
procedure drawrb(x,y,ex,ey:integer;text:string;bn:integer);
begin;
with barr[bn] do
begin
x1 := x+12;
x2 := x+29;
y1 := y+9;
y2 := y+27;
end;
setfillstyle(emptyfill,15);
barj(x,y,ex,ey);
setcolor(8);
setlinestyle(0,0,normwidth);
setfillstyle(solidfill,8);
t1 := x+8+12;
t2 := y+8+9;
fillellipse(t1,t2,8,8);
if rb = bn then
begin
setcolor(7);
setlinestyle(0,0,normwidth);
setfillstyle(solidfill,7);
fillellipse(t1,t2,5,5);
end;
setcolor(black);
setusercharsize(0,4,0,4);
settextstyle(defaultfont,horizdir,3);
setbkcolor(0);
textcolor(15);
outtextxy(x+35,y+6,text);
end;
procedure drawcombo(x,y,ex,ey:integer;text:string;bn:integer);
begin;
with barr[bn] do
begin
x1 := ex-18;
x2 := ex;
y1 := ey-18;
y2 := ey;
end;
setfillstyle(emptyfill,8);
barj(x-2,y-2,ex+2,ey+2);
setfillstyle(emptyfill,15);
barj(x,y,ex,ey);
setfillstyle(emptyfill,7);
barj(ex-27,y,ex,ey);
setfillstyle(emptyfill,8);
barj(ex-18,y+2,ex-9,ey-13);
tarr[1].y := ey-12;
tarr[2].y := ey-12;
tarr[1].x := ex-6;
tarr[2].x := ex-21;
tarr[3].y := ey-6;
t1 := tarr[2].x - tarr[1].x;
t2 := t1 div 2;
tarr[3].x := tarr[1].x + t2;
setfillstyle(solidfill,8);
fillpoly(3,tarr);
setcolor(black);
setusercharsize(0,4,0,4);
settextstyle(defaultfont,horizdir,3);
setbkcolor(0);
textcolor(15);
outtextxy(x+3,y+3,text);
end;
label lm;
begin
lm:With c Do
begin
Mask[0,0]  := BintoWord('0000000000000000');
Mask[0,1]  := BintoWord('0000000000000000');
Mask[0,2]  := BintoWord('0000000000000000');
Mask[0,3]  := BintoWord('0001111111111000');
Mask[0,4]  := BintoWord('0001000000001000');
Mask[0,5]  := BintoWord('0001000000001000');
Mask[0,6]  := BintoWord('0001000000001000');
Mask[0,7]  := BintoWord('0001000110001000');
Mask[0,8]  := BintoWord('0001000110001000');
Mask[0,9]  := BintoWord('0001000000001000');
Mask[0,10] := BintoWord('0001000000001000');
Mask[0,11] := BintoWord('0001000000001000');
Mask[0,12] := BintoWord('0001111111111000');
Mask[0,13] := BintoWord('0000000000000000');
Mask[0,14] := BintoWord('0000000000000000');
Mask[0,15] := BintoWord('0000000000000000');
 
Mask[1,0] :=  BintoWord('0000000000000000');
Mask[1,1] :=  BintoWord('0111111111111110');
Mask[1,2] :=  BintoWord('0100000000000010');
Mask[1,3] :=  BintoWord('0100000000000010');
Mask[1,4] :=  BintoWord('0100111111110010');
Mask[1,5] :=  BintoWord('0100100000010010');
Mask[1,6] :=  BintoWord('0100100000010010');
Mask[1,7] :=  BintoWord('0100100000010010');
Mask[1,8] :=  BintoWord('0100100000010010');
Mask[1,9] :=  BintoWord('0100100000010010');
Mask[1,10] := BintoWord('0100100000010010');
Mask[1,11] := BintoWord('0100111111110010');
Mask[1,12] := BintoWord('0100000000000010');
Mask[1,13] := BintoWord('0100000000000010');
Mask[1,14] := BintoWord('0111111111111110');
Mask[1,15] := BintoWord('0000000000000000');
 
HorzHotSpot := 8;
VertHotSpot := 8;
End;
init;
randomize;
setcolor(8);
setfillstyle(emptyfill,1);
barj(0,0,getmaxx,15);
setfillstyle(emptyfill,7);
barj(0,0,15,15);
barr[15].x1 := 0-3;
barr[15].y1 := 0-20;
barr[15].x2 := 15-3;
barr[15].y2 := 15-20;
barr[16].x1 := getmaxx-3-15;
barr[16].y1 := 0-20;
barr[16].x2 := getmaxx-3;
barr[16].y2 := 15-20;
setfillstyle(emptyfill,7);
barj(getmaxx-15,0,getmaxx,15);
setfillstyle(emptyfill,8);
barj(3,5,12,8);
barj(getmaxx-13,2,getmaxx-2,11);
setlinestyle(0,0,thickwidth);
rectangle(0,15,getmaxx,getmaxy);
setviewport(3,20,getmaxx-3,getmaxy-3,true);
for l := 1 to 5 do
check[l] := true;
cb1 := true;
rb := 13;
exitx := false;
xyz := true;
setgraphicscursor(standardshapecurs);
setfillstyle(emptyfill,8);
barj(3,48,50+10+2,50+30+30+2);
setfillstyle(emptyfill,15);
{barj(0,0,getmaxx,getmaxy);}
drawlbi(5,50,50+10,50+30,'l1',5,15);
drawlbi(5,50+30,50+10,50+30+30,'l2',6,15);
setlinestyle(0,0,3);
drawbutton(1,1,62,40,'s1',1);
drawbutton(67,1,127,40,'s2',2);
drawbutton(242,1,344,40,'exit',7);
drawbutton(242,50,392,90,'train',9);
drawbutton(352,1,452,40,'tool',8);
drawcombo(450,200,600,230,'',10);
okey := true;
assign(f,'notrain.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+400,m+50,k);
end;
close(f);
setfillstyle(emptyfill,15);
barj(135,1,235,110);
setfillstyle(emptyfill,8);
barj(135,30,235,110);
setfillstyle(emptyfill,15);
outtextxy(137,2,'gb');
setcolor(8);
setcolor(0);
drawcb(138,33,232,70,'cb',3,1);
drawcb(138,70,232,107,'c2',4,2);
setfillstyle(emptyfill,15);
barj(135,201,235,310);
setfillstyle(emptyfill,8);
barj(135,230,235,310);
setfillstyle(emptyfill,15);
outtextxy(137,202,'gb2');
setcolor(8);
setcolor(0);
drawrb(138,233,232,270,'rb',13);
drawrb(138,270,232,307,'r2',14);
showmousecursor;
repeat
begin
getbuttonstatus;
if (mkey = left) and (inbu(1) = true) then
begin
sound(random(150)+150);
delay(500);
nosound;
end;
if (mkey = left) and (inbu(2) = true) then
begin
sound(random(200)+150+150);
delay(500);
nosound;
end;
if (mkey = left) and (inbu(3) = true) then
begin
if check[1] = true then
check[1] := false
else
if check[1] = false then
check[1] := true;
hidemousecursor;
setfillstyle(emptyfill,0);
drawcb(138,33,232,70,'cb',3,1);
showmousecursor;
mkey := none;
end;
if (mkey = left) and (inbu(4) = true) then
begin
if check[2] = true then
check[2] := false
else
if check[2] = false then
check[2] := true;
hidemousecursor;
setfillstyle(emptyfill,0);
drawcb(138,70,232,107,'c2',4,2);
showmousecursor;
mkey := none;
end;
if (mkey = left) and (inbu(5) = true) then
begin
hidemousecursor;
drawlbi(5,50,50+10,50+30,'l1',5,3);
drawlbi(5,50+30,50+10,50+30+30,'l2',6,15);
showmousecursor;
end;
if (mkey = left) and (inbu(6) = true) then
begin
hidemousecursor;
drawlbi(5,50,50+10,50+30,'l1',5,15);
drawlbi(5,50+30,50+10,50+30+30,'l2',6,3);
showmousecursor;
end;
if (mkey = left) and (inbu(7) = true) then
exitx := true;
if (mkey = left) and (inbu(8) = true) then
begin
if xyz = true then
begin
hidemousecursor;
assign(f,'sdodge.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+350,m+200,k);
end;
close(f);
assign(f,'scrash.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+390,m+200,k);
end;
close(f);
assign(f,'slane.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+350,m+240,k);
end;
close(f);
assign(f,'scross.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+390,m+240,k);
end;
assign(f,'spot.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+350,m+280,k);
end;
close(f);
assign(f,'sramp.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+390,m+280,k);
end;
assign(f,'stunnel.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+350,m+320,k);
end;
close(f);
assign(f,'sstart.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+390,m+320,k);
end;
assign(f,'spin1.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+350,m+360,k);
end;
close(f);
assign(f,'sloop.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+390,m+360,k);
end;
assign(f,'sgreen.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+350,m+400,k);
end;
close(f);
assign(f,'slongul1.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+390,m+400,k);
end;
close(f);
assign(f,'sbridge.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+270,m+200,k);
end;
close(f);
assign(f,'surl.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+310,m+200,k);
end;
close(f);
assign(f,'sudl.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+270,m+240,k);
end;
close(f);
assign(f,'surd.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+310,m+240,k);
end;
assign(f,'srdl.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+270,m+280,k);
end;
close(f);
assign(f,'sul.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+310,m+280,k);
end;
assign(f,'sur.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+270,m+320,k);
end;
close(f);
assign(f,'sdl.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+310,m+320,k);
end;
assign(f,'sdr.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+270,m+360,k);
end;
close(f);
assign(f,'sas.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+310,m+360,k);
end;
assign(f,'sus.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+270,m+400,k);
end;
close(f);
assign(f,'spin2.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+270,m+400,k);
end;
close(f);
assign(f,'stunnel2.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+310,m+400,k);
end;
close(f);
assign(f,'spart2.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+350,m+160,k);
end;
close(f);
assign(f,'spart1.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+390,m+160,k);
end;
close(f);
assign(f,'slongul2.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+270,m+160,k);
end;
close(f);
assign(f,'spin3.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+310,m+160,k);
end;
close(f);
assign(f,'spart3.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+350,m+120,k);
end;
close(f);
assign(f,'spin4.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+390,m+120,k);
end;
close(f);
assign(f,'slongul3.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+270,m+120,k);
end;
close(f);
assign(f,'stunnel1.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+310,m+120,k);
end;
close(f);
assign(f,'stunnel3.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+430,m+400,k);
end;
close(f);
assign(f,'sup1.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+470,m+400,k);
end;
close(f);
assign(f,'sup2.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+510,m+400,k);
end;
close(f);
assign(f,'sup3.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+550,m+400,k);
end;
close(f);
assign(f,'sus.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+550,m+360,k);
end;
close(f);
showmousecursor;
xyz := false;
end;
mkey := none;
end;
if (mkey = left) and (inbu(9) = true) then
begin
if okey = true then
begin
okey := false;
assign(f,'train.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+400,m+50,k);
end;
close(f);
end
else
begin
okey := true;
assign(f,'notrain.bit');
reset(f);
readln(f);
for l := 1 to 40 do
for m := 1 to 40 do
begin
read(f,k);
putpixel(l+400,m+50,k);
end;
close(f);
end;
end;
if (mkey = left) and (inbu(10) = true) then
begin
if cb1 = true then
begin
hidemousecursor;
setfillstyle(emptyfill,8);
barj(448,233,448+150+4,233+30+30+2);
setfillstyle(emptyfill,15);
if kl <> 1 then
drawlbi(450,233,450+150,233+30,'comb1',11,15)
else
drawlbi(450,233,450+150,233+30,'comb1',11,3);
if kl <> 2 then
drawlbi(450,233+30,450+150,233+30+30,'comb2',12,15)
else
drawlbi(450,233+30,450+150,233+30+30,'comb2',12,3);
showmousecursor;
cb1 := false;
end
else
begin
hidemousecursor;
setfillstyle(emptyfill,0);
barj(448,233,448+150+4,233+30+30+2);
cb1 := true;
showmousecursor;
end;
end;
if (mkey = left) and (inbu(11) = true) then
begin
hidemousecursor;
setfillstyle(emptyfill,15);
drawcombo(450,200,600,230,'comb1',10);
drawlbi(450,233,450+150,233+30,'comb1',11,3);
drawlbi(450,233+30,450+150,233+30+30,'comb2',12,15);
kl := 1;
showmousecursor;
end;
if (mkey = left) and (inbu(12) = true) then
begin
hidemousecursor;
setfillstyle(emptyfill,15);
drawcombo(450,200,600,230,'comb2',10);
drawlbi(450,233,450+150,233+30,'comb1',11,15);
drawlbi(450,233+30,450+150,233+30+30,'comb2',12,3);
kl := 2;
showmousecursor;
end;
if (mkey = left) and (inbu(13) = true) then
begin
rb := 13;
hidemousecursor;
setfillstyle(emptyfill,0);
drawrb(138,270,232,307,'r2',14);
drawrb(138,233,232,270,'rb',13);
showmousecursor;
mkey := none;
end;
if (mkey = left) and (inbu(14) = true) then
begin
rb := 14;
hidemousecursor;
setfillstyle(emptyfill,0);
drawrb(138,233,232,270,'rb',13);
drawrb(138,270,232,307,'r2',14);
showmousecursor;
mkey := none;
end;
if (mkey = left) and (inbu(15) = true) then
exitx := true;
if (mkey = left) and (inbu(16) = true) then
begin
closegraph;
init;
map('s1.map');
map('s2.map');
closegraph;
halt(0);
end;
delay(400);
end;
until exitx = true;
closegraph;
end.