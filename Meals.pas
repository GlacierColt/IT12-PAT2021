unit Meals;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, jpeg, Buttons, Grids, DBGrids, unitmeals,
  GIFImg, Data.DB;

type
  Tonefamilysoupkitchen = class(TForm)
    Pages: TPageControl;
    tshome: TTabSheet;
    tsevents: TTabSheet;
    tsregister: TTabSheet;
    tsadmin: TTabSheet;
    imglogo: TImage;
    Panel1: TPanel;
    Label1: TLabel;
    RichEdit1: TRichEdit;
    Label2: TLabel;
    btnevents: TButton;
    btnadmin: TButton;
    btnhelp: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    BitBtn1: TBitBtn;
    Panel7: TPanel;
    redadmin: TRichEdit;
    btnadminlogin: TButton;
    btnadminlogout: TButton;
    Label3: TLabel;
    DBGadmin: TDBGrid;
    btnaddadmin: TButton;
    Label4: TLabel;
    btnadminhome: TButton;
    btndeleteadmin: TButton;
    Button3: TButton;
    Panel8: TPanel;
    Button2: TButton;
    btneventsload: TButton;
    redevents: TRichEdit;
    cobeventsdate: TComboBox;
    cobeventslocation: TComboBox;
    btneventsreset: TButton;
    btneventssearch: TButton;
    btnadminshowusers: TButton;
    Label5: TLabel;
    btnadmindelevent: TButton;
    btnadminouttruck: TButton;
    btnadminaddtruck: TButton;
    btnadminaddevent: TButton;
    btnadminloadtrucks: TButton;
    btnadminloadevents: TButton;
    btnadminavg: TButton;
    btnadmintrucktoevent: TButton;
    pnlhelp: TPanel;
    edthelpname: TEdit;
    edthelpcell: TEdit;
    redhelpinfo: TRichEdit;
    btnhelpadd: TButton;
    redsignup: TRichEdit;
    btnadminviewsignup: TButton;
    Label6: TLabel;
    btnhelpreset: TButton;
    btnadminsignupclear: TBitBtn;
    procedure btneventsClick(Sender: TObject);
    procedure btnhelpClick(Sender: TObject);
    procedure btnadminClick(Sender: TObject);
    procedure btnadminloginClick(Sender: TObject);
    procedure btnaddadminClick(Sender: TObject);
    procedure btnadminlogoutClick(Sender: TObject);
    procedure btnadminhomeClick(Sender: TObject);
    procedure btneventsloadClick(Sender: TObject);
    procedure btneventssearchClick(Sender: TObject);
    procedure btneventsresetClick(Sender: TObject);
    procedure btndeleteadminClick(Sender: TObject);
    {function Encryptuser (susername : string) : string;
    function Encryptpass (spassword : string) : string; }
    procedure btnadminshowusersClick(Sender: TObject);
    procedure PagesChange(Sender: TObject);
    procedure btnadminloadeventsClick(Sender: TObject);
    procedure btnadminloadtrucksClick(Sender: TObject);
    procedure btnadminaddtruckClick(Sender: TObject);
    procedure btnadminaddeventClick(Sender: TObject);
    procedure btnadminouttruckClick(Sender: TObject);
    procedure btnadmindeleventClick(Sender: TObject);
    procedure btnadminavgClick(Sender: TObject);
    procedure btnadmintrucktoeventClick(Sender: TObject);
    procedure btnhelpaddClick(Sender: TObject);
    procedure btnadminviewsignupClick(Sender: TObject);
    procedure btnhelpresetClick(Sender: TObject);
    procedure btnadminsignupclearClick(Sender: TObject);


  private
    { Private declarations }
    var
    scurrentuser : string;
    imgdone : timage;

  public
    { Public declarations }
  end;

var
  onefamilysoupkitchen: Tonefamilysoupkitchen;
  objxmeals : tmeals;
  const alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz .0123456789!@#$%^&*()_+-`~=';


implementation

uses u_mealsdatamodule;

{$R *.dfm}
procedure SetGridColumnWidths(Grid: Tdbgrid);
const
  DEFBORDER = 10;
var
  temp, n: Integer;
  lmax: array [0..30] of Integer;
begin
  with Grid do
  begin
    Canvas.Font := Font;
    for n := 0 to Columns.Count - 1 do
      lmax[n] := Canvas.TextWidth(Fields[n].FieldName) + DEFBORDER;
    grid.DataSource.DataSet.First;
    while not grid.DataSource.DataSet.EOF do
    begin
      for n := 0 to Columns.Count - 1 do
      begin
        temp := Canvas.TextWidth(trim(Columns[n].Field.DisplayText)) + DEFBORDER;
        if temp > lmax[n] then lmax[n] := temp;
      end; {for}
      grid.DataSource.DataSet.Next;
    end;
    grid.DataSource.DataSet.First;
    for n := 0 to Columns.Count - 1 do
      if lmax[n] > 0 then
        Columns[n].Width := lmax[n];
  end;
end; {SetGridColumnWidths}


procedure Tonefamilysoupkitchen.btnaddadminClick(Sender: TObject);
var susername, spassword, eusername, epassword, sline1 : string;
 icount: integer;
tfile : textfile;
begin
  //creating tmeals
  objxmeals := tmeals.create;
  //encrypting admin
  objxmeals.getsusername('Admin');

  //checking if admin is logged in again for security
  if not(scurrentuser = objxmeals.giveeusername) then
  begin
    showmessage('CRITICAL ERROR!' + #13 + #13 + 'You do not have permission to use the function!' + #13+ 'Please contact the "Admin" user! The application will terminate now');
    application.Terminate;
  end;

  //checking if credential file exists
  if not(fileexists('login.txt')) then
  begin
    showmessage('Vital files are missing. Crucial Error!');
    application.Terminate;
  end;

  {Getting data from user}
  //getting username
  susername := inputbox('Add New Admin User','Enter New Username' + #13 +'(5 or more characters)','');
  //getting password
  spassword := inputbox('Add New Admin User','Enter New Password' + #13 +'(8 or more characters)','');

  //cheking if suername and password are long enough
  if (length(susername) < 5) or (length(spassword) < 8) then
  begin
    //getting redadmin ready
    redadmin.Clear;
    redadmin.Font.Color := clred;
    //warining user of that username or password arent long enough
    redadmin.lines.add('Security Requirements Not Met!' + #13 + #13 + 'Username must be 5 characters or more.' + #13 + 'Password must be 8 characters or more.' + #13 + #13 + 'No user has been added!');
    exit;
  end;

  //sending password for encryption
  objxmeals.getspassword(spassword);
  //sending username for encryption
  objxmeals.getsusername(susername);
  //recieving encrypted username
  eusername := objxmeals.giveeusername;
  //recieving encrypted password
  epassword := objxmeals.giveepassword;

  //getting text file ready
  assignfile(tfile,'login.txt');
  reset(tfile);

  //getting counter ready
  icount := 0;

  {checking if user already exists}
  while (not(eof(tfile))) do
  begin
    //reading from textfile
    readln(tfile,sline1);
    delete(sline1,pos(':',sline1),length(sline1));
    if sline1 = eusername then
    begin
      //if user exisits inc counter
      inc(icount);
    end;
  end;

  //closing text file
  closefile(tfile);

  {checking if counter is 1 or more}
  if icount >= 1 then
  begin
    //getting redadmin ready
    redadmin.Clear;
    redadmin.Font.Color := clred;
    //warning user the username is already in use
    redadmin.Lines.Add('NO USER ADDED!'+#13+'The username "' + susername + '" is already in use.' + #13 + 'Please choose a different one.');
    //ending process
    exit;
  end;

  //getting file ready for writing
  assignfile(tfile,'login.txt');
  append(tfile);
  //writing
  writeln(tfile,eusername + ':' + epassword);

  //clearing for security
  eusername := '';
  epassword := '';

  {Complete Animation}
  //getting redadmin ready
  redadmin.Font.Color := cllime;
  redadmin.Clear;
  application.processmessages;
  //telling user the adding was complete
  redadmin.Lines.Add('The new admin user "' + susername + '" with the password "' + spassword + '" is being added.' + #13 + 'Please wait...');
  //clearing for security
  susername := '';
  spassword := '';
  //animation
  application.processmessages;
  redadmin.Lines.Add('.');
  application.processmessages;
  sleep(1000);
  application.processmessages;
  redadmin.Lines.Add('..');
  application.processmessages;
  sleep(1000);
  application.processmessages;
  redadmin.Lines.Add('...');
  application.processmessages;
  sleep(1000);
  application.processmessages;
  redadmin.Lines.Add('....');
  application.processmessages;
  sleep(1000);
  application.processmessages;
  redadmin.Lines.Add('.....');
  application.processmessages;
  sleep(1000);
  application.processmessages;
  redadmin.Lines.Add('......');
  application.processmessages;
  sleep(1000);
  application.processmessages;
  redadmin.Lines.Add('.......');
  application.processmessages;
  sleep(1000);
  application.processmessages;
  redadmin.Lines.Add('........');
  application.processmessages;
  sleep(1000);
  application.processmessages;
  redadmin.Lines.Add('.........');
  application.processmessages;
  sleep(1000);
  application.processmessages;
  redadmin.Lines.Add('..........');
  application.processmessages;
  sleep(1000);
  application.processmessages;
  //animation is complete
  //clearing read admin
  redadmin.Clear;
  application.processmessages;
  //getting readadmin
  redadmin.Font.Color := clblack;
  redadmin.Font.Size := 8;
  //telling user adding is complete
  redadmin.Lines.Add('User added');

  //closing file
  closefile(tfile);
end;

procedure Tonefamilysoupkitchen.btnadminClick(Sender: TObject);
begin
pages.ActivePage := tsadmin;
end;

procedure Tonefamilysoupkitchen.btnadmindeleventClick(Sender: TObject);
var sid : string;
iid, ierror : integer;
bvalid : boolean;
begin
  sid := inputbox('Delete an Event','Please enter a event ID to be deleted.' + #13 + 'Note: to view events including their ids, please press the load events button.','');
  ierror := 0;
  val(sid,iid,ierror);

  if (sid = '') or (sid = ' ') or not(ierror = 0) then
  begin
    redadmin.Clear;
    redadmin.Font.Color := clred;
    redadmin.Lines.Add('NO EVENT DELETED!' + #13 + 'Invalid event ID entered');
    exit;
  end;

  iid := strtoint(sid);
  bvalid := false;

  with mealsdatamodule do
  begin
    tblevents.First;
    while not(tblevents.Eof)  do
    begin
      if tblevents['eventid'] = iid then
      begin
        bvalid := true;
        tblevents.Delete;
        redadmin.Clear;
        redadmin.Font.Color := clgreen;
        redadmin.Lines.Add('EVENT DELETED.');
        break;
      end;
      tblevents.Next;
    end;
  end;

  if bvalid = false then
  begin
    redadmin.Clear;
    redadmin.Font.Color := clred;
    redadmin.Lines.Add('NO EVENT DELETED!' + #13 + 'Invalid event ID entered');
    exit;
  end;






end;

procedure Tonefamilysoupkitchen.btnadminhomeClick(Sender: TObject);
begin
pages.ActivePage := tshome;
btnadminlogout.Click;
end;

procedure Tonefamilysoupkitchen.btnadminloginClick(Sender: TObject);
var
  susername, spassword, sline1, sline2, eusername, epassword : string;
  tfile : textfile;
  bveri : boolean;
  k : integer;
begin
  //getting data from user
  susername := inputbox('Login','Enter Username','');
  spassword := inputbox('Login','Enter Password','');

  //checking susername and spassword for blanks
  if (length(susername) < 0) or (length(spassword) < 0) then
  begin
    showmessage('Please enter a username and password.');
    exit;
  end;

  {Encrypting susername}
  //creating tmeals
  objxmeals := tmeals.create;
  //sending susername to tmeals
  objxmeals.getsusername(susername);
  //sending spassword to tmeals
  objxmeals.getspassword(spassword);
  //recieving encrypted username
  eusername := objxmeals.giveeusername;
  //clearing susername for security
  susername := '';
  //recieving encrypted password
  epassword := objxmeals.giveepassword;
  //clearing spassword for security
  spassword := '';

  //checking for credential file
  if not(fileexists('login.txt')) then
  begin
    showmessage('Vital files are missing. Crucial Error!');
    application.Terminate;
  end;

  //getting credentail file ready
  assignfile(tfile,'login.txt');
  reset(tfile);

  //verification correct to false
  bveri := false;

  {Secure login}
  //reading through credential file
  while (not(eof(tfile))) and (bveri = false) do
  begin
    readln(tfile,sline1);
    sline2 := sline1;
    //getting encrypted username from credential file
    delete(sline1,pos(':',sline1),length(sline1));
    //getting encrypted password from credential file
    delete(sline2,1,pos(':',sline2));
    //checking if encrypted username matches
    if sline1 = eusername then
    begin
      //checking if encrypted password matches
      if sline2 = epassword then
      begin
        //if encrypted credentials are correct the verification correct to true
        bveri := true;
      end;
    end;
  end;
  //closing credential file
  closefile(tfile);

  {Login}
  //checking if verification was successful
  if bveri = true then
  begin
    //setting global scurrentuser to encrypted username for security
    scurrentuser := eusername;
    //enable and disable components accordingly
    btnadminlogin.enabled := false;
    btnadminlogout.enabled  := true;
    redadmin.Enabled := true;
    dbgadmin.Enabled := true;
    btnadminloadevents.Enabled := true;
    btnadmintrucktoevent.Enabled := true;
    btnadminsignupclear.Enabled := true;
    btnadminloadtrucks.Enabled := true;
    btnadminaddevent.Enabled := true;
    btnadminaddtruck.Enabled := true;
    btnadmindelevent.Enabled := true;
    btnadminouttruck.Enabled := true;
    btnadminviewsignup.Enabled := true;
    btnadminavg.Enabled := true;
    dbgadmin.Enabled := true;
    btnadminavg.Enabled := true;
    btnadmintrucktoevent.Enabled := true;
    //dispaying login successful message
    redadmin.Clear;
    redadmin.Font.Color := clblack;
    redadmin.Lines.Add('Logged In...');
    redadmin.Lines.Add('Please select a button on the right to continue.');
    //sending master admin account to tmeals for encryption
    objxmeals.getsusername('Admin');
    //checking if encrypted master account is logged in
    if scurrentuser = objxmeals.giveeusername then
    begin
      //enabling admin features accordingly
      btnaddadmin.Enabled := true;
      btndeleteadmin.Enabled := true;
      btnadminshowusers.Enabled := true;
    end else
    begin
    //if not master then tell user that admin features are disabled
    redadmin.Font.Color := clblack;
    redadmin.Lines.Add(#13 + 'To add or delete a user:' + #13 + 'Login the the "Admin" account.');
    end;
    end else
    begin
      //if login failed warn user their username or password are wrong
      scurrentuser := '';
      showmessage('Username or password incorrect.');
    end;
    //clearing all variables for security
    eusername := '';
    epassword := '';
end;

procedure Tonefamilysoupkitchen.btnadminlogoutClick(Sender: TObject);
begin
  //clearing scurrentuser
  scurrentuser := '';
  //disabling and enabling components accordingly
  btnadminlogin.Enabled := true;
  btnadminlogout.enabled  := false;
  redadmin.Enabled := false;
  dbgadmin.Enabled := false;
  btnaddadmin.Enabled := false;
  btndeleteadmin.Enabled := false;
  btnadminshowusers.Enabled := false;
  btnadminloadevents.Enabled := false;
  btnadminloadtrucks.Enabled := false;
  btnadmintrucktoevent.Enabled := false;
  btnadminsignupclear.Enabled := false;
  btnadminavg.Enabled := false;
  btnadminaddevent.Enabled := false;
  btnadminaddtruck.Enabled := false;
  btnadmindelevent.Enabled := false;
  btnadminouttruck.Enabled := false;
  btnadminviewsignup.Enabled := false;
  btnadminavg.Enabled := false;
  btnadmintrucktoevent.Enabled := false;
  //getting redadmin ready
  redadmin.Clear;
  redadmin.Font.Color := clblack;
  //informing user to log in
  redadmin.lines.add('Please login to begin...');
end;

procedure Tonefamilysoupkitchen.btnadminouttruckClick(Sender: TObject);
var sid : string;
iid, ierror : integer;
bcom : boolean;
begin
 //getting vehicle id to decomision from user
 sid := inputbox('Decomision Vehicle','Enter a vehicle ID to decomision:','');

 //validating sid
 Val(sid,iid, ierror);

 //checking entered data for blanks
 if (sid = '') or (sid = ' ') or not(ierror = 0) then
 begin
   //getting redadmin ready
   redadmin.Clear;
   redadmin.Font.Color := clred;
   redadmin.Lines.Add('Please enter a valid vehicle id.' + #13 + 'To view vehicle ids please click the load trucks button');
   exit;
 end;

 //filling
 iid := strtoint(sid);

 //setting bcom to false for verification if the edit was successfull
 bcom := false;

 {Editing database}
 with mealsdatamodule do
 begin
  //setting to begin of database
  tblvehicles.First;
  while not(tblvehicles.Eof) do
  begin
    //looking for matching id
    if tblvehicles['vehicleid'] = iid then
    begin
      //editing
      tblvehicles.Edit;
      tblvehicles['inservice'] := false;
      tblvehicles.Post;
      //verifying edit was complete
      bcom := true;
      //gettig redadmin ready
      redadmin.Clear;
      redadmin.Font.Color := clblack;
      //display message
      redadmin.Lines.Add('Vehicle ' + sid + ' was decomsioned.');
    end;
    tblvehicles.Next;
  end;
 end;

 //if bcom is still false, warn user they entered an inavlid id
 if bcom = false then
 begin
   redadmin.Lines.Add('DECOMSION FAILED!' + #13 + 'Please enter a valid vehicle ID.' + #13 + 'To view a complete list of vehicle IDs please click the load trucks button.' );
   exit;
 end;

end;

procedure Tonefamilysoupkitchen.btnadminshowusersClick(Sender: TObject);
var tfile : textfile;
sline, eusername, susername, scar : string;
  I, icar: Integer;
  rcar : real;
begin
  //checking if the current user is the admin
  //sending admin for encryption
  objxmeals.getsusername('Admin');
  //checking if the current user is the admin user
  if not(scurrentuser = objxmeals.giveeusername) then
  begin
    //warning the user
    showmessage('CRITICAL ERROR!' + #13 + #13 + 'You do not have permission to use the function!' + #13+ 'Please contact the "Admin" user! The application will terminate now.');
    //terminating the program as there is a bug or its being hacked - for safty
    application.Terminate;
  end;

  //checking if the credential file exists
  if not(fileexists('login.txt')) then
  begin
    //warining the user
    showmessage('Vital files are missing. Crucial Error!');
    //terminating the program as it cant function without the credential file
    application.Terminate;
  end;

  //getting the credntial files ready
  assignfile(tfile,'login.txt');
  reset(tfile);
  //getting readmin ready
  redadmin.clear;
  redadmin.font.color := clblack;
  redadmin.font.size := 8;
  //setting the headings
  redadmin.Lines.Add('Usernames' + #13 + '----------------------------------------------------------------------------------------------------------------------------------------' + #13);

  {searching for usernames}
  while not(eof(tfile)) do
  begin
    //reading the textfile
    readln(tfile,sline);
    //getting the encrypted usernames alone
    delete(sline,pos(':',sline), length(sline));
    //getting variables for decryption
    scar := '' ;
    susername := '';
    //decrypting each character
    for I := 1 to length(sline) - 1 do
    begin
      scar := copy(sline,1,pos(';',sline) - 1);
      delete(sline,1,pos(';',sline));
      //checking for blanks
      if (scar = '') or (scar = ' ') then break;
      rcar := strtofloat(scar);
      rcar := (rcar + 6235 - 8561) / 785;
      scar := floattostr(rcar);
      icar := strtoint(scar);
      //compiling the susername
      susername := susername + alpha[icar];
    end;
    //displaying the decrypted username
    redadmin.Lines.Add(susername);
  end;
  //closing the file
  closefile(tfile);
end;

procedure Tonefamilysoupkitchen.btnadminsignupclearClick(Sender: TObject);
var
tfile : textfile;
begin
if not fileexists('help.txt') then
begin
  redadmin.Clear;
  redadmin.Font.Color := clred;
  redadmin.Lines.Add('No file found, when someone signs up, the file will be automatically created.');
  exit;
end;

assignfile(tfile,'help.txt');
reset(tfile);
rewrite(tfile);
closefile(tfile);

redadmin.Clear;
redadmin.Font.Color := cllime;
redadmin.Font.Size := 8;
redadmin.Lines.Add('File Rewritten.');
end;

procedure Tonefamilysoupkitchen.btndeleteadminClick(Sender: TObject);
var
susername, eusername, sline: string;
 i: integer;
sl : tstringlist;
bdeleted : boolean;
begin
  //getting ready to delete
  bdeleted := false;
  //sending 'Admin' for encryption
  objxmeals.getsusername('Admin');
  //checking if the current user is the admin user (extra security)
  if not(scurrentuser = objxmeals.giveeusername) then
  begin
    //warning the user they dont have permisions
    showmessage('CRITICAL ERROR!' + #13 + #13 + 'You do not have permission to use the function!' + #13+ 'Please contact the "Admin" user! The application will terminate now');
    //closing the application as their is a bug or is being hacked
    application.Terminate;
  end;

  //getting the username to delete from the admin user
  susername := inputbox('Delete an Admin User','Please entre the username of the user to DELETE','');

  //checking if the username is long enough
  if length(susername) < 5 then
  begin
   //getting redadmin ready
   redadmin.Clear;
   redadmin.Font.Color := clred;
   //warning the user the username is invalid
   redadmin.Lines.Add('The username entered is too short!' + #13 + #13 + 'NO USER DELETED!');
   exit;
  end;

  //sending username for encryption
  objxmeals.getsusername(susername);
  //recieving encrypted username
  eusername := objxmeals.giveeusername;
  //sending Admin for encryption
  objxmeals.getsusername('Admin');

  //checking if the admin user is trying to be deleted
  if eusername = objxmeals.giveeusername then
  begin
    //getting redadmin ready
    redadmin.Clear;
    redadmin.Font.Color := clred;
    //warning the user they cant delete the admin user
    redadmin.Lines.Add('You can not delete the "Admin" user!' + #13 + #13 + 'NO USER DELETED!');
    exit;
  end;

  //checking if the user is tying to delete themselves
  if scurrentuser = eusername then
  begin
    //getting redadmin ready
    redadmin.Clear;
    redadmin.Font.Color := clred;
    //warning user they cant delete themselves
    redadmin.Lines.Add('You can not delete yourself!' + #13 + #13 + 'NO USER DELETED!');
    exit;
  end;

  //checking if credential file exists
  if not(fileexists('login.txt')) then
  begin
    //warning the user the file doesnt exists
    showmessage('CRITICAL ERROR!' + #13 + #13 + 'Vital files are missing!' + #13+ 'Please contact the "Admin" user! The application will terminate now');
    //terminating the program as it cant function without the credential file
    application.Terminate;
  end;

  {deleteing the user}
  //creating string list
  SL := TStringList.Create;
  try
    //filling string list
    SL.LoadFromFile('login.txt');
    for I := SL.Count - 1 downto 0 do
    begin
      //finding and deleting the user
      sline := sl[i];
      delete(sline,pos(':',sline),length(sline));
      if sline = eusername then
      begin
        //deleting the user from the string list
        SL.Delete(I);
        bdeleted := true;
        //getting redadmin ready
        redadmin.Clear;
        redadmin.Font.Color := cllime;
        //warning the user the user has been deleted
        redadmin.Lines.Add('The user "' + susername + '" is being deleted.' + #13 + 'Please wait...');
        //clearing susername for security
        susername := '';
        //running animation
        application.processmessages;
        redadmin.Lines.Add('..........');
        application.processmessages;
        sleep(1000);
        application.processmessages;
        redadmin.Lines.Add('.........');
        application.processmessages;
        sleep(1000);
        application.processmessages;
        redadmin.Lines.Add('........');
        application.processmessages;
        sleep(1000);
        application.processmessages;
        redadmin.Lines.Add('.......');
        application.processmessages;
        sleep(1000);
        application.processmessages;
        redadmin.Lines.Add('......');
        application.processmessages;
        sleep(1000);
        application.processmessages;
        redadmin.Lines.Add('.....');
        application.processmessages;
        sleep(1000);
        application.processmessages;
        redadmin.Lines.Add('....');
        application.processmessages;
        sleep(1000);
        application.processmessages;
        redadmin.Lines.Add('...');
        application.processmessages;
        sleep(1000);
        application.processmessages;
        redadmin.Lines.Add('..');
        application.processmessages;
        sleep(1000);
        application.processmessages;
        redadmin.Lines.Add('.');
        application.processmessages;
        sleep(1000);
        application.processmessages;
        redadmin.Clear;
        application.processmessages;
        //end of animation
        //getting redadmin ready
        redadmin.Font.Color := clblack;
        redadmin.Font.Size := 8;
        //warning the user the user was deleted
        redadmin.Lines.Add('User deleted');
      end;
    end;
    //saving the string list to the file
    SL.SaveToFile('login.txt');
  finally
    //clearing the string list
    SL.Free;
  end;


  //if the user wasnt deleted
 if bdeleted = false then
 begin
    //getting redadmin ready
   redadmin.Clear;
   redadmin.Font.Color := clred;
   //warining the user that the admin wasnt deleted as it doent exist
   redadmin.Lines.Add('The user entered does not exist!' + #13 + #13 + 'NO USER DELETED!');
   exit;
 end;
end;

procedure Tonefamilysoupkitchen.btneventsClick(Sender: TObject);
begin
pages.ActivePage := tsevents;
end;

procedure Tonefamilysoupkitchen.btneventsloadClick(Sender: TObject);
var arrlocation : array[1..99999] of string;
arrdate : array[1..99999] of string;
id, i: integer;
svar: string;
binvalid : boolean;
begin

//reseting arrays
for i := 1 to 99999 do
  begin
    arrdate[i] := '';
    arrlocation[i] := '';
  end;

//reseting COBeventslocation and COBeventsdate
  cobeventslocation.Items.Clear;
  cobeventsdate.Items.Clear;

///filling COBeventslocation

//geting data from database with sql
with mealsdatamodule do
begin
 qrymeals.Active := false;
 qrymeals.SQL.Text := 'select eventid, location from tblevents order by eventdate desc';
 qrymeals.Active := true;
end;

//filling array
with mealsdatamodule do
begin
qrymeals.First;
  while not(qrymeals.Eof) do
  begin
  binvalid := false;
    id := qrymeals['eventid'];
    svar := qrymeals['location'];
      for i := 1 to 99999 do
        begin
          if arrlocation[i] = svar then
          binvalid := true;
        end;
    if binvalid = false then
    begin
      arrlocation[id] := svar;
    end;
    qrymeals.Next
  end;
end;
//filling cobeventslocation
for i := 1 to 99999 do
  begin
    if not(arrlocation[i] = '') then
    cobeventslocation.Items.Add(arrlocation[i]);
  end;

///filling COBeventsdate
//geting data from database with sql
  with mealsdatamodule do
begin
 qrymeals.Active := false;
 qrymeals.SQL.Text := 'select eventid, eventdate from tblevents order by eventdate desc';
 qrymeals.Active := true;
end;

//filling array
with mealsdatamodule do
begin
qrymeals.First;
  while not(qrymeals.Eof) do
  begin
  binvalid := false;
    id := qrymeals['eventid'];
    svar := qrymeals['eventdate'];
      for i := 1 to 99999 do
        begin
          if arrdate[i] = svar then
          binvalid := true;
        end;
    if binvalid = false then
    begin
      arrdate[id] := svar;
    end;
    qrymeals.Next
  end;
end;

//filling COBeventsdate
for i := 1 to 99999 do
  begin
    if not(arrdate[i] = '') then
    cobeventsdate.Items.Add(arrdate[i]);
  end;

 //displaying all events
with mealsdatamodule do
begin
 qrymeals.Active := false;
 qrymeals.Sort;
 qrymeals.SQL.Text := 'select * from tblevents';
 qrymeals.Active := true;
end;


 redevents.Clear;
 redevents.Font.Color := clblack;
 redevents.Paragraph.TabCount := 9;
 redevents.Paragraph.Tab[0] := 20;
 redevents.Paragraph.Tab[1] := 40;
 redevents.Paragraph.Tab[2] := 60;
 redevents.Paragraph.Tab[3] := 200;
 redevents.Paragraph.Tab[4] := 220;
 redevents.Paragraph.Tab[5] := 240;
 redevents.Paragraph.Tab[6] := 260;
 redevents.Paragraph.Tab[7] := 280;
 redevents.Paragraph.Tab[8] := 300;

 redevents.Lines.Add('#' + #9 + ' ' + #9 + 'Location' + #9 + ' ' + #9 + '# Of Meals' + #13);

 with mealsdatamodule do
  begin
  qrymeals.First;
    while not(qrymeals.Eof) do
    begin
      redadmin.Font.Color := clblack;
      redevents.lines.add(inttostr(qrymeals['eventid']) + #9 + '|' + #9 + qrymeals['Location'] + #9 +  '|' + #9  + inttostr(qrymeals['stockrequired']));
      qrymeals.Next;
    end;
  end;

 with mealsdatamodule do
begin
 qrymeals.Active := false;
 qrymeals.Sort;
 qrymeals.SQL.Text := 'select sum(stockrequired) as stockrequired from tblevents';
 qrymeals.Active := true;

end;

mealsdatamodule.qrymeals.first;
showmessage(inttostr(mealsdatamodule.qrymeals['stockrequired']) + ' meals found.');

end;

procedure Tonefamilysoupkitchen.btneventsresetClick(Sender: TObject);
begin
cobeventslocation.ItemIndex := -1;
cobeventsdate.ItemIndex := -1;
cobeventslocation.Text := 'Select Location';
cobeventsdate.Text := 'Select Date';
btneventsload.Click;
end;

procedure Tonefamilysoupkitchen.btneventssearchClick(Sender: TObject);
var
i, idate, iloc : integer;
sloc, sdate : string;
bloc1, bdate1, bloc2, bdate2, bvaliddate, bvalidloc : boolean;
begin

sloc := cobeventslocation.Text;
sdate := cobeventsdate.Text;
idate := cobeventsdate.ItemIndex;
iloc := cobeventslocation.ItemIndex;

bloc1 := false;
bdate1 := false;
bloc2 := false;
bdate2 := false;
bvalidloc := false;
bvaliddate := false;


for i := 0 to (cobeventslocation.Items.Capacity) do
begin
  cobeventslocation.ItemIndex := i;
  if sloc = cobeventslocation.Text then
  begin
    bloc1 := true;
    break;
  end;
end;

cobeventslocation.ItemIndex := iloc;
if iloc = -1 then
begin
  cobeventslocation.text := 'Select Location';
end;

for i := 0 to (cobeventsdate.Items.Capacity) do
begin
  cobeventsdate.ItemIndex := i;
  if sdate = cobeventsdate.Text then
  begin
    bdate1 := true;
    break;
  end;
end;

cobeventsdate.ItemIndex := idate;
if idate = -1 then
begin
  cobeventsdate.text := 'Select Date';
end;

if cobeventslocation.ItemIndex = -1 then
bloc2 := true;

if cobeventsdate.ItemIndex = -1 then
bdate2 := true;

if (bloc2 = true) and (bdate2 = true) then
  begin
    showmessage('Please select a location and/or date to search.');
    exit;
  end;

if (bloc1 = false) and (bloc2 = false)then
  begin
    showmessage('Invalid text was added to "Select Location".' + #13 + 'Please select a valid value from the combo boxes.');
    cobeventslocation.ItemIndex := -1;
    cobeventslocation.Text := 'Select Location';
    cobeventsdate.ItemIndex := -1;
    cobeventsdate.Text := 'Select Date';
    exit;
  end;

if (bdate1 = false) and (bdate2 = false) then
  begin
    showmessage('Invalid text was added to "Select Date".' + #13 + 'Please select a valid value from the combo boxes.');
    cobeventsdate.ItemIndex := -1;
    cobeventsdate.Text := 'Select Date';
    cobeventslocation.ItemIndex := -1;
    cobeventslocation.Text := 'Select Location';
    exit;
  end;

if (bloc1 = true) and (bloc2 = false) then
  begin
    bvalidloc := true;
  end;

if (bdate1 = true) and (bdate2 = false) then
  begin
    bvaliddate := true;
  end;

if (bvalidloc = true) and (bvaliddate = true) then
  begin
   with mealsdatamodule do
    begin
    qrymeals.Active := false;
    qrymeals.Sort;
    qrymeals.SQL.Text := 'select eventid, location, eventdate, eventtimestart, eventtimeend, stockrequired from tblevents where (location = ' + quotedstr(sloc) + ') and (eventdate = #' + sdate + '#)';
    qrymeals.Active := true;
    end;
            redevents.Clear;
 redevents.Font.Color := clblack;
 redevents.Paragraph.TabCount := 9;
 redevents.Paragraph.Tab[0] := 20;
 redevents.Paragraph.Tab[1] := 40;
 redevents.Paragraph.Tab[2] := 60;
 redevents.Paragraph.Tab[3] := 200;
 redevents.Paragraph.Tab[4] := 220;
 redevents.Paragraph.Tab[5] := 240;
 redevents.Paragraph.Tab[6] := 260;
 redevents.Paragraph.Tab[7] := 280;
 redevents.Paragraph.Tab[8] := 300;

    redevents.Lines.Add('#' + #9 + ' ' + #9 + 'Location' + #9 + ' ' + #9  + 'Date' + #9 + ' ' + #9  + #9 + #9 + 'Time' + #9 + ' ' + #9 +#9 +#9 + '# of Meals' + #13);

    with mealsdatamodule do
begin
qrymeals.First;
  while not(qrymeals.Eof) do
    begin
      redevents.Lines.Add(inttostr(qrymeals['eventid']) + #9 + '|' + #9 + qrymeals['Location'] + #9 + '|' + #9 + datetostr(qrymeals['eventdate']) + #9 + '|' + #9 + timetostr(qrymeals['eventtimestart']) + ' - ' + timetostr(qrymeals['eventtimeend']) + #9 + '|' + #9 + inttostr(qrymeals['stockrequired']));
      qrymeals.Next;
    end;
end;

  end;

if (bvalidloc = true) and (bvaliddate = false) then
  begin
    with mealsdatamodule do
      begin
      qrymeals.Active := false;
      qrymeals.Sort;
      qrymeals.SQL.Text := 'select eventid, location, eventdate, eventtimestart, eventtimeend, stockrequired from tblevents where (location = ' + quotedstr(sloc) + ')';
      qrymeals.Active := true;
      end;

        redevents.Clear;
 redevents.Font.Color := clblack;
 redevents.Paragraph.TabCount := 9;
 redevents.Paragraph.Tab[0] := 20;
 redevents.Paragraph.Tab[1] := 40;
 redevents.Paragraph.Tab[2] := 60;
 redevents.Paragraph.Tab[3] := 200;
 redevents.Paragraph.Tab[4] := 220;
 redevents.Paragraph.Tab[5] := 240;
 redevents.Paragraph.Tab[6] := 260;
 redevents.Paragraph.Tab[7] := 280;
 redevents.Paragraph.Tab[8] := 300;
    redevents.Lines.Add('#' + #9 + ' ' + #9 + 'Location' + #9 + ' ' + #9  + 'Date' + #9  + #9 + #9 + ' ' + #9  + 'Time' + #9 + ' ' + #9  + #9 + #9  + '# of Meals' + #13);

     with mealsdatamodule do
begin
qrymeals.First;
  while not(qrymeals.Eof) do
    begin
      redevents.Lines.Add(inttostr(qrymeals['eventid']) + #9 + '|' + #9 + qrymeals['Location'] + #9 + '|' + #9 + datetostr(qrymeals['eventdate']) + #9 + '|' + #9 + timetostr(qrymeals['eventtimestart']) + ' - ' + timetostr(qrymeals['eventtimeend']) + #9 + '|' + #9 + inttostr(qrymeals['stockrequired']));
      qrymeals.Next;
    end;
end;
  end;

if (bvalidloc = false) and (bvaliddate = true) then
  begin
    with mealsdatamodule do
      begin
      qrymeals.Active := false;
      qrymeals.Sort;
      qrymeals.SQL.Text := 'select eventid, location, eventdate, eventtimestart, eventtimeend, stockrequired from tblevents where (eventdate = #' + sdate + '#)';
      qrymeals.Active := true;
      end;

          redevents.Clear;
 redevents.Font.Color := clblack;
 redevents.Paragraph.TabCount := 9;
 redevents.Paragraph.Tab[0] := 20;
 redevents.Paragraph.Tab[1] := 40;
 redevents.Paragraph.Tab[2] := 60;
 redevents.Paragraph.Tab[3] := 200;
 redevents.Paragraph.Tab[4] := 220;
 redevents.Paragraph.Tab[5] := 240;
 redevents.Paragraph.Tab[6] := 260;
 redevents.Paragraph.Tab[7] := 280;
 redevents.Paragraph.Tab[8] := 300;
      redevents.Lines.Add('#' + #9 + ' ' + #9 + 'Location' + #9 + ' ' + #9  + 'Date' + #9 + ' ' + #9 + #9 + #9  + 'Time' + #9 + ' ' + #9 + #9  + #9 + '# of Meals' + #13);

       with mealsdatamodule do
begin
qrymeals.First;
  while not(qrymeals.Eof) do
    begin
      redevents.Lines.Add(inttostr(qrymeals['eventid']) + #9 + '|' + #9 + qrymeals['Location'] + #9 + '|' + #9 + datetostr(qrymeals['eventdate']) + #9 + '|' + #9 + timetostr(qrymeals['eventtimestart']) + ' - ' + timetostr(qrymeals['eventtimeend']) + #9 + '|' + #9 + inttostr(qrymeals['stockrequired']));
      qrymeals.Next;
    end;
end;
  end;




end;

procedure Tonefamilysoupkitchen.btnhelpaddClick(Sender: TObject);
var tfile : textfile;
ierror : integer;
i : integer;
begin
//checking if help file exists
assignfile(tfile,'help.txt');
if not(fileexists('help.txt')) then
begin
  //create new text file
  rewrite(tfile);
end;

//checking name
if not(length(edthelpname.Text) >= 3) or (edthelpname.Text = 'Name and Surname')  then
begin
  //warning user the name is invalid
  redsignup.Clear;
  redsignup.font.Size := 8;
  redsignup.Lines.Add('Please enter a name and try again.');
  exit;
end;

//getting ierror ready for val
ierror := 0;
//validating edthelpcell
val(edthelpcell.Text,i,ierror);

//checking phone number
if (not(length(edthelpcell.Text) = 10)) or not(ierror = 0) then
begin
  //warning user the phone number is wrong
  redsignup.Clear;
  redsignup.font.Size := 8;
  redsignup.Lines.Add('Please enter a valid SA phone number (10 digits) and try again.');
  exit;
end;

//creating tmeals
objxmeals := tmeals.create;
//encrypting phone number
objxmeals.getsusername(edthelpcell.Text);
//encrypting name and surname
objxmeals.getspassword(edthelpname.Text);

//getting tfile ready
//appending tfile
append(tfile);
//writing to tfile with encrypted name and phone number
writeln(tfile, objxmeals.giveepassword + ':' +  objxmeals.giveeusername);
//closing tfile
closefile(tfile);

//Informing user of successfull save
redsignup.Clear;
redsignup.font.Size := 25;
redsignup.Lines.Add('Congratulations!');
redsignup.Lines.Add('You have signed up... We will contact you sortly :)');

//destroying (freeing) objxmeals
objxmeals.Destroy;

imgdone := timage.Create(onefamilysoupkitchen);
imgdone.Parent := onefamilysoupkitchen.pnlhelp;
with imgdone do
 begin
  left := 3;
  top := 150;
  height := 300;
  width := 300;
  picture.LoadFromFile('complete.gif');
end;
btnhelpreset.enabled := true;
btnhelpadd.Enabled := false;
edthelpname.Text := 'Name and Surname';
edthelpcell.Text := 'SA Cellphone Number';
end;

procedure Tonefamilysoupkitchen.btnhelpClick(Sender: TObject);
begin
pages.ActivePage := tsregister;
end;

procedure Tonefamilysoupkitchen.btnhelpresetClick(Sender: TObject);
begin
//imgdone := timage.Create(onefamilysoupkitchen);
imgdone.destroy;
redsignup.clear;
btnhelpreset.Enabled := false;
btnhelpadd.Enabled := true;
end;

procedure Tonefamilysoupkitchen.btnadminviewsignupClick(Sender: TObject);
var tfile : textfile;
sline, sline1 , scar, susername, spassword : string;
rcar : real;
icar, i : integer;

begin
if not fileexists('help.txt') then
begin
  redadmin.Clear;
  redadmin.Font.Color := clred;
  redadmin.Lines.Add('No file found, when someone signs up, the file will be automatically created.');
  exit;
end;

assignfile(tfile,'help.txt');
reset(tfile);

redadmin.Clear;
redadmin.Font.Color := clblack;

icar := 0;
rcar := 0;

{searching for usernames}
  while not(eof(tfile)) do
  begin
    //reading the textfile
    readln(tfile,sline);
    //getting the encrypted usernames alone
    sline1 := copy(sline,pos(':',sline) + 1, length(sline));
    delete(sline,pos(':',sline), length(sline));

    //getting variables for decryption
    scar := '' ;
    susername := '';
    spassword := '';
    //decrypting each character of password (Name)
    for I := 1 to length(sline) - 1 do
    begin
      scar := copy(sline,1,pos(';',sline) - 1);
      delete(sline,1,pos(';',sline));
      //checking for blanks
      if (scar = '') or (scar = ' ') then break;
      rcar := strtofloat(scar);
      rcar := (rcar - 64852 + 96540)/ 3654;
      scar := floattostr(rcar);
      icar := strtoint(scar);
      //compiling the spassword (name)
      spassword := spassword + alpha[icar];
    end;

    //decrypting each character of username (phone number)
    for I := 1 to length(sline1) - 1 do
    begin
      scar := copy(sline1,1,pos(';',sline1) - 1);
      delete(sline1,1,pos(';',sline1));
      //checking for blanks
      if (scar = '') or (scar = ' ') then break;
      rcar := strtofloat(scar);
      rcar := (rcar - 8561 + 6235)/ 785;
      scar := floattostr(rcar);
      icar := strtoint(scar);
      //compiling the susername (phone number)
      susername := susername + alpha[icar];
    end;

    //displaying the decrypted password (name) and username (cellphone number)
    redadmin.font.size := 8;
    redadmin.font.color := clblack;
    redadmin.Lines.Add(spassword + #9 + susername);
  end;
  //closing the file
  closefile(tfile);
end;

procedure Tonefamilysoupkitchen.btnadminavgClick(Sender: TObject);
begin
  with mealsdatamodule do
  begin
    qrymeals.Active := false;
    qrymeals.SQL.Text := 'select round(avg(maxstock)) as mealspertruckavg from tblvehicles where inservice = true';
    qrymeals.Active := true;
  end;

  dbgadmin.DataSource := mealsdatamodule.dsrmeals;
  SetGridColumnWidths(dbgadmin);

  redadmin.Clear;
  redadmin.Font.Color := clblack;
  mealsdatamodule.QRYmeals.First;
  redadmin.Lines.Add('The average meals per truck (in serivce only) is ' + inttostr(mealsdatamodule.QRYmeals['mealspertruckavg']))
end;

procedure Tonefamilysoupkitchen.btnadmintrucktoeventClick(Sender: TObject);
begin
  with mealsdatamodule do
  begin
    qrymeals.Active := false;
    qrymeals.SQL.Text := 'select tblvehicles.vehicleid, eventid, eventdate from tblvehicles, tblevents where tblvehicles.vehicleid = tblevents.vehicleid order by tblvehicles.vehicleid' ;
    qrymeals.Active := true;
  end;

  dbgadmin.DataSource := mealsdatamodule.dsrmeals;
  SetGridColumnWidths(dbgadmin);

end;

procedure Tonefamilysoupkitchen.btnadminloadeventsClick(Sender: TObject);
begin
//getting dbgadmin ready
dbgadmin.Enabled := true;
dbgadmin.ReadOnly := true;

//getting data from tblevents with SQL
with mealsdatamodule do
begin
 qrymeals.Active := false;
 qrymeals.Sort;
 //selecting everything
 qrymeals.SQL.Text := 'select * from tblevents';
 qrymeals.Active := true;
end;

//setting the data source, formating (SetGridColumWidths) and displaying
dbgadmin.DataSource := u_mealsdatamodule.mealsdatamodule.dsrmeals;
SetGridColumnWidths(dbgadmin);
end;

procedure Tonefamilysoupkitchen.btnadminloadtrucksClick(Sender: TObject);
begin
//getting dbgadmin ready
dbgadmin.Enabled := true;
dbgadmin.ReadOnly := true;

//setting datasource, formating (SetGridColumnWidths) and displaying
dbgadmin.DataSource := u_mealsdatamodule.mealsdatamodule.dsrtblvehicles;
SetGridColumnWidths(dbgadmin);
end;

procedure Tonefamilysoupkitchen.btnadminaddeventClick(Sender: TObject);
var sloc, sstock, sdate, sid , stimestart, stimeend : string;
idv,istock, ierror: integer;
bfound : boolean;
begin
  //getting data from user
  sloc := inputbox('Add Event', 'Enter a Location:', '');
  sstock := inputbox('Add Event', 'Enter Required Stock (Meals):','');
  sdate := inputbox('Add Event', 'Enter a Date:' + #13 + 'Format: YYYY/MM/DD', 'YYYY/MM/DD');
  sid := inputbox('Add Event', 'Assign a vehicle ID:' + #13 + 'Note this vehicle will do the delivery and prep of the food', '');
  stimestart := inputbox('Add Event', 'Enter a starting time for the event:' + #13 + 'Format: HH:MM', 'HH:MM');
  stimeend := inputbox('Add Event', 'Enter a ending time for the event:' + #13 + 'Format: HH:MM', 'HH:MM');

  //checking sloc
  if (sloc = '') or (sloc = ' ') or (length(sloc) < 12) then
  begin
  //getting redadmin ready
    redadmin.Clear;
    redadmin.Font.Color := clred;
    //warning user
    redadmin.Lines.Add('NO EVENT ADDED!' + #13 + 'Please enter a valid location.');
    //canceling
    exit;
  end;

  //checking sdate
  if (sdate = '') or (sdate = ' ') or not(length(sdate) = 10) or (sdate = 'YYYY/MM/DD') then
  begin
    //getting redadmin ready
    redadmin.Clear;
    redadmin.Font.Color := clred;
    //warning user
    showmessage('NO EVENT ADDED!' + #13 + 'Please enter a valid event date' );
    //canceling
    exit;
  end;

//checking sid
  if (sid = '') or (sid = ' ') then
  begin
    //getting redadmin ready
    redadmin.Clear;
    redadmin.Font.Color := clred;
    //warining user
    redadmin.Lines.Add('NO EVENT ADDED!' + #13 + 'Please enter a valid vehicle ID');
    //canceling
    exit;
  end;

  //checking stimestart
  if (stimestart = '') or (stimestart =  ' ') or not(length(stimestart) = 5) or (stimestart = 'HH:MM') then
  begin
    //getting redadmin ready
    redadmin.Clear;
    redadmin.Font.Color := clred;
    //warning user
    redadmin.Lines.Add('NO EVENT ADDED!'+ #13 +'Please enter a valid starting time');
    //canceling
    exit;
  end;

  //checking stimeend
  if (stimeend = '') or (stimeend =  ' ') or not(length(stimeend) = 5) or (Stimeend = 'HH:MM') then
  begin
    //getting redadmin ready
    redadmin.Clear;
    redadmin.Font.Color := clred;
    //warning user
    redadmin.Lines.Add('NO EVENT ADDED!' + #13 +'Please enter a valid ending time');
    //canceling
    exit;
  end;

  //validating sid for idv
  //setting ierror to 0
  ierror := 0;
  //validating sid
  Val(sid,idv, ierror);
  //checking is ierror is not 0
  if not(ierror = 0) then
  begin
    //getting redamdin ready
    redadmin.Clear;
    redadmin.Font.Color := clred;
    //warning user
    redadmin.Lines.Add('NO EVENT ADDED!' + #13 + 'Please enter a valid Vehicle ID.');
    //canceling
    exit;
  end;
  //setting idv
  idv := strtoint(sid);

  //setting ierror back to 0
  ierror := 0;
  //validating sstock for istock
  Val(sstock,istock, ierror);
  //checking if ierror is still 0
  if not(ierror = 0) then
  begin
    //getting redadmin ready
    redadmin.Clear;
    redadmin.Font.Color := clred;
    //warning user
    redadmin.Lines.Add('NO EVENT ADDED!'+ #13 +'Please enter a valid amount of stock required.');
    //canceling
    exit;
  end;
  //setting istock
  istock := strtoint(sstock);

  //setting bfound to false
  bfound := false;

  //checking vehicle id
  with mealsdatamodule do
  begin
    tblvehicles.first;
    while not(tblvehicles.Eof) do
    begin
      if idv = tblvehicles['vehicleid'] then
      begin
        bfound := true;
        break;
      end;
      tblvehicles.Next;
    end;
  end;

  if bfound = false then
  begin
    redadmin.Clear;
    redadmin.Font.Color := clred;
    redadmin.Lines.Add('NO EVENT ADDED!' +  #13 + 'Please enter a valid vehicle ID or the vehicle is not in service!' + #13 + 'The list of vehicles can be seen by pressing the load trucks button.');
    exit;
  end;

  with mealsdatamodule do
  begin
    qrymeals.SQL.Text := 'INSERT INTO tblevents (location, Stockrequired, vehicleID, eventdate, eventtimestart, eventtimeend) VALUES (' + quotedstr(sloc) + ', ' + quotedstr(inttostr(istock)) + ', ' + quotedstr(inttostr(idv)) + ', #' + sdate + '#, ' + quotedstr(stimestart) + ', ' + quotedstr(stimeend) + ')';
    qrymeals.execsql;
    qrymeals.Active := false;
    redadmin.Clear;
    redadmin.Font.Color := clgreen;
    redadmin.Lines.Add('EVENT ADDED.');
    qrymeals.SQL.Text := 'select * from tblevents';
    qrymeals.Active := true;
    dbgadmin.DataSource := dsrmeals;
    setgridcolumnwidths(dbgadmin);
  end;

end;

procedure Tonefamilysoupkitchen.btnadminaddtruckClick(Sender: TObject);
var slicense,sdateaq, smeals: string;
imeals : integer;
  ierror: Integer;
const
sint = '1234567890';
begin
slicense := inputbox('Add new truck','License Plate Number','');
sdateaq := inputbox('Add new truck','Date Aquired' + #13 + 'Format: YYYY/MM/DD','YYYY/MM/DD');
smeals := inputbox('Add new truck','Max about of stock the truck can carry','');
if (slicense = '') or (slicense = ' ') then
begin
showmessage('Please enter a valid license plate');
exit;
end;

if (sdateaq = '') or (sdateaq = ' ') or (sdateaq = 'YYYY/MM/DD') then
begin
 showmessage('Please enter a valid date');
 exit;
end;

if (smeals = '') or (smeals = ' ') then
begin
 showmessage('Please enter a vaild amout of meals');
 exit;
end;

ierror := 0;

Val(smeals,imeals, ierror);
if not(ierror = 0) then
begin
   showmessage('Please enter a valid number of meals.');
   exit;
 end;
 imeals := strtoint(smeals);




mealsdatamodule.tblvehicles.Insert;
mealsdatamodule.tblvehicles['licenceplate'] := slicense;
mealsdatamodule.tblvehicles['dateaquired'] := sdateaq;
mealsdatamodule.tblvehicles['inservice'] := true;
mealsdatamodule.tblvehicles['maxstock'] := imeals;
mealsdatamodule.tblvehicles['lastrepaires'] := sdateaq;
mealsdatamodule.tblvehicles.Post;

with redadmin do
begin
  Font.Color := clblack;
  clear;
  lines.Add('New truck added.' + #13);
  lines.Add('Vehicle ID: ' + inttostr(mealsdatamodule.tblvehicles['vehicleid']));
  lines.Add('License Plate: ' + slicense);
  lines.Add('Max Stock: ' + smeals);
  lines.Add('Date Aquired: ' + sdateaq);
  lines.Add('Service Status: ' + ' True');
end;

end;

procedure Tonefamilysoupkitchen.PagesChange(Sender: TObject);
begin
btnadminlogout.Click;
end;

end.
