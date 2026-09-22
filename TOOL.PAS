uses bitmap,graph,crt,bgiref;
var i,tn:integer;
tf:string;
f:text;
tbarr:array[1..33] of string;
procedure showtb;
begin
init;
for i := 1 to tn do
showbmp(1,(i-1)*40+(i-1),tbarr[i]);
readln;
closegraph;
end;
begin
writeln('enter tool file');
readln(tf);
assign(f,tf);
rewrite(f);
writeln(f,'[Tool]');
writeln('enter no of tools');
readln(tn);
writeln(f,tn);
for i := 1 to tn do
begin
writeln('enter tool no ',i);
readln(tbarr[i]);
writeln(f,tbarr[i]);
end;
close(f);
showtb;
end.