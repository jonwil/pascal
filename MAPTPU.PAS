unit maptpu;
interface
procedure map(m:string);
implementation
uses bitmap,graph,crt,bgiref;
var f,off:text;
type gh = record
case kind:boolean of
true:(s:string[1]);
false:(i:integer);
end;
var
g:gh;
ofn:string;
tn,mn:integer;
a:integer;
i:integer;
j:integer;
kkk:integer;
tsss,tfn:string;
ts:array[1..33] of string;
procedure showtb(fn:string);
begin
assign(f,fn);
reset(f);
readln(f,tsss);
readln(f,tn);
for a := 1 to tn do
begin
readln(f,ts[a]);
end;
end;
procedure map(m:string);
label l;
begin
j := 1;
kkk := 1;
assign(off,m);
reset(off);
readln(off,tfn);
showtb(tfn);
for i := 1 to 10 do
begin
readln(off);
for j := 1 to 16 do
begin
read(off,g.s[1]);
case g.s[1] of
'A':
kkk := 10;
'B':
kkk := 11;
'C':
kkk := 12;
'D':
kkk := 13;
'E':
kkk := 14;
'F':
kkk := 15;
'G':
kkk := 16;
'H':
kkk := 17;
'I':
kkk := 18;
'J':
kkk := 19;
'K':
kkk := 20;
'L':
kkk := 21;
'M':
kkk := 22;
'N':
kkk := 23;
'O':
kkk := 24;
'P':
kkk := 25;
'Q':
kkk := 26;
'R':
kkk := 27;
'S':
kkk := 28;
'T':
kkk := 29;
'U':
kkk := 30;
'V':
kkk := 31;
'W':
kkk := 32;
'X':
kkk := 33;
else
val(g.s[1],kkk,b);
end;
if kkk <> 0 then
showbmp((j-1)*40,(i-1)*40,ts[kkk])
else
begin
goto l;
end;
end;
end;
l:end;
end.