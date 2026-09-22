 uses
  Graph,crt,bgiref;
 
  const  con='CON:';
  const  charx = 540;
 
var
  scol,fname  : string;             {bitmap file name}
  b,f    : integer;            {background/foreground colours}
  i,j,x,y,dx,dy    : integer;  {location markers}
  p      : text;                                     {file pointer}
  nnn    : array [1..40]of array [1..40] of integer; {array for figure}
  size   : word;             {bitmap size}
  k      : char;             {key press}
  xo,yo,io,jo  : integer;    {top left of grid and image}
  nx,ny  : integer;          { size of array}
  ii,jj  : integer;          { current pixel}
  xcol   : integer;          { colour chart x pos}
  nodraw : boolean;
 
procedure drawgrid;
 
begin
  setcolor(8);
  for i:=0 to 40 do
    begin
      line(xo+i*10,yo,xo+i*10,yo+400);
      line(xo,yo+i*10,xo+400,yo+i*10);
    end;
  rectangle(io,jo,io+41,jo+41);
  setcolor(15);
  outtextxy(1,460,'G-get file, S-save, F-foreground, B-background, C-clear, ESC-exit');
  outtextxy(charx,10,'0');
  SetFillStyle(1,0);
  bar(charx+10,10,charx+20,10+10);
  outtextxy(charx,40,'1');
  SetFillStyle(1,1);
  bar(charx+10,40,charx+20,40+10);
  outtextxy(charx,70,'2');
  SetFillStyle(1,2);
  bar(charx+10,70,charx+20,70+10);
  outtextxy(charx,100,'3');
  SetFillStyle(1,3);
  bar(charx+10,100,charx+20,100+10);
  outtextxy(charx,130,'4');
  SetFillStyle(1,4);
  bar(charx+10,130,charx+20,130+10);
  outtextxy(charx,160,'5');
  SetFillStyle(1,5);
  bar(charx+10,160,charx+20,160+10);
  outtextxy(charx,190,'6');
  SetFillStyle(1,6);
  bar(charx+10,190,charx+20,190+10);
  outtextxy(charx,220,'7');
  SetFillStyle(1,7);
  bar(charx+10,220,charx+20,220+10);
  outtextxy(charx,250,'8');
  SetFillStyle(1,8);
  bar(charx+10,250,charx+20,250+10);
  outtextxy(charx,280,'9');
  SetFillStyle(1,9);
  bar(charx+10,280,charx+20,280+10);
  outtextxy(charx-10,310,'10');
  SetFillStyle(1,10);
  bar(charx+10,310,charx+20,310+10);
  outtextxy(charx-10,340,'11');
  SetFillStyle(1,11);
  bar(charx+10,340,charx+20,340+10);
  outtextxy(charx-10,370,'12');
  SetFillStyle(1,12);
  bar(charx+10,370,charx+20,370+10);
  outtextxy(charx-10,400,'13');
  SetFillStyle(1,13);
  bar(charx+10,400,charx+20,400+10);
  outtextxy(charx-10,430,'14');
  SetFillStyle(1,14);
  bar(charx+10,430,charx+20,430+10);
  outtextxy(charx-10,460,'15');
  SetFillStyle(1,15);
  bar(charx+10,460,charx+20,460+10);
  outtextxy(1,470,'R-Rotate, V-vertical flip, H-Horizontal flip');
end;
 
function gread(var str: string):boolean;
var
    ch:char;
begin
    gread:=true;
    str:='';
    ch:=readkey;
    while ch<>#13 do
      begin
        case ch of
 
        #27 : begin                 {exit}
                gread:=false;
                ch:=#13
              end;
        #8  : begin                  {delete}
                outtext(ch);
                str:=copy(str,1,length(str)-1);
                ch:=readkey;
               end;
        else   begin
                 outtext(ch);
                 str:=str+ch;
                 ch:=readkey;
               end;
        end;
 
      end;
end;
 
procedure drawpoint(i,j,c:integer);
{
  draw filled grid box in color c and corresponding pixel in actual image
}
  begin
     putpixel(io+i,jo+j,c);
     setfillstyle(1,c);
     bar(xo+i*10-9,yo+j*10-9,xo+i*10-1,yo+j*10-1);
  end;
 
procedure drawbox(i,j,c:integer);
{
  draw outline box to show current pixel
}
  begin
    setcolor(c);
    rectangle(xo+i*10-10,yo+j*10-10,xo+i*10,yo+j*10);
  end;
 
procedure drawfigure;
begin
  for j:=1 to 40 do
   for i:=1 to 40 do
     drawpoint(i,j,nnn[i,j]);
end;
 
procedure clear;
begin
for i:=1 to 40 do
 begin
  for j:=1 to 40 do
  nnn[i,j]:=b
 end;
drawfigure;
end;
 
procedure swap(var a,b:integer);
var c : integer;
begin
  c:=a;
  a:=b;
  b:=c;
end;
 
procedure swap4(var a,b,c,d:integer);
var e : integer;
begin
  e:=a;
  a:=b;
  b:=c;
  c:=d;
  d:=e;
 
end;
 
procedure horizflip;
begin
  for j:=1 to 40 do
    for i:=1 to 20 do
      begin
        swap(nnn[i,j],nnn[41-i,j]);
      end;
  drawfigure;
end;
 
procedure vertflip;
begin
  for i:=1 to 40 do
    for j:=1 to 20 do
      begin
        swap(nnn[i,j],nnn[i,41-j]);
      end;
  drawfigure;
end;
 
procedure rotate;
begin
  for i:=1 to 20 do
    for j:=1 to 20 do
      begin
        swap4(nnn[i,j],nnn[41-j,i],nnn[41-i,41-j],nnn[j,41-i]);
      end;
  drawfigure;
end;
 
procedure getfile;
begin
  if paramcount > 0 then
  fname := paramstr(1);
  setcolor(15);
  outtextxy(1,10,'Bitmap file (or new) : ');
  moveto(220,10);
  for i:=1 to 40 do
    for j:=1 to 40 do
      nnn[i,j]:=0;
  if paramcount = 0 then
  begin
  if gread(fname) then
    begin
     {$I-}
     assign(p,fname);
    if ioresult=0 then
      begin
        reset(p);
        readln(p,nx,ny);
        for i:=1 to ny do
          begin
            for j:=1 to nx do
              read(p,nnn[i,j]);
            readln(p);
          end;
        close(p)
      end;
    end;
    end;
  if paramcount <= 1 then
  begin
     {$I-}
     assign(p,fname);
    if ioresult=0 then
      begin
        reset(p);
        readln(p,nx,ny);
        for i:=1 to ny do
          begin
            for j:=1 to nx do
              read(p,nnn[i,j]);
            readln(p);
          end;
        close(p)
      end;
      end;
  cleardevice;
  drawgrid;
  drawfigure;
end;
 
procedure savefile;
var
   snx,sny : string;
   code:integer;
   ok : boolean;
begin
  setcolor(15);
  outtextxy(1,10,'Output Bitmap file name');
  moveto(220,10);
  ok:=gread(fname);
  if ok then
    begin
      outtextxy(1,20,'Max x column');
      moveto(220,20);
      ok:= gread(snx);
      if ok then
        begin
          val(snx,nx,code);
          ok:=(nx>0)
        end;
    end;
  if ok then
    begin
      outtextxy(1,30,'Max y row');
      moveto(220,30);
      ok:=gread(sny);
      if ok then
        begin
          val(sny,ny,code);
          ok:=(ny>0)
        end;
    end;
  if ok then
    begin
      assign(p,fname);
      ok:=(ioresult=0)
    end;
  if ok then
    begin
      rewrite(p);
      ok:=(ioresult=0)
    end;
  if ok then
    begin
      writeln(p,nx:4,ny:4);
      for i:=1 to ny do
        begin
          for j:=1 to nx do
            write(p,nnn[i,j]:3);
          writeln(p);
        end;
      flush(p);
      close(p);
    end
  else
    begin
      setcolor(12);
      outtextxy(400,20,'File not saved... press key');
      repeat
      until keypressed
    end;
 
 cleardevice;
 drawgrid;
 drawfigure;
end;
 
procedure getfg;
var scol : string;
    code:integer;
  begin
    outtextxy(1,10,'Colour [0-15] ');
    moveto(120,10);
    if gread(scol) then
      val(scol,f,code);
    setfillstyle(1,0);
    bar(0,0,530,39);
 
  end;
 
procedure getbg;
var scol : string;
    code : integer;
  begin
    outtextxy(1,10,'Colour [0-15] ');
    moveto(120,10);
    if gread(scol) then
      val(scol,b,code);
    setfillstyle(1,0);
    bar(0,0,530,39);
 
  end;
 
begin
  xo:=100;
  yo:=40;
  io:=10;
  jo:=40;
  b:=0;
 
  { start graphics, draw grid and image}
 
  init;
 
  f:=15;
 
  {get file name and read bitmap into array}
 
  getfile;
  {set position to top left}
 
  ii:=1;
  jj:=1;
  dx:=0;
  dy:=0;
 
  repeat
    begin
      drawbox(ii,jj,15);
      k:=upcase(readkey);
      nodraw:=false;
      case k of
 
        #0  : begin
                k:=upcase(readkey);
                case k of
 
                  #77 : begin
                          dx:=1;      {right}
                          dy:=0;
                        end;
                  #75 : begin
                          dx:=-1;     {left}
                          dy:=0;
                        end;
                  #72 : begin
                          dy:=-1;     {up}
                          dx:=0;
                        end;
                  #80 : begin
                          dy:=1;      {down}
                          dx:=0;
                        end;
                  #71 : begin       {home}
                          dx:=-1;
                          dy:=-1;
                        end;
                  #73 : begin       {pgup}
                          dx:=+1;
                          dy:=-1;
                        end;
                  #79 : begin       {end}
                          dx:=-1;
                          dy:=+1;
                        end;
                  #81 : begin       {pgdn}
                          dx:=+1;
                          dy:=+1;
                        end;
                  else
                     nodraw:=true
                end;
              end;
        #13 : begin        {enter - set color to f/g}
                nnn[ii,jj]:=f;
                drawpoint(ii,jj,f);
              end;
        #8  : begin        {bs - set color to b/g}
                nnn[ii,jj]:=b;
                drawpoint(ii,jj,b);
              end;
 
     'F' : getfg;
        'B' : getbg;
        'S' : savefile;
        'G' : getfile;
        'C' : clear;
        'R' : rotate;
        'H' : Horizflip;
        'V' : Vertflip;
        else
           nodraw:=true;
      end;
 
      if not nodraw then
        begin
          drawbox(ii,jj,8);
 
          ii:=ii+dx;
          jj:=jj+dy;
          if ii<1 then ii:=40;
          if jj<1 then jj:=40;
          if ii>40 then ii:=1;
          if jj>40 then jj:=1;
        end;
    end;
  until k=#27;
 
  CloseGraph;
end.