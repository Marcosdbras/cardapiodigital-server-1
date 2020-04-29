﻿unit uUsuariosDao;

interface
 uses FireDac.comp.client, System.SysUtils, FireDac.DApt;

 type tUsuariosDao = class
     private
         FConn:TFDConnection;

    FCodigoUsuario: Integer;
    FNomeUsuario: string;
    FCelular: string;
    FEmail: string;
    FTelefone: string;
    FTipoUsuario: string;
    FSenha: string;
    FLogin: string;

     public
       constructor Create(conn:TFDConnection);

       property CodigoUsuario: Integer read FCodigoUsuario write FCodigoUsuario;
       property NomeUsuario:string read FNomeUsuario write FNomeUsuario;
       property Celular:string read FCelular write FCelular;
       property Email:string read FEmail write FEmail;
       property Telefone:string read FTelefone write FTelefone;
       property TipoUsuario:string read FTipoUsuario write FTipoUsuario;
       property Senha:string read FSenha write FSenha;
       property Login:string read FLogin write FLogin;

       function validaLogin(out erro:string):Boolean;

       function incluirUsuario(
                               out erro:string;
                               NomeUsuario,
                               Celular,
                               Email,
                               Telefone,
                               TipoUsuario,
                               Senha: string):Boolean;

 end;

implementation

{ tUsuario }

constructor tUsuariosDao.Create(conn: TFDConnection);
begin
  FConn := conn;
end;

function tUsuariosDao.incluirUsuario(
                                     out erro: string;
                                     NomeUsuario,
                                     Celular,
                                     Email,
                                     Telefone,
                                     TipoUsuario,
                                     Senha: string): Boolean;
  var Query:TFDQuery;
  var NovoCodigoUsuario:integer;


begin
  try
    try
      Query := TFDQuery.Create(nil);
      Query.Connection := FConn;


      with Query do
      begin
        active := false;
        sql.Clear;
        sql.Add('select GEN_ID(GEN_USUARIOS_ID,1) as prox_codigo FROM RDB$DATABASE;');
        active := true;

      end;

      NovoCodigoUsuario:= Query.FieldByName('prox_codigo').AsInteger;


      with Query do
      begin
        active := false;
        sql.Clear;
        sql.Add('insert into usuarios(codigo,   nomeusuario,  email,  telefone,  tipousuario,  senha,  celular) values ');
        sql.Add(                    '(:codigo, :nomeusuario, :email, :telefone, :tipousuario, :senha, :celular)');
        ParamByname('codigo').AsInteger := NovoCodigoUsuario;
        ParamByname('nomeusuario').AsString := NomeUsuario;
        ParamByname('Celular').AsString := Celular;
        ParamByname('Email').AsString  := Email;
        ParamByname('Telefone').AsString  := Telefone;
        ParamByname('TipoUsuario').AsString  := TipoUsuario;
        ParamByname('Senha').AsString := Senha;

        ExecSql;

        CodigoUsuario := NovoCodigoUsuario;
        erro := '0';
        Result := true;

      end;

    except on ex:exception do
       begin
         erro := '1-Erro ao inserir dados '+ex.Message;
         CodigoUsuario := 0;
         Result := false;
       end;
    end;


  finally
      freeandnil(Query);
  end;


end;

function tUsuariosDao.validaLogin(out erro: string): Boolean;
var Query:TFDQuery;
begin
  try


    try

        Query := TFDquery.Create(nil);
        Query.Connection := FConn;
        with Query do
        begin
           Active := false;
           Sql.Clear;
           Sql.Add('Select * from usuarios where (email = :email and senha = :senha)');
           ParamByName('email').AsString := Login;
           ParamByName('senha').AsString:=  Senha;
           Active := true;

           if RecordCount > 0 then
           begin
             Codigousuario := fieldbyname('codigo').AsInteger;
             erro := '0';
             Result := True;
           end
           else
           begin
             {TODO 1 -Marcos Brás -Implemntat: Se não achar email e senha / então verificar celular e email / ou achar nomeusuario e senha }

             codigoUsuario := 0;
             erro := '1-Login ou senha invalido';
             Result := False;
           end;
        end;


      except on ex : exception do
          begin
             erro := '2-Erro ao validar login '+ex.Message;
             Result := False;
          end;

      end;

  finally
    freeandnil(Query);

  end;




end;

end.
