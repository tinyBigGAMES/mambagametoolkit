{==============================================================================
                     __  __               _
                    |  \/  | __ _  _ __  | |__  __ _
                    | |\/| |/ _` || '  \ | '_ \/ _` |
                    |_|  |_|\__,_||_|_|_||_.__/\__,_|
                              Game Toolkit™

                 Copyright © 2024-present tinyBigGAMES™ LLC
                          All Rights Reserved.

                    Website: https://tinybiggames.com
                    Email  : support@tinybiggames.com

                 See LICENSE file for license information
==============================================================================}

unit Mamba.Database;

{$I Mamba.Defines.inc}

interface

uses
  Mamba.Core;

//=== LOCALDB ===============================================================
type
  { ILocalDb }
  ILocalDb = interface(IBaseInterface)
    ['{1FD51162-A421-469F-A96F-E21AF2CC5DEA}']
    function  IsOpen(): Boolean;
    function  Open(const AFilename: string): Boolean;
    procedure Close();
    procedure ClearSQLText();
    procedure AddSQLText(const AText: string);
    function  GetSQLText(): string;
    procedure SetSQLText(const AText: string);
    function  GetPrepairedSQL(): string;
    procedure ClearMacros();
    function  GetMacro(const AName: string): string;
    procedure SetMacro(const AName, AValue: string);
    procedure ClearParams();
    function  GetParam(const AName: string): string;
    procedure SetParam(const AName, AValue: string);
    function  RecordCount(): Integer;
    function  GetField(const AIndex: Cardinal; const AName: string): string;
    function  Execute(): Boolean;
    function  ExecuteSQL(const ASQL: string): Boolean;
    function  GetLastError(): string;
    function  GetResponseText(): string;
  end;

//=== REMOTEDB ==============================================================
type
  { IRemoteDb }
  IRemoteDb = interface(IBaseInterface)
    ['{5B901E76-8912-4472-8192-409C6E2EEB5E}']
    procedure Setup(const AURL, AApiKey, ADatabase: string);
    procedure ClearSQLText();
    procedure AddSQLText(const AText: string; const AArgs: array of const);
    function  GetSQLText(): string;
    procedure SetSQLText(const AText: string);
    function  GetPrepairedSQL(): string;
    procedure ClearMacros();
    function  GetMacro(const AName: string): string;
    procedure SetMacro(const AName, AValue: string);
    procedure ClearParams();
    function  GetParam(const AName: string): string;
    procedure SetParam(const AName, AValue: string);
    function  RecordCount(): Integer;
    function  GetField(const AIndex: Cardinal; const AName: string): string;
    function  Execute(): Boolean;
    function  ExecuteSQL(const ASQL: string): Boolean;
    function  GetLastError(): string;
    function  GetResponseText(): string;
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  System.JSON,
  System.Net.HttpClient,
  System.Generics.Collections,
  Mamba.Deps;

//=== LOCALDB ===============================================================
type
  { TLocalDb }
  TLocalDb = class(TBaseInterface, ILocalDb)
  protected
    FDatabase: string;
    FResponseText: string;
    FLastError: string;
    FSQL: TStringList;
    FPrepairedSQL: string;
    FJSON: TJSONObject;
    FDataset: TJSONArray;
    FMacros: TDictionary<string, string>;
    FParams: TDictionary<string, string>;
    FHandle: PSQLite3;
    FStmt: Psqlite3_stmt;
    procedure SetMacroValue(const AName, AValue: string);
    procedure SetParamValue(const AName, AValue: string);
    procedure Prepair;
    function  ExecuteSQLInternal(const ASQL: string): Boolean;
  public
    property Handle: PSQLite3 read FHandle;
    constructor Create(); override;
    destructor Destroy(); override;
    function  IsOpen(): Boolean;
    function  Open(const AFilename: string): Boolean;
    procedure Close();
    procedure ClearSQLText();
    procedure AddSQLText(const AText: string);
    function  GetSQLText(): string;
    procedure SetSQLText(const AText: string);
    function  GetPrepairedSQL(): string;
    procedure ClearMacros();
    function  GetMacro(const AName: string): string;
    procedure SetMacro(const AName, AValue: string);
    procedure ClearParams();
    function  GetParam(const AName: string): string;
    procedure SetParam(const AName, AValue: string);
    function  RecordCount(): Integer;
    function  GetField(const AIndex: Cardinal; const AName: string): string;
    function  Execute(): Boolean;
    function  ExecuteSQL(const ASQL: string): Boolean;
    function  GetLastError(): string;
    function  GetResponseText(): string;
  end;

{ TLocalDb }
procedure TLocalDb.SetMacroValue(const AName, AValue: string);
begin
  FPrepairedSQL := FPrepairedSQL.Replace('&'+AName, AValue);
end;

procedure TLocalDb.SetParamValue(const AName, AValue: string);
begin
  FPrepairedSQL := FPrepairedSQL.Replace(':'+AName, ''''+AValue+'''');
end;

procedure TLocalDb.Prepair();
var
  LKey: string;
begin
  FPrepairedSQL := FSQL.Text;

  // Substitute macros
  for LKey in FMacros.Keys do
  begin
    SetMacroValue(LKey, FMacros.Items[LKey]);
  end;

  // Substitute field params
  for LKey in FParams.Keys do
  begin
    SetParamValue(LKey, FParams.Items[LKey]);
  end;
end;

constructor TLocalDb.Create();
begin
  inherited;

  FSQL := TStringList.Create;
  FMacros := TDictionary<string, string>.Create;
  FParams := TDictionary<string, string>.Create;
end;

destructor TLocalDb.Destroy();
begin
  Close();
  FParams.Free();
  FMacros.Free();
  FSQL.Free();

  inherited;
end;

function TLocalDb.IsOpen(): Boolean;
begin
  Result := Assigned(FHandle);
end;

function TLocalDb.Open(const AFilename: string): Boolean;
begin
  Result := False;

  if IsOpen() then
  begin
    FLastError := 'Database already open';
    Exit;
  end;

  FDatabase := TPath.ChangeExtension(AFilename, 'db');
  if sqlite3_open(PAnsiChar(AnsiString(FDatabase)), @FHandle) <> SQLITE_OK then
  begin
    FLastError := string(sqlite3_errmsg(FHandle));
    sqlite3_close(FHandle);
    FHandle := nil;
  end;

  Result := IsOpen();
end;

procedure TlocalDb.Close();
begin
  if not IsOpen() then
  begin
    FLastError := 'Database was not open';
    Exit;
  end;

  if Assigned(FJSON) then
  begin
    FJSON.Free();
    FJSON := nil;
  end;

  if Assigned(FStmt) then
  begin
    sqlite3_finalize(FStmt);
    FStmt := nil;
  end;

  if Assigned(FHandle) then
  begin
    sqlite3_close(FHandle);
    FHandle := nil;
  end;

  ClearMacros();
  ClearParams();
  ClearSQLText();

  FDatabase := '';
  FResponseText := '';
  FLastError := '';
  FPrepairedSQL := '';
end;

procedure TLocalDb.ClearSQLText();
begin
  FSQL.Clear;
end;

procedure TLocalDb.AddSQLText(const AText: string);
begin
  FSQL.Add(AText);
end;

function TLocalDb.GetSQLText(): string;
begin
  Result := FSQL.Text;
end;

procedure TLocalDb.SetSQLText(const AText: string);
begin
  FSQL.Text := AText;
end;

function  TLocalDb.GetPrepairedSQL(): string;
begin
  Result := FPrepairedSQL;
end;

procedure TLocalDb.ClearMacros();
begin
  FMacros.Clear();
end;

function TLocalDb.GetMacro(const AName: string): string;
begin
  FMacros.TryGetValue(AName, Result);
end;

procedure TLocalDb.SetMacro(const AName, AValue: string);
begin
  FMacros.AddOrSetValue(AName, AValue);
end;

procedure TLocalDb.ClearParams();
begin
  FParams.Clear();
end;

function TLocalDb.GetParam(const AName: string): string;
begin
  FParams.TryGetValue(AName, Result);
end;

procedure TLocalDb.SetParam(const AName, AValue: string);
begin
  FParams.AddOrSetValue(AName, AValue);
end;

function TLocalDb.RecordCount(): Integer;
begin
  Result := 0;
  if not Assigned(FDataset) then Exit;
  Result := FDataset.Count;
end;

function TLocalDb.GetField(const AIndex: Cardinal; const AName: string): string;
begin
  Result := '';
  if not Assigned(FDataset) then Exit;
  if AIndex > Cardinal(FDataset.Count-1) then Exit;
  Result := FDataset.Items[AIndex].GetValue<string>(AName);
end;

function TLocalDb.Execute(): Boolean;
begin
  Prepair;
  Result := ExecuteSQL(FPrepairedSQL);
end;

function TLocalDb.ExecuteSQL(const ASQL: string): Boolean;
begin
  Result := ExecuteSQLInternal(ASQL);
end;

function TLocalDb.ExecuteSQLInternal(const ASQL: string): Boolean;
var
  LRes: Integer;
  I: Integer;
  LName: string;
  LValue: string;

  function GetTypeAsString(AStmt: Psqlite3_stmt; AColumn: Integer): string;
  begin
    case sqlite3_column_type(AStmt, AColumn) of
      SQLITE_INTEGER: Result := IntToStr(sqlite3_column_int(AStmt, AColumn));
      SQLITE_FLOAT: Result := FloatToStr(sqlite3_column_double(AStmt, AColumn));
      SQLITE_TEXT: Result := string(PWideChar(sqlite3_column_text16(AStmt, i)));
      SQLITE_BLOB: Result := '[Blob Data]';  // BLOB data typically needs special handling
      SQLITE_NULL: Result := 'NULL';
    else
      Result := 'Unknown';
    end;
  end;

begin
  Result := False;
  if not Assigned(FHandle) then Exit;

  LRes := sqlite3_prepare16_v2(FHandle, PChar(ASQL), -1, @FStmt, nil);
  if LRes <> SQLITE_OK then
  begin
    FLastError := string(PWideChar(sqlite3_errmsg16(FHandle)));
    Exit;
  end;

  if ASQL.StartsWith('with') then
  begin
    writeln('got here');
    writeln(sqlite3_bind_text16(FStmt, 1,PChar('firearm courtroom'), -1, sqlite3_destructor_type(0)));
  end;


  LRes := sqlite3_step(FStmt);
  if (LRes <> SQLITE_DONE) and (LRes <> SQLITE_ROW) then
  begin
    FLastError := string(PWideChar(sqlite3_errmsg16(FHandle)));
    sqlite3_finalize(FStmt);
    FStmt := nil;
    Exit;
  end;

  FResponseText := '';
  if LRes = SQLITE_ROW then
  begin
    FDataset := TJSONArray.Create;
    while LRes = SQLITE_ROW do
    begin
      var Row := TJSONObject.Create;
      for i := 0 to sqlite3_column_count(FStmt) - 1 do
      begin
        LName := string(PWideChar(sqlite3_column_name16(FStmt, i)));
        LValue := GetTypeAsString(FStmt, i);

        Row.AddPair(LName, LValue);
      end;
      FDataset.AddElement(Row);
      LRes := sqlite3_step(FStmt);
    end;
    FJSON := TJSONObject.Create;
    FJSON.AddPair('response', FDataset);
    FResponseText := FJson.Format();
  end;

  FLastError := '';
  Result := True;
  sqlite3_finalize(FStmt);
  FStmt := nil;
end;

function TLocalDb.GetLastError(): string;
begin
  Result := FLastError;
end;

function TLocalDb.GetResponseText(): string;
begin
  Result := FResponseText;
end;

//=== REMOTEDB ==============================================================
type
  { TRemoteDb }
  TRemoteDb = class(TBaseInterface, IRemoteDb)
  protected const
    cURL = '/?apikey=%s&keyspace=%s&query=%s';
  protected
    FUrl: string;
    FApiKey: string;
    FDatabase: string;
    FResponseText: string;
    FLastError: string;
    FHttp: THTTPClient;
    FSQL: TStringList;
    FPrepairedSQL: string;
    FJSON: TJSONObject;
    FDataset: TJSONArray;
    FMacros: TDictionary<string, string>;
    FParams: TDictionary<string, string>;
    procedure SetMacroValue(const AName, AValue: string);
    procedure SetParamValue(const AName, AValue: string);
    procedure Prepair();
    function  GetQueryURL(const ASQL: string): string;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Setup(const AURL, AApiKey, ADatabase: string);
    procedure ClearSQLText();
    procedure AddSQLText(const AText: string; const AArgs: array of const);
    function  GetSQLText(): string;
    procedure SetSQLText(const AText: string);
    function  GetPrepairedSQL(): string;
    procedure ClearMacros();
    function  GetMacro(const AName: string): string;
    procedure SetMacro(const AName, AValue: string);
    procedure ClearParams();
    function  GetParam(const AName: string): string;
    procedure SetParam(const AName, AValue: string);
    function  RecordCount(): Integer;
    function  GetField(const AIndex: Cardinal; const AName: string): string;
    function  Execute(): Boolean;
    function  ExecuteSQL(const ASQL: string): Boolean;
    function  GetLastError(): string;
    function  GetResponseText(): string;
  end;

{ TRemoteDb }
procedure TRemoteDb.SetMacroValue(const AName, AValue: string);
begin
  FPrepairedSQL := FPrepairedSQL.Replace('&'+AName, AValue);
end;

procedure TRemoteDb.SetParamValue(const AName, AValue: string);
begin
  FPrepairedSQL := FPrepairedSQL.Replace(':'+AName, ''''+AValue+'''');
end;

procedure TRemoteDb.Prepair();
var
  LKey: string;
begin
  FPrepairedSQL := FSQL.Text;

  // substitue macros
  for LKey in FMacros.Keys do
  begin
    SetMacroValue(LKey, FMacros.Items[LKey]);
  end;

  // substitue field params
  for LKey in FParams.Keys do
  begin
    SetParamValue(LKey, FParams.Items[LKey]);
  end;
end;

constructor  TRemoteDb.Create();
begin
  inherited;
  FSQL := TStringList.Create;
  FHttp := THTTPClient.Create;
  FMacros := TDictionary<string, string>.Create;
  FParams := TDictionary<string, string>.Create;
end;

destructor TRemoteDb.Destroy();
begin
  if Assigned(FJson) then
  begin
    FJson.Free();
    FJson := nil;
  end;
  FParams.Free();
  FMacros.Free();
  FHttp.Free();
  FSQL.Free();
  inherited;
end;

procedure TRemoteDb.Setup(const AURL, AApiKey, ADatabase: string);
begin
  FUrl := AURL + cURL;
  FApiKey := AApiKey;
  FDatabase := ADatabase;
end;

procedure TRemoteDb.ClearSQLText();
begin
  FSQL.Clear();
end;

procedure TRemoteDb.AddSQLText(const AText: string;
  const AArgs: array of const);
begin
  FSQL.Add(Format(AText, AArgs));
end;

function  TRemoteDb.GetSQLText: string;
begin
  Result := FSQL.Text;
end;

procedure TRemoteDb.SetSQLText(const AText: string);
begin
  FSQL.Text := AText;
end;

function  TRemoteDb.GetPrepairedSQL: string;
begin
  Result := FPrepairedSQL;
end;

procedure TRemoteDb.ClearMacros();
begin
  FMacros.Clear();
end;

function  TRemoteDb.GetMacro(const AName: string): string;
begin
  FMacros.TryGetValue(AName, Result);
end;

procedure TRemoteDb.SetMacro(const AName, AValue: string);
begin
  FMacros.AddOrSetValue(AName, AValue);
end;

procedure TRemoteDb.ClearParams();
begin
  FParams.Clear();
end;

function  TRemoteDb.GetParam(const AName: string): string;
begin
  FParams.TryGetValue(AName, Result);
end;

procedure TRemoteDb.SetParam(const AName, AValue: string);
begin
  FParams.AddOrSetValue(AName, AValue);
end;

function  TRemoteDb.RecordCount(): Integer;
begin
  Result := 0;
  if not Assigned(FDataset) then Exit;
  Result := FDataset.Count;
end;

function  TRemoteDb.GetField(const AIndex: Cardinal;
  const AName: string): string;
begin
  Result := '';
  if not Assigned(FDataset) then Exit;
  if AIndex > Cardinal(FDataset.Count-1) then Exit;
  Result := FDataset.Items[AIndex].GetValue<string>(AName);
end;

function  TRemoteDb.GetQueryURL(const ASQL: string): string;
begin
  Result := Format(FUrl, [FApiKey, FDatabase, ASQL]);
end;


function TRemoteDb.Execute(): Boolean;
begin
  Prepair;
  Result := ExecuteSQL(FPrepairedSQL);
end;

function  TRemoteDb.ExecuteSQL(const ASQL: string): Boolean;
var
  LResponse: IHTTPResponse;
begin
  Result := False;
  if ASQL.IsEmpty then Exit;
  LResponse := FHttp.Get(GetQueryURL(ASQL));
  FResponseText := LResponse.ContentAsString;
  if Assigned(FJson) then
  begin
    if Assigned(FJSON) then
    begin
      FJson.Free();
      FJson := nil;
    end;

    FDataset := nil;
  end;
  FJson := TJSONObject.ParseJSONValue(FResponseText) as TJSONObject;
  FLastError := FJson.GetValue('response').Value;
  Result := Boolean(FLastError.IsEmpty or SameText(FLastError, 'true'));
  if FLastError.IsEmpty then
  begin
    if Assigned(FDataset) then
    begin
      FDataset.Free();
      FDataset := nil;
    end;
    FJson.TryGetValue('response', FDataset);
  end;
  if not Assigned(FDataset) then
  begin
    FJson.Free();
    FJson := nil;
  end;
end;

function TRemoteDb.GetLastError(): string;
begin
  Result := FLastError;
end;

function TRemoteDb.GetResponseText(): string;
begin
  Result:= FResponseText;
end;

//===========================================================================
initialization
begin
  IRegister(ILocalDb, TLocalDb);
  IRegister(IRemoteDb, TRemoteDb);
end;

finalization
begin
end;

end.
