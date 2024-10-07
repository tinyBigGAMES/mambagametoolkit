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
  Mamba;

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
  IGet(IZipFileIO, LZip);

  if LZip.Build(CZipFilename, 'res', nil, Test_ZipFile01_BuildProgress) then
    Console.PrintLn(CRLF+'%sSuccess!', [CSIFGCyan])
  else
    Console.PrintLn(CRLF+'%sFailed!', [CSIFGRed]);

  IRelease(LZip);
end;

//=== WINDOW ================================================================
procedure Test_Window01();
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
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, 'ESC - Quit', []);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, 'F11 - Toggle fullscreen', []);

      LWindow.EndDrawing();

    LWindow.EndFrame();
  end;

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
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, 'ESC - Quit', []);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, 'F11 - Toggle fullscreen', []);

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
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, 'ESC - Quit', []);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, 'F11 - Toggle fullscreen', []);

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
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, 'ESC - Quit', []);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft, 'F11 - Toggle fullscreen', []);

      LWindow.EndDrawing();

    LWindow.EndFrame();
  end;

  Audio.Close();

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
  Test_Video01();
  //Test_Audo01();
  Console.Pause();
end;

end.
