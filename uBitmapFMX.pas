unit uBitmapFMX;

interface

uses
  system.classes, system.types, fmx.graphics, idhttp, system.sysutils, system.threading;

type
  TBmpHlp = class helper for TBitmap
  public
    procedure loadImgFromUrl(url:string);
  end;
implementation

{ TBmpHlp }

procedure TBmpHlp.loadImgFromUrl(url: string);
var
  aTask: ITask;
begin

aTask := TTask.Create(procedure()
var
  idh: TIdHttp;
  strm : TMemoryStream;
begin
  idh:=tidhttp.Create(nil);
  strm:=TMemoryStream.Create;

  try
      idh.Get(url,strm);
      if strm.Size >0 then
      begin
        strm.Position:=0;
        tthread.Synchronize(tthread.CurrentThread, procedure
        begin
          loadFromStream(strm);
        end);

      end;
  finally
    idh.Free;
    strm.Free;
  end;
end);
atask.Start;

end;

end.

