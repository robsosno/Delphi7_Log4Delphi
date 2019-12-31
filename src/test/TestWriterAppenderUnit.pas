unit TestWriterAppenderUnit;

interface

uses
   TestFrameWork, TWriterAppenderUnit;

type
   TTestWriterAppender = class (TTestCase)
  private
    FAppender : TWriterAppender;
  public
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure TestCreate;
    procedure TestClose;
    procedure TestAppend;
    procedure TestSetStream;
    procedure TestRequiresLayout;
  end;

implementation

uses
  Classes, TLoggingEventUnit, TLevelUnit, TSimpleLayoutUnit;

procedure TTestWriterAppender.Setup;
begin
  FAppender := TWriterAppender.Create;
end;

procedure TTestWriterAppender.TearDown;
begin
  FAppender.Free;
end;

procedure TTestWriterAppender.TestCreate;
begin
  Check(FAppender <> Nil, 'Appender cannot be nil.');
end;

procedure TTestWriterAppender.TestClose;
begin
  FAppender.Close;
  Check(true);
end;

procedure TTestWriterAppender.TestAppend;
var
  stream : TStringStream;
  event : TLoggingEvent;
begin
  stream := TStringStream.Create('');
  FAppender.SetStream(stream);
  FAppender.SetLayout(TSimpleLayout.Create);
  event := TLoggingEvent.Create(TLevelUnit.DEBUG, 'A test message' , 'ROOT');
  FAppender.Append(event);
  Check(stream.DataString = 'DEBUG - A test message' + #13#10,
    'Output is incorrect');
  stream.Free;
end;

procedure TTestWriterAppender.TestSetStream;
var
  stream : TStringStream;
begin
  stream := TStringStream.Create('');
  FAppender.SetStream(stream);
  stream.Free;
end;

procedure TTestWriterAppender.TestRequiresLayout;
begin
  Check(FAppender.RequiresLayout, 'Appender should require a layout.');
end;

initialization
   TestFramework.RegisterTest(TTestWriterAppender.Suite);

end.
 