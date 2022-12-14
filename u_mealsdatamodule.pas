unit u_mealsdatamodule;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  Tmealsdatamodule = class(TDataModule)
    dsrtblevents: TDataSource;
    dsrtblvehicles: TDataSource;
    ADOConnection: TADOConnection;
    tblvehicles: TADOTable;
    tblevents: TADOTable;
    QRYmeals: TADOQuery;
    dsrmeals: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mealsdatamodule: Tmealsdatamodule;

implementation

{$R *.dfm}

end.
