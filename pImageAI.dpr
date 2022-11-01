program pImageAI;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  Main in 'Main.pas' {FrmImageAI},
  uImageAI in 'uImageAI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmImageAI, FrmImageAI);
  Application.Run;
end.
