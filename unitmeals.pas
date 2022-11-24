unit unitmeals;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, jpeg, Buttons, Grids, DBGrids;

type tmeals = class(tobject)

private
 fspassword : string;
 fsusername : string;
 fepassword : string;
 feusername : string;

 const alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz .0123456789!@#$%^&*()_+-`~=';

public
constructor create;
function giveepassword  : string;
function giveeusername  : string;
procedure getspassword (spassword : string);
procedure getsusername (susername : string);

end;

implementation

{ tmeals }

constructor tmeals.create;
begin

end;



procedure tmeals.getspassword(spassword: string);
var k, inum: integer;
begin
fspassword := spassword;
fepassword := '';
for k := 1 to length(fspassword) do
 begin
   inum := pos(fspassword[k],alpha) * 3654 + 64852 - 96540 ;
   fepassword := fepassword + inttostr(inum) + ';';
 end;
 fspassword := '';
end;

procedure tmeals.getsusername(susername: string);
var k, inum : integer;
begin
fsusername := susername;
feusername := '';
 for k := 1 to length(fsusername) do
 begin
   inum := pos(fsusername[k],alpha) * 785 + 8561 - 6235 ;
   feusername := feusername + inttostr(inum) + ';';
 end;
 fsusername := '';
end;

function tmeals.giveepassword: string;
begin
 result := fepassword;
end;

function tmeals.giveeusername: string;
begin
 result := feusername;
end;

end.
