unit bitmap;
interface
uses graph;
 
type gh = record
case kind:boolean of
true:(s:string[3]);
false:(i:integer);
end;
var
  g:gh;
  fname  : string;
  b,f    : integer;
  i,j    : integer;
  p      : text;
  k      : integer;
 
procedure showbmp(x,y:integer;f:string);
implementation
procedure showbmp(x,y:integer;f:string);
begin
assign(p,f);
reset(p);
for i := 1 to 40 do
begin
readln(p);
for j := 1 to 40 do
begin
read(p,g.s[1]);
read(p,g.s[2]);
read(p,g.s[3]);
g.s := g.s[2] + g.s[3];
if g.s[1] = ' ' then
begin
g.s := g.s[2];
g.s[2] := ' ';
g.s[3] := ' ';
val(g.s[1],k,b);
end
else
begin
g.s[3] := ' ';
val(g.s[1]+g.s[2],k,b);
end;
putpixel(i+x,j+y,k);
end;
end;
close(p);
end;
 
end.