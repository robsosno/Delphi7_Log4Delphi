unit TestLogLogUnit;

interface

uses
  TestFrameWork;

type
  TTestLogLog = class (TTestCase)
  public
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure testInitialize();
    procedure testMessages();
    procedure testQuietMode();
    procedure testFinalize();
  end;

implementation

uses
  SysUtils, Forms, TLogLogUnit;

procedure TTestLogLog.Setup;
begin
   TLogLogUnit.initialize(ExtractFileDir(Application.ExeName)+'\TestLogLog.log');
end;

procedure TTestLogLog.TearDown;
begin
  TLogLogUnit.finalize;
end;

procedure TTestLogLog.testInitialize();
begin
   Check(TLogLogUnit.isInit);
end;

procedure TTestLogLog.testMessages();
begin
   TLogLog.debug('debug');
   TLogLog.error('error');
   TLogLog.warn('warn');
   TLogLog.info('info');
   TLogLog.fatal('fatal');
end;

procedure TTestLogLog.testQuietMode();
begin
   TLogLog.setQuietMode(true);
   TLogLog.debug('debug');
   TLogLog.error('error');
   TLogLog.warn('warn');
   TLogLog.setQuietMode(false);
   TLogLog.info('info');
   TLogLog.fatal('fatal');
end;

procedure TTestLogLog.testFinalize();
begin
   TLogLogUnit.finalize;
   Check(not TLogLogUnit.isInit);
end;

initialization
   TestFramework.RegisterTest(TTestLogLog.Suite);

end.
 