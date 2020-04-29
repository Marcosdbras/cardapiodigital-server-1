unit uServer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uDWAbout,
  uRESTDWBase, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Switch1: TSwitch;
    RESTServicePooler: TRESTServicePooler;
    Servidor: TLabel;
    procedure Switch1Switch(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses uModule;

procedure TForm2.FormCreate(Sender: TObject);
begin

RESTServicepooler.ServerMethodClass := TDM;
RESTServicePooler.Active := Switch1.IsChecked;

label1.Text := 'Servidor Ativo';

end;


procedure TForm2.Switch1Switch(Sender: TObject);
begin

   RESTServicePooler.Active := Switch1.IsChecked;

   if Switch1.IsChecked then
      begin
        label1.Text := 'Servidor Ativo';
      end
   else
      begin
        label1.Text := 'Servidor Inativo';
      end;


end;


initialization
     ReportMemoryLeaksOnShutdown := true;


end.
