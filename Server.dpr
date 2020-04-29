program Server;

uses
  System.StartUpCopy,
  FMX.Forms,
  uServer in 'uServer.pas' {Form2},
  uModule in 'uModule.pas' {DM: TDataModule},
  uUsuariosDao in 'Dao\uUsuariosDao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm2, Form2);

  Application.Run;
end.
