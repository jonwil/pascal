uses bitmap,graph,crt,bgiref;
var f,off:text;
ofn:string;
mn,mna:char;
tn,abc,jk,jkk,mnn,c:integer;
a,b:integer;
i:integer;
j:integer;
kkk:integer;
tsss,tfn:string;
ts:array[1..33] of string;
marr:array[1..10,1..16] of integer;
procedure showtb(fn:string);
begin
jk := 1;
jkk := 1;
assign(f,fn);
reset(f);
readln(f,tsss);
readln(f,tn);
init;
for a := 1 to tn do
begin
readln(f,ts[a]);
if (a = 10) or (a = 20) or (a = 30) then
begin
jk := jk + 41;
jkk := 1;
end;
showbmp(jk,(jkk-1)*40+(jkk-1),ts[a]);
jkk := jkk + 1;
end;
readln;
closegraph;
end;
label l;
begin
for j := 1 to 10 do
for i := 1 to 16 do
marr[j,i] := 0;
j := 1;
kkk := 1;
writeln('enter map file');
readln(ofn);
assign(off,ofn);
rewrite(off);
writeln('enter tool file');
readln(tfn);
writeln(off,tfn);
showtb(tfn);
writeln('map editor. enter tool no or x to exit. press enter and enter next tool. enter numbers in hex');
for i := 1 to 10000 do
begin
read(mn);
if mn = 'x' then
goto l
else
begin
case mn of
'A':
mnn := 10;
'B':
mnn := 11;
'C':
mnn := 12;
'D':
mnn := 13;
'E':
mnn := 14;
'F':
mnn := 15;
'G':
mnn := 16;
'H':
mnn := 17;
'I':
mnn := 18;
'J':
mnn := 19;
'K':
mnn := 20;
'L':
mnn := 21;
'M':
mnn := 22;
'N':
mnn := 23;
'O':
mnn := 24;
'P':
mnn := 25;
'Q':
mnn := 26;
'R':
mnn := 27;
'S':
mnn := 28;
'T':
mnn := 29;
'U':
mnn := 30;
'V':
mnn := 31;
'W':
mnn := 32;
'X':
mnn := 33;
else
val(mn,mnn,b);
end;
if mnn > tn then
writeln('not a tool')
else
begin
marr[j,kkk] := mnn;
if kkk = 48 then
begin
kkk := 0;
j := j + 1;
end;
kkk := kkk + 1;
end;
end;
end;
l:for i := 1 to 10 do
begin
 abc := 1;
 writeln(off);
 for j := 1 to 48 do
  begin
   if (j-1) mod 3 = 0 then
    begin
     if marr[i,j] < 10 then
      begin
       kkk := marr[i,j];
       write(off,kkk);
      end
     else
      begin
       kkk := marr[i,j];
       case marr[i,j] of
       10:
       mna := 'A';
       11:
       mna := 'B';
       12:
       mna := 'C';
       13:
       mna := 'D';
       14:
       mna := 'E';
       15:
       mna := 'F';
       16:
       mna := 'G';
       17:
       mna := 'H';
       18:
       mna := 'I';
       19:
       mna := 'J';
       20:
       mna := 'K';
       21:
       mna := 'L';
       22:
       mna := 'M';
       23:
       mna := 'N';
       24:
       mna := 'O';
       25:
       mna := 'P';
       26:
       mna := 'Q';
       27:
       mna := 'R';
       28:
       mna := 'S';
       29:
       mna := 'T';
       30:
       mna := 'U';
       31:
       mna := 'V';
       32:
       mna := 'W';
       33:
       mna := 'X';
       end;
       write(off,mna);
      end;
     if kkk <> 0 then
     abc := abc + 1;
    end;
  end;
end;
closegraph;
end.