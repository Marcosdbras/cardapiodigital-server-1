unit uModule;

interface

uses
  System.SysUtils, System.Classes, uDWDatamodule, uDWAbout, uRESTDWServerEvents,
  uDWJSONObject, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  System.JSON, System.Inifiles, FMX.Dialogs, System.UITypes, System.Variants;

type
  TDM = class(TServerMethodDataModule)
    DWEvents: TDWServerEvents;
    conn: TFDConnection;
    Transaction: TFDTransaction;
    procedure DWEventsEventshoraReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWEventsEventsloginReplyEvent(var Params: TDWParams;
      var Result: string);
    function LoadConfig():String;
    procedure ServerMethodDataModuleCreate(Sender: TObject);
    procedure DWEventsEventsincluirusuarioReplyEvent(var Params: TDWParams;
      var Result: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation
      Uses uUsuariosDao;
{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM.DWEventsEventshoraReplyEvent(var Params: TDWParams;
  var Result: string);
begin
   Result := '{"Hora": "'+formatDateTime('hh:mm:ss',now)+'"}';
end;

procedure TDM.DWEventsEventsincluirusuarioReplyEvent(var Params: TDWParams;
  var Result: string);

  var erro, nomeusuario, email, telefone, tipousuario,  senha,  celular :string;
      codusuario:integer;

  Usuario:TUSuariosDao;
  JSon:TJSonObject;
begin


try

    nomeusuario := Params.ItemsString['nomeusuario'].AsString;
    email       := Params.ItemsString['email'].AsString;
    telefone    := Params.ItemsString['telefone'].AsString;
    tipousuario := Params.ItemsString['tipousuario'].AsString;
    senha       := Params.ItemsString['senha'].AsString;
    celular     := Params.ItemsString['celular'].AsString;

    JSon := TJSonObject.Create;

    Usuario := tUsuariosDao.Create(dm.conn);
    Usuario.NomeUsuario := nomeusuario;
    Usuario.Email := email;
    Usuario.Telefone := telefone;
    Usuario.TipoUsuario := tipousuario;
    Usuario.Senha := senha;
    Usuario.Celular := celular;

    if not Usuario.incluirUsuario(
                                  erro,
                                  nomeusuario,
                                  celular,
                                  email,
                                  telefone,
                                  tipousuario,
                                  senha) then
    begin

       //'{"suceso":"N", "erro":"Usu�rio n�o informado","codusuario":""}'
       JSon.AddPair('Status', 'Erro');
       JSon.AddPair('erro',erro);
       Json.AddPair('CodigoUsuario','0');




    end
    else
    begin

      //'{"suceso":"S", "erro":"","codusuario":"10"}';
      JSon.AddPair('Status','Sucesso');
      JSon.AddPair('erro','0');
      JSon.AddPair('CodigoUsuario',Usuario.CodigoUsuario.ToString);


    end;

    Result := Json.ToString;

finally
   Json.DisposeOf;
   Usuario.DisposeOf;
end;


end;

procedure TDM.DWEventsEventsloginReplyEvent(var Params: TDWParams;
  var Result: string);

  var login, senha, erro:string;
      Usuario :TUsuariosDao;
      Json:TJsonObject;
begin
   try

     login := Params.ItemsString['login'].AsString;
     senha := Params.ItemsString['senha'].AsString;

     jSon := TJsonObject.Create;

     Usuario := tUsuariosDao.Create(dm.conn);
     Usuario.Login := login;
     Usuario.Senha := senha;

     if not Usuario.validaLogin(erro) then
     begin

        //'{"suceso":"N", "erro":"Usu�rio n�o informado","codusuario":""}'
        JSon.AddPair('Status', 'Erro');
        JSon.AddPair('erro',erro);
        Json.AddPair('CodigoUsuario','0');


     end
     else
     begin

       //'{"suceso":"S", "erro":"","codusuario":"10"}';
       JSon.AddPair('Status','Sucesso');
       JSon.AddPair('erro','0');
       JSon.AddPair('CodigoUsuario',Usuario.CodigoUsuario.ToString);

     end;

     Result := Json.ToString;


   finally
      JSon.DisposeOf;
      Usuario.DisposeOf;

   end;


end;

function TDM.LoadConfig: String;
var
  arqini, base, usuario, senha, driver : string;
  ini:TIniFile;

begin
  try
    arqini := System.SysUtils.GetCurrentDir+'\servidor.ini';

    if not Fileexists(arqini)then
    begin
      Result := arqini+' n�o existe!';
      exit;
    end;

    ini := TIniFile.Create(arqini);


    base := ini.ReadString('Banco de Dados','DataBase','');
    usuario := ini.ReadString('Banco de Dados','User_Name','');
    senha := ini.ReadString('Banco de Dados','Password','');;
    driver := ini.ReadString('Banco de Dados','DriverID','');

    conn.Params.Values['DriverID']:=  driver;
    conn.Params.Values['DataBase']:=  base;
    conn.Params.Values['User_Name']:= usuario;
    conn.Params.Values['Password']:= senha;

    try

      conn.Connected := true;
      Result := 'Conectado';

    except on ex:exception do
       Result := 'Erro ao conectar banco de dados '+ex.Message;

    end;


  finally
     ini.DisposeOf;
  end;

end;

procedure TDM.ServerMethodDataModuleCreate(Sender: TObject);
var retorno:string;
begin
  retorno := LoadConfig;

  if retorno <> 'Conectado' then
  begin

    Showmessage(retorno);



    {Encerrar sistema}


  end;

end;

{criar formularios para gravar ini}

end.
