unit Unit1;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, ExtCtrls, Unit3;

type
  TForm1 = class(TForm)
    input: TEdit;
    outputbox: TMemo;
    userlist: TListBox;
    BoxActive: TTimer;
    act_deselect: TLabel;
    act_username: TLabel;
    act_send: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TCPClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure TCPClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure TCPClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure V(Sender: TObject; var Action: TCloseAction);
    procedure inputKeyPress(Sender: TObject; var Key: Char);
    procedure userlistClick(Sender: TObject);
    procedure BoxActiveTimer(Sender: TObject);
    procedure act_deselectClick(Sender: TObject);
    procedure act_usernameClick(Sender: TObject);
    procedure act_sendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Form3: TForm3;
  TCPClient: TClientSocket;
  PrivChat: Boolean; //Do I wanna chat private?
const
  prefServer: String = '192.168.178.28'; //Server has to be defined for security reasons...

implementation

{$R *.dfm}

function GetMessage(MSG: String) : String; //Get rid of the ICom Codes
var
  n: Integer;        //loop-counter
  return: String;   //Return value
begin
  for n := 5 to length(MSG) do
    return := return + MSG[n];
  result := return;
end;



procedure TForm1.FormCreate(Sender: TObject);
begin
  try
    TCPClient := TClientSocket.Create(Form1); //Create the Socket-var
    TCPClient.Port := 9031;                   //Set the port
    TCPClient.Host := prefServer;             //Host is prefServer
    TCPClient.Open;                           //OPEN THE SOCKET!!
    TCPClient.OnRead := TCPClientRead;        //read-procedure
    TCPClient.OnDisconnect := TCPClientDisconnect; //disconnect-procedure
    TCPClient.OnError := TCPClientError;      //error-procedure (we don't want it to crash!)
  except
    TCPClient.Free;                           //What if I leave the world... Or the socket... whatever
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  TCPClient.Destroy;                          //You don't wanna keep this in memory, do you?
end;

procedure TForm1.TCPClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  MSG,tmp,tmp2,tmp3,value: String;            //I could have used tons of vars, but the tmp-solution looked... easier ;)
  code,n: integer;                            //n (as always) loop-counter
begin
  MSG := Socket.ReceiveText;                  //The message from the server will be stored in MSG
  //outputbox.Lines.Append('[DD] ' + MSG);
  tmp := MSG[1] + MSG[2] + MSG[3];            //tmp is the code as string
  //showmessage(tmp);
  code := StrToIntDef(tmp,0);                 //code is the integer of it
  case code of                                //I could have used if... but this looks MUCH nicer!
  102: //Requesting username
    begin
      repeat
        value := InputBox('ICom2','Please enter a username','');
      until value <> '';                      //An empty username?! Won't block this @ server-side but this client won't accept it.
      Socket.SendText('209 ' + value);        //Report the new name
    end;
  208: //Connection Established
    begin
      TCPClient.Socket.SendText('201 Server synchronisation'); //No one cares about the string after the code... except the MITM ;)
      outputbox.Lines.Append('[ii] Connection established.');
      outputbox.Refresh;                                       //Stays in for debugging
    end;
  205: //Upcoming USERlst
    begin
      if PrivChat then begin                                   //Don't jump out of a private session!
        for n := 0 to userlist.Items.Count -1 do begin
          if userlist.Selected[n] then
            tmp3 := userlist.Items.Strings[n];                 //tmp3 is the privChat-partner
        end;
      end;
      //showmessage('lol');
      userlist.Clear;
      tmp := GetMessage(MSG);
      for n := 2 to length(tmp) do begin                       //#129 will seperate the users! It's forbidden in usernames... This time on the server-side!
        if tmp[n] = #129 then begin
          userlist.Items.Append(tmp2);
          tmp2 := '';
        end else
          tmp2 := tmp2 + tmp[n];
      end;
      userlist.Items.Append(tmp2);
      userlist.Refresh;
      if PrivChat then begin                                   // If we were in a PrivChat
        PrivChat := False;                                     // If the user who we chatted with has gone offline, this won't be set true again.
        for n := 0 to userlist.Items.Count -1 do begin
          if userlist.Items.Strings[n] = tmp3 then begin
            userlist.Selected[n] := true;
            PrivChat := True;
          end;
        end;
      end;
    end;

  203: //Upcoming MSG
    begin
      tmp := GetMessage(MSG);
      for n := 1 to length(tmp) do begin
        if tmp[n] = #129 then begin
          tmp3 := tmp2;
          tmp2 := '';
        end
        else tmp2 := tmp2 + tmp[n];
      end;
      outputbox .lines.append('<' + tmp3 + '> ' + tmp2);
    end;
  210: //Upcoming PrivMSG
    begin
      tmp := GetMessage(MSG);
      for n := 1 to length(tmp) do begin
        if tmp[n] = #129 then begin
          tmp3 := tmp2;
          tmp2 := '';
        end
        else tmp2 := tmp2 + tmp[n];
      end;
      outputbox .lines.append('[PP] <- <' + tmp3 + '> ' + tmp2);
      if not(BoxActive.Enabled) then begin                  //If the box isn't already shown
        Application.CreateForm(TForm3,Form3);               //Create the notification form
        Form3.Top := Screen.WorkAreaHeight - Form3.height;  //Put it into the lower right edge of the working area(!)
        Form3.Left := Screen.WorkAreaWidth - Form3.Width;
        ShowWindow(Form3.Handle, SW_SHOWNOACTIVATE); //Show Form3 without giving it focus...
      end;
        BoxActive.Enabled := False;     //Make sure the timer starts from the beginning
        BoxActive.Enabled := True;
        Form3.user.Caption := tmp3;     //give the form the data!
        Form3.msg.Caption := tmp2;
    end;
  301: //Username Taken
    begin
      outputbox.Lines.Append('[EE] Username is taken.');
      act_username.OnClick(self);
    end;
  202: //Success
    begin
      Socket.SendText('103 Request Userlist');
      outputbox.Lines.Append('[ii] Success');
      outputbox.refresh;
    end;
  211: //Upcoming ServerMSG
    begin
      outputbox.Lines.Append('[II] SERVER: ' + GetMessage(MSG));
      outputbox.Refresh;
    end;
  303: //Unexpected
    begin
      outputbox.Lines.Append('[!!] Very critical error: 303 - Unexpected.');
      outputbox.Refresh;
    end;
  305: //Reported
    begin
      outputbox.Lines.Append('[!!] The server reported a critical action. Halting.');
      outputbox.Refresh;
      halt;                  //yep we are a server-friendly client! (Don't exactly know why we show the previous output ;) )
    end;
  end;
end;

procedure TForm1.TCPClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  showmessage('Disconnected. Now exiting.');
  Application.Terminate;      //This could be caused by a kick from the server. So let's exit!
end;


procedure TForm1.V(Sender: TObject; var Action: TCloseAction);
begin
  TCPClient.Socket.Close;     //Close the socket... We won't jump out of the window(s) (see server for this comment;) )
end;



procedure TForm1.inputKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then act_send.OnClick(self);
end;

procedure TForm1.userlistClick(Sender: TObject);
begin
  PrivChat := True;
end;

procedure TForm1.BoxActiveTimer(Sender: TObject);
begin
  Form3.Destroy;
  BoxActive.Enabled := False;
end;

procedure TForm1.act_deselectClick(Sender: TObject);
var
  n: integer; //loop-counter
begin
  for n := 1 to userlist.Count do
    userlist.Selected[n] := false;
  PrivChat := False;
end;

procedure TForm1.act_usernameClick(Sender: TObject);
var
  value: String;
begin
  repeat
    value := InputBox('ICom2','Please enter a username','');
  until value <> '';
  TCPClient.Socket.SendText('209 ' + value);
end;

procedure TForm1.act_sendClick(Sender: TObject);
var
  user: String;
  n: Integer; //loop-counter
begin
  if PrivChat then begin
    for n := 0 to userlist.Items.Count -1 do begin
      if userlist.Selected[n] then
        user := userlist.Items.Strings[n];
    end;
    TCPClient.Socket.SendText('210 ' + user + #129 + input.Text);
    outputbox.Lines.Append('[PP] -> <' + user + '> ' + input.Text);
  end else
    TCPClient.Socket.SendText('203 ' + input.Text);
  input.Clear;
end;

procedure TForm1.TCPClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  Showmessage('Connection broke or could not be established. Exiting.');
  Application.Terminate;
end;
end.
