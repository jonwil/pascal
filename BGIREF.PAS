unit BGIRef;
interface
uses graph;
var gd,gm:integer;
procedure init;
implementation
procedure init;
begin
gd := detect;
initgraph(gd,gm,'c:\tp\bgi');
end;
 
end.