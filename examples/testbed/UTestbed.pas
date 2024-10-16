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

unit UTestbed;

{$I Mamba.Defines.inc}

interface

procedure RunTests();

implementation

uses
  System.SysUtils,
  Mamba.Core,
  Mamba.Database;

const
  CZipFilename = 'data.zip';

//=== ZIPFILE ===============================================================
procedure Test_ZipFile01_BuildProgress(const ASender: Pointer; const AFilename: string; const AProgress: Integer; const ANewFile: Boolean);
begin
  if aNewFile then Console.PrintLn('', []);
  Console.Print(CR+'%sAdding %s(%d%s)...', [CSIDim+CSIFGWhite, ExtractFileName(string(aFilename)), aProgress, '%']);
end;

procedure Test_ZipFile01();
var
  LZip: IZipFileIO;
begin
  // Set the console title for the application window
  Console.SetTitle('MGT: ZipFile #01');

  IGet(IZipFileIO, LZip);

  if LZip.Build(CZipFilename, 'res', nil, Test_ZipFile01_BuildProgress) then
    Console.PrintLn(CRLF+'%sSuccess!', [CSIFGCyan])
  else
    Console.PrintLn(CRLF+'%sFailed!', [CSIFGRed]);

  IRelease(LZip);
end;

//=== WINDOW ================================================================
procedure Test_Window01();
const
  CFalseTrue: array[False..True] of string = ('no focus', 'has focus');
var
  LWindow: IWindow;
  LTexture: ITexture;
  LFont: IFont;
  LPos: TPoint;
  LHudPos: TPoint;
begin
  IGet(IWindow, LWindow);

  LWindow.Open('MGT: Window #01');

  IGet(IFont, LFont);
  LFont.Load(LWindow, 10);

  IGet(ITexture, LTexture);
  LTexture.LoadFromZipFile(CZipFilename, 'res/images/mgt.png');
  LTexture.SetPos(LWindow.GetVirtualSize().w/2, LWindow.GetVirtualSize().h/2);
  LTexture.SetScale(0.5);

  LPos.x := 0;
  LPos.y := 25;

  Utils.AsyncRun('Task #01',
  // background task
  procedure
  var
    i: Cardinal;
  begin
    for i := 1 to 1000000 do
    begin
      writeln(i);
      if Utils.AsyncShouldTerminate('Task #01') then
      begin
        writeln('Terminating task...');
        Exit;
      end;
    end;
  end,
  // forground task
  procedure
  begin
    writeln('Background task done!');
  end);

  while not LWindow.ShouldClose() do
  begin
    LWindow.StartFrame();

      if LWindow.GetKey(KEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      if LWindow.GetKey(KEY_F11, isWasPressed) then
        LWindow.ToggleFullscreen();

      LPos.x := LPos.x + 3.0;
      if LPos.x > LWindow.GetVirtualSize().w + 25 then
        LPos.x := -25;

      LWindow.StartDrawing();

        LWindow.Clear(DARKSLATEBROWN);

        LTexture.Draw(LWindow);

        LWindow.DrawFilledRect(LPos.x, LPos.y, 50, 50, RED, 0);

        LHudPos := Math.Point(3, 3);

        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, '%d fps', [LWindow.GetFrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, Utils.HudTextItem('Quit', 'ESC'));
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, Utils.HudTextItem('F11', 'Toggle fullscreen'));

        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, ORANGE, haLeft, Utils.HudTextItem('Mouse Wheel','x:%3.2f, y:%3.2f', 20, ' '), [LWindow.GetMouseWheel().x, LWindow.GetMouseWheel().y]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, ORANGE, haLeft, Utils.HudTextItem('Mouse Pos', 'x:%3.2f, y:%3.2f', 20, ' '), [LWindow.GetMousePos().x, LWindow.GetMousePos().y]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, ORANGE, haLeft, Utils.HudTextItem('Window', '%s', 20, ' '), [CFalseTrue[LWindow.HasFocus()]]);

      LWindow.EndDrawing();

    LWindow.EndFrame();
  end;

  Utils.AsyncWaitForAllToTerminate();

  IRelease(LTexture);

  IRelease(LFont);

  LWindow.Close();

  IRelease(LWindow);
end;

//=== INTERFACE =============================================================
type
  IMyInterface = interface(IBaseInterface)
    ['{758A066B-DD5C-460C-978E-42C3F1E53322}']
    procedure Test();
  end;

type
  TMyInterface = class(TBaseInterface, IMyInterface)
  public
    procedure Test();
  end;

procedure TMyInterface.Test();
begin
  writeln('this is a test');
end;

procedure Test_Interface01();
var
  I: IMyInterface;
begin
  IRegister(IMyInterface, TMyInterface);

  IGet(IMyInterface, I);
  I.Test();
  IRelease(I);
end;

//=== TEXTURE ===============================================================
procedure Test_Texture01();
var
  LWindow: IWindow;
  LTexture: ITexture;
  LFont: IFont;
  LPos: TPoint;
  LHudPos: TPoint;
begin
  IGet(IWindow, LWindow);

  LWindow.Open('MGT: Texture #01');

  IGet(IFont, LFont);
  LFont.Load(LWindow, 10);

  IGet(ITexture, LTexture);
  LTexture.LoadFromZipFile(CZipFilename, 'res/images/mgt.png');
  LTexture.SetPos(LWindow.GetVirtualSize().w/2, LWindow.GetVirtualSize().h/2);
  LTexture.SetScale(0.5);

  LPos.x := 0;
  LPos.y := 25;

  while not LWindow.ShouldClose() do
  begin
    LWindow.StartFrame();

      if LWindow.GetKey(KEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      if LWindow.GetKey(KEY_F11, isWasPressed) then
        LWindow.ToggleFullscreen();

      LPos.x := LPos.x + 3.0;
      if LPos.x > LWindow.GetVirtualSize().w + 25 then
        LPos.x := -25;

      LWindow.StartDrawing();

        LWindow.Clear(DARKSLATEBROWN);

        LTexture.Draw(LWindow);

        LWindow.DrawFilledRect(LPos.x, LPos.y, 50, 50, RED, 0);

        LHudPos := Math.Point(3, 3);

        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, '%d fps', [LWindow.GetFrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, Utils.HudTextItem('ESC', 'Quit'));
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, Utils.HudTextItem('F11', 'Toggle fullscreen'));

      LWindow.EndDrawing();

    LWindow.EndFrame();
  end;

  IRelease(LTexture);

  IRelease(LFont);

  LWindow.Close();

  IRelease(LWindow);
end;

//=== VIDEO =================================================================
procedure Test_Video01_VideoStatusEvent(const ASender: Pointer; const AStatus: TVideoStatus; const AFilename: string);
begin
  if AStatus = vsStopped then
  begin
    if AFilename = 'res/videos/mgt.mpg' then
      Video.PlayFromZipFile(CZipFilename, 'res/videos/tbg.mpg', 1.0, False)
    else
    if AFilename = 'res/videos/tbg.mpg' then
      Video.PlayFromZipFile(CZipFilename, 'res/videos/sample01.mpg', 1.0, False)
    else
    if AFilename = 'res/videos/sample01.mpg' then
      Video.PlayFromZipFile(CZipFilename, 'res/videos/mgt.mpg', 1.0, False);
  end;
end;

procedure Test_Video01();
var
  LWindow: IWindow;
  LFont: IFont;
  LHudPos: TPoint;
begin
  IGet(IWindow, LWindow);

  LWindow.Open('MGT: Video #01');

  IGet(IFont, LFont);
  LFont.Load(LWindow, 10);

  Video.SetStatusEvent(nil, Test_Video01_VideoStatusEvent);
  Video.PlayFromZipFile(CZipFilename, 'res/videos/mgt.mpg', 1.0, False);

  while not LWindow.ShouldClose() do
  begin
    LWindow.StartFrame();

      if LWindow.GetKey(KEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      if LWindow.GetKey(KEY_F11, isWasPressed) then
        LWindow.ToggleFullscreen();

      LWindow.StartDrawing();

        LWindow.Clear(DARKSLATEBROWN);

        Video.Draw(LWindow, 0, 0, 0.5);

        LHudPos := Math.Point(3, 3);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, '%d fps', [LWindow.GetFrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, Utils.HudTextItem('ESC', 'Quit'));
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, Utils.HudTextItem('F11', 'Toggle fullscreen'));

      LWindow.EndDrawing();

    LWindow.EndFrame();
  end;

  Video.Stop();

  IRelease(LFont);

  LWindow.Close();

  IRelease(LWindow);
end;

//=== AUDIO =================================================================
procedure Test_Audo01();
var
  LWindow: IWindow;
  LFont: IFont;
  LHudPos: TPoint;
begin
  IGet(IWindow, LWindow);

  LWindow.Open('MGT: Audio #01');

  IGet(IFont, LFont);
  LFont.Load(LWindow, 10);

  if not Audio.Open() then
    writeln('bad news');

  Audio.PlayMusicFromZipFile(CZipFilename, 'res/music/song01.ogg', 1.0, True);

  while not LWindow.ShouldClose() do
  begin
    LWindow.StartFrame();

      if LWindow.GetKey(KEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      if LWindow.GetKey(KEY_F11, isWasPressed) then
        LWindow.ToggleFullscreen();

      LWindow.StartDrawing();

        LWindow.Clear(DARKSLATEBROWN);

        LHudPos := Math.Point(3, 3);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, '%d fps', [LWindow.GetFrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, Utils.HudTextItem('ESC', 'Quit'));
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, Utils.HudTextItem('F11', 'Toggle fullscreen'));

      LWindow.EndDrawing();

    LWindow.EndFrame();
  end;

  Audio.Close();

  IRelease(LFont);

  LWindow.Close();

  IRelease(LWindow);
end;

//=== FONT ==================================================================
procedure Test_Font01();
var
  LWindow: IWindow;
  LFont: array[0..1] of  IFont;
  LHudPos: TPoint;
begin
  IGet(IWindow, LWindow);

  LWindow.Open('MGT: Font #01');

  IGet(IFont, LFont[0]);
  LFont[0].Load(LWindow, 10);

  IGet(IFont, LFont[1]);
  LFont[1].LoadFromZipFile(LWindow, CZipFilename, 'res\fonts\unifont.ttf', 12, 'こんにちは안녕하세요你好नमस्कारሰላም');


  while not LWindow.ShouldClose() do
  begin
    LWindow.StartFrame();

      if LWindow.GetKey(KEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      if LWindow.GetKey(KEY_F11, isWasPressed) then
        LWindow.ToggleFullscreen();

      LWindow.StartDrawing();

        LWindow.Clear(DARKSLATEBROWN);

        LHudPos := Math.Point(3, 100);
        LFont[1].DrawText(LWindow, LHudPos.x, LHudPos.y, 0, ORANGE, haLeft, 'Hello (Hindi): नमस्कार');
        LFont[1].DrawText(LWindow, LHudPos.x, LHudPos.y, 0, ORANGE, haLeft, 'Hello (Chinese): 你好');
        LFont[1].DrawText(LWindow, LHudPos.x, LHudPos.y, 0, ORANGE, haLeft, 'Hello (Korean): 안녕하세요');
        LFont[1].DrawText(LWindow, LHudPos.x, LHudPos.y, 0, ORANGE, haLeft, 'Hello (Japanese): こんにちは');
        LFont[1].DrawText(LWindow, LHudPos.x, LHudPos.y, 0, ORANGE, haLeft, 'Hello (Amaric): ሰላም');

        LHudPos := Math.Point(3, 3);
        LFont[0].DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, '%d fps', [LWindow.GetFrameRate()]);
        LFont[0].DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, Utils.HudTextItem('ESC', 'Quit'));
        LFont[0].DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, Utils.HudTextItem('F11', 'Toggle fullscreen'));

      LWindow.EndDrawing();

    LWindow.EndFrame();
  end;

  IRelease(LFont[1]);
  IRelease(LFont[0]);

  LWindow.Close();

  IRelease(LWindow);
end;

//=== DATABASE ==============================================================
procedure Test_LocalDb01();
const
  CDropTableSQL = 'DROP TABLE IF EXISTS articles';

  CCreateTableSQL = 'CREATE TABLE IF NOT EXISTS articles (' +
                    'headline TEXT' +
                    ');';

  CInsertArticlesSQL = 'INSERT INTO articles VALUES ' +
    '(''Shohei Ohtani''''s ex-interpreter pleads guilty to charges related to gambling and theft''), ' +
    '(''The jury has been selected in Hunter Biden''''s gun trial''), ' +
    '(''Larry Allen, a Super Bowl champion and famed Dallas Cowboy, has died at age 52''), ' +
    '(''After saying Charlotte, a lone stingray, was pregnant, aquarium now says she''''s sick''), ' +
    '(''An Epoch Times executive is facing money laundering charge'');';

  CListArticles = 'SELECT * FROM articles';
var
  LDb: ILocalDb;
  I: Integer;
begin
  Console.SetTitle('MGT: LocalDb #01');

  IGet(ILocalDb, LDb);
  try
    if LDb.Open('articles.db') then
    begin
      Console.PrintLn();

      // drop existing table
      if LDb.ExecuteSQL(CDropTableSQL) then
        Console.PrintLn('Removing "articals" table if exists...')
      else
        Console.PrintLn(LDb.GetLastError());

      // create articles table
      if LDb.ExecuteSQL(CCreateTableSQL) then
        Console.Print('Created "articals" table..')
      else
        Console.PrintLn(LDb.GetLastError());

      // insert articles into table
      if LDb.ExecuteSQL(CInsertArticlesSQL) then
        Console.PrintLn('Added articles into "articals" table..')
      else
        Console.PrintLn(LDb.GetLastError());

      // display articles table as JSON
      if LDb.ExecuteSQL(CListArticles) then
      begin
        Console.PrintLn('Display "articals" table..', []);
        Console.PrintLn(LDb.GetResponseText());
      end
      else
        Console.PrintLn(LDb.GetLastError());

      Console.PrintLn();
      for I := 0 to LDb.RecordCount()-1 do
      begin
        Console.PrintLn('headline: %s', [LDb.GetField(I, 'headline')]);
      end;

      LDb.Close();
    end;
  finally
    IRelease(LDb);
  end;
end;

procedure Test_LocalDb02();
const
  CCreateScoreTableSQL: PWideChar = 'CREATE TABLE IF NOT EXISTS &gameid (' +
    'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
    'name TEXT NOT NULL, ' +
    'level INTEGER, ' +
    'score INTEGER, ' +
    'skill TEXT, ' +
    'duration INTEGER, ' +
    'location TEXT, ' +
    'UNIQUE(name))';

  CAddScoreSQL: PWideChar =
    'INSERT INTO &gameid (name, level, score, skill, duration, location) ' +
    'VALUES (:name, :level, :score, :skill, :duration, :location) ' +
    'ON CONFLICT(name) DO UPDATE SET ' +
    'level    = CASE WHEN :score > score THEN :level ELSE level END, ' +
    'skill    = CASE WHEN :score > score THEN :skill ELSE skill END, ' +
    'location = CASE WHEN :score > score THEN :location ELSE location END, ' +
    'duration = CASE WHEN :score > score THEN :duration ELSE duration END, ' +
    'score    = CASE WHEN :score > score THEN :score ELSE score END;';

  CListScoresSQL: PWideChar =
    'SELECT * FROM &gameid WHERE level = :level AND skill = :skill ORDER by score DESC';
var
  LDb: ILocalDb;

  function AddScore(const ADb: ILocalDb; const AName, AScore, ALocation: string): Boolean;
  begin
    // set addscore SQL
    ADb.SetSQLText(CAddScoreSQL);
    ADb.SetMacro('gameid', 'my_game');
    ADb.SetParam('name', AName);
    ADb.SetParam('level', '1');
    ADb.SetParam('score', AScore);
    ADb.SetParam('skill', '1');
    ADb.SetParam('duration', '0');
    ADb.SetParam('location', ALocation);

    // add score
    Result := ADb.Execute();

    // show any errors
    if not Result then
    begin
      Console.PrintLn('%s%s', [CSIFGRed, ADb.GetLastError()]);
    end;
  end;

  procedure ListScores(const ADb: ILocalDb);
  var
    I: Integer;
  begin
    // set list scores SQL
    ADb.SetSQLText(CListScoresSQL);

    // get score list
    if not  ADb.Execute() then
      begin
        Console.PrintLn('%s%s', [CSIFGRed, ADb.GetLastError()]);
      end
    else
      begin
        Console.PrintLn();

        // loop over returned scores
        for I := 0 to ADb.RecordCount()-1 do
        begin
          // print score information
          Console.PrintLn('%s, %s, %s', [
            ADb.GetField(I, 'name'),
            ADb.GetField(I, 'score'),
            ADb.GetField(I, 'location')
          ]);
        end;

        Console.PrintLn();
        Console.PrintLn(ADb.GetResponseText());
      end;
  end;

begin
  Console.SetTitle('MGT: LocalDb #02');


  IGet(ILocalDb, LDb);
  try
    // open db
    if LDb.Open('game.db') then
    begin
      // set create table SQL
      LDb.SetSQLText(CCreateScoreTableSQL);

      // set gameid macro
      LDb.SetMacro('gameid', 'my_game');

      // create table if does not exist
      if not LDb.Execute() then
        begin
          // display error message
          Console.PrintLn('%s%s', [CSIFGRed, LDb.GetLastError()]);
        end
      else
        begin
          // add a few scores
          AddScore(LDb, 'ShadowBladeX', '10', 'Alabama');
          AddScore(LDb, 'NeonNinja', '413', 'Colorado');
          AddScore(LDb, 'PixelPirate', '200', 'Georgia');
          AddScore(LDb, 'QuantumKnight', '35', 'Illinois');
          AddScore(LDb, 'TurboTornado', '987', 'Kansas');
          AddScore(LDb, 'CyberSamurai', '670', 'Montana');
          AddScore(LDb, 'GalacticGamer', '100', 'Ohio');
          AddScore(LDb, 'MysticMage', '543', 'Texas');
          AddScore(LDb, 'PhantomSniper', '250', 'Wisconsin');
          AddScore(LDb, 'FrostFury', '30', 'Hawaii');

          // display scores
          ListScores(LDb);
        end;

      // close db
      LDb.Close();
    end;
  finally
    IRelease(LDb);
  end;
end;

{
  RemoteDB - PHP Interface for Remote MySQL Database (in 'src/remotedb' folder)

  1. If you are using cPanel, ensure that both php_mysql and pdo_mysql
     extensions are enabled.
  2. Update the config.php file to set your MySQL configuration.
  3. In the Config class within index.php, adjust the path to correctly
     reference your config.php script.
  4. Ensure that config.php is stored outside of the publicly accessible HTTP
     directory for security reasons.

-----------------------------------------------------------------------------

  Explanation of SQL Static Macros (&text) and Dynamic Parameters (:text):

  1. SQL Static Macros (&text):
     - Purpose: Static macros are placeholders in your SQL query that are
       replaced with fixed values or strings at the time the SQL text is
       prepared.
     - How it works: When you use &text in your SQL statement, it acts as a
       macro that is replaced with a specific value or table name before the
       query is executed. This is typically used for SQL elements that don't
       change per execution, like table names or field names.
     - Example: If you have 'SELECT * FROM &table;' in your SQL text, and you
       set &table to 'users', the final SQL executed would be
       'SELECT * FROM users;'.
     - Analogy: Think of it like a "find and replace" that happens before the
       query runs.

  2. SQL Dynamic Parameters (:text):
     - Purpose: Dynamic parameters are used to securely insert variable data
       into SQL queries at runtime. They are typically used for values that
       can change, such as user input or variable data, and are often used to
       prevent SQL injection.
     - How it works: When you use :text in your SQL statement, it acts as a
       placeholder that will be dynamically replaced with an actual value at
       runtime. The value is passed separately from the SQL query, allowing
       for secure and flexible data handling.
     - Example: If you have 'SELECT * FROM users WHERE id = :userId;' in your
       SQL text, and you bind :userId to the value '42', the final SQL
       executed would be 'SELECT * FROM users WHERE id = 42;'.
     - Analogy: Think of it as a variable that gets its value just before the
       SQL query is run, making it possible to execute the same query with
       different data multiple times.
}

procedure Test_RemoteDb01();
const
  // Cloud database connection details.
  CDbURL = 'https://mambagametoolkit.com/remotedb/mgt-examples';  // URL of the cloud database.
  CDbApiKey = 'c91c8b1561fc4890a216e2a550c2e5de';                // API key for accessing the cloud database.
  CDbName = 'testbed';                                           // Name of the database.
  CDbTable = 'game1';                                            // Name of the table in the database.

var
  LCloudDB: IRemoteDb;                   // Instance of TCloudDb to handle database operations
  LCount: Integer;                      // Variable to store the number of records retrieved
  I: Integer;                           // Loop counter for iterating through records
  LName, LLevel, LScore, LSkill,        // Variables to hold individual field values from each record
  LDuration, LLocation: string;
begin
  // Set the console title for the application window
  Console.SetTitle('MGT: RemoteDb #01');

  // Create an instance of TCloudDb to manage the connection to the database
  IGet(IRemoteDb, LCloudDb);
  try
    // Setup the CloudDB connection with the specified URL, API key, and database name
    LCloudDB.Setup(CDbURL, CDbApiKey, CDbName);

    // Set the SQL query text to select all records from the specified table
    LCloudDb.SetSQLText('SELECT * FROM &table;');

    // Set a macro to replace the placeholder "&table" with the actual table name
    LCloudDb.SetMacro('table', CDbTable);

    // Execute the SQL query and check if it returns any records
    if LCloudDB.Execute() then
    begin
      // Retrieve the count of records returned by the query
      LCount := LCloudDB.RecordCount();
      Console.PrintLn(); // Print a blank line for spacing

      // Print the title of the table
      Console.PrintLn();
      Console.PrintLn('%s%s', [CSIFGMagenta, '                          --= H I G H S C O R E S =--']);

      // Print the table header with column names
      Console.PrintLn('-------------------------------------------------------------------------------');
      Console.PrintLn('| %-20s | %-5s | %-6s | %-10s | %-8s | %-10s |', ['Name', 'Level', 'Score', 'Skill', 'Duration', 'Location']);
      Console.PrintLn('-------------------------------------------------------------------------------');

      // Iterate through each record and print the fields in a formatted table row
      for I := 0 to LCount-1 do
      begin
        // Retrieve and store each field value from the current record
        LName := LCloudDB.GetField(I, 'name');
        LLevel := LCloudDB.GetField(I, 'level');
        LScore := LCloudDB.GetField(I, 'score');
        LSkill := LCloudDB.GetField(I, 'skill');
        LDuration := LCloudDB.GetField(I, 'duration');
        LLocation := LCloudDB.GetField(I, 'location');

        // Print the field values in a formatted table row
        Console.PrintLn('| %-20s | %-5s | %-6s | %-10s | %-8s | %-10s |', [LName, LLevel, LScore, LSkill, LDuration, LLocation]);
      end;

      // Print the table footer to close off the table
      Console.PrintLn('-------------------------------------------------------------------------------');
    end;
  finally
    // Free the ICloudDb instance to release resources
    IRelease(LCloudDb);
  end;
end;

//=== CAMERA ================================================================
procedure Test_Camera01();
type
  // TObj represents a drawable object with position, size, and color.
  TObj = record
    X, Y, Size: Single;       // Position and size of the object.
    Color: TColor;            // Color of the object.
  end;
var
  LWindow: IWindow;
  LFont: IFont;
  LHudPos: TPoint;
  FCam: ICamera;                // Represents the camera for viewing and transformation.
  FObj: array[0..1000] of TObj; // Array of objects to be rendered.

  // InitObjects initializes the objects with random positions, sizes, and colors.
  procedure InitObjects();
  var
    I: Integer;
  begin
    for I := Low(FObj) to High(FObj) do
    begin
      FObj[I].X := Math.RandomRange(-10000, 10000);
      FObj[I].Y := Math.RandomRange(-10000, 10000);
      FObj[I].Size := Math.RandomRange(50, 250);
      FObj[I].Color.r := Math.RandomRange(0, 255) / $FF;
      FObj[I].Color.g := Math.RandomRange(0, 255) / $FF;
      FObj[I].Color.b := Math.RandomRange(0, 255) / $FF;
      FObj[I].Color.a := 1;
    end;
  end;

  // DrawObjects renders each object to the window.
  procedure DrawObjects();
  var
    I: Integer;
  begin
    for I := Low(FObj) to High(FObj) do
    begin
      LWindow.DrawFilledRect(FObj[I].X, FObj[I].Y, FObj[I].Size, FObj[I].Size, FObj[I].Color, 0);
    end;
  end;


begin
  IGet(IWindow, LWindow);

  LWindow.Open('MGT: Camera #01');

  IGet(IFont, LFont);
  LFont.Load(LWindow, 10);

  IGet(ICamera, FCam);
  FCam.X := CDefaultWindowWidth;
  FCam.Y := CDefaultWindowHeight;
  FCam.Rotation := 0;
  FCam.Scale := 0.20;

  // Initialize the objects with random properties.
  InitObjects();

  while not LWindow.ShouldClose() do
  begin
    LWindow.StartFrame();

      if LWindow.GetKey(KEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      if LWindow.GetKey(KEY_F11, isWasPressed) then
        LWindow.ToggleFullscreen();

      // Control camera movement and transformation based on key inputs.
      if LWindow.GetKey(KEY_DOWN, isPressed) then
        FCam.Move(0, 10)
      else if LWindow.GetKey(KEY_UP, isPressed) then
        FCam.Move(0, -10);

      if LWindow.GetKey(KEY_RIGHT, isPressed) then
        FCam.Move(10, 0)
      else if LWindow.GetKey(KEY_LEFT, isPressed) then
        FCam.Move(-10, 0);

      if LWindow.GetKey(KEY_A, isPressed) then
        FCam.Rotate(-2)
      else if LWindow.GetKey(KEY_D, isPressed) then
        FCam.Rotate(3);

      if LWindow.GetKey(KEY_S, isPressed) then
        FCam.Zoom(-0.01)
      else if LWindow.GetKey(KEY_W, isPressed) then
        FCam.Zoom(0.01);

      // Reset camera to default position, rotation, and scale if R key is released.
      if LWindow.GetKey(KEY_R, isWasReleased) then
      begin
        FCam.Reset();
        FCam.X := CDefaultWindowWidth;
        FCam.Y := CDefaultWindowHeight;
        FCam.Rotation := 0;
        FCam.Scale := 0.20;
      end;

      // Reinitialize objects if SPACE key is released.
      if LWindow.GetKey(KEY_SPACE, isWasReleased) then
        InitObjects();

      LWindow.StartDrawing();

        // Clear the window with a black background color.
        LWindow.Clear(BLACK);

        // Apply the camera transformation and draw objects.
        FCam.Use(LWindow);
        DrawObjects();
        FCam.Use(nil);

        LHudPos := Math.Point(3, 3);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, '%d fps', [LWindow.GetFrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, Utils.HudTextItem('Quit', 'ESC'));
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, Utils.HudTextItem('F11', 'Toggle fullscreen'));

        LFont.DrawText(LWindow, LHudPos.X, LHudPos.Y, 0, GREEN, haLeft, Utils.HudTextItem('Space', 'Spawn'), []);
        LFont.DrawText(LWindow, LHudPos.X, LHudPos.Y, 0, GREEN, haLeft, Utils.HudTextItem('Left/Right', 'cam move left/right'), []);
        LFont.DrawText(LWindow, LHudPos.X, LHudPos.Y, 0, GREEN, haLeft, Utils.HudTextItem('Up/Down', 'cam move up/down'), []);
        LFont.DrawText(LWindow, LHudPos.X, LHudPos.Y, 0, GREEN, haLeft, Utils.HudTextItem('W/S', 'cam zoom up/down'), []);
        LFont.DrawText(LWindow, LHudPos.X, LHudPos.Y, 0, GREEN, haLeft, Utils.HudTextItem('A/D', 'cam rotate up/down'), []);
        LFont.DrawText(LWindow, LHudPos.X, LHudPos.Y, 0, GREEN, haLeft, Utils.HudTextItem('R', 'Reset'), []);
        LFont.DrawText(LWindow, LHudPos.X, LHudPos.Y, 0, YELLOW, haLeft, Utils.HudTextItem('Pos', '%03.2f/%03.2f', 20, ' '), [FCam.X, FCam.Y]);
        LFont.DrawText(LWindow, LHudPos.X, LHudPos.Y, 0, YELLOW, haLeft, Utils.HudTextItem('Zoom', '%3.2f', 20, ' '), [FCam.Scale]);
        LFont.DrawText(LWindow, LHudPos.X, LHudPos.Y, 0, YELLOW, haLeft, Utils.HudTextItem('Angle', '%3.2f', 20, ' '), [FCam.Rotation]);

      LWindow.EndDrawing();

    LWindow.EndFrame();
  end;

  IRelease(FCam);

  IRelease(LFont);

  LWindow.Close();

  IRelease(LWindow);
end;

procedure RunTests();
begin
  Console.PrintLn('%sWelcome%s to %sMamba Game Toolkit v%s', [CSIBold+CSIBlink, CSIResetFormat, CSIFGGreen, MGT_VERSION_FULL]);

  // uncomment example to run

  //Test_ZipFile01();
  //Test_Interface01();
  //Test_Texture01();
  //Test_Video01();
  //Test_Audo01();
  //Test_Font01();
  //Test_Window01();
  //Test_LocalDb01();
  //Test_LocalDb02();
  //Test_RemoteDb01();
  Test_Camera01();
  Console.Pause();
end;

end.
