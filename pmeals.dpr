program pmeals;

uses
  Forms,
  Meals in 'Meals.pas' {onefamilysoupkitchen},
  u_mealsdatamodule in 'u_mealsdatamodule.pas' {mealsdatamodule: TDataModule},
  unitmeals in 'unitmeals.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tonefamilysoupkitchen, onefamilysoupkitchen);
  Application.CreateForm(Tmealsdatamodule, mealsdatamodule);
  Application.Run;
end.
