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

program Testbed;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UTestbed in 'UTestbed.pas',
  Mamba.Core in '..\..\src\Mamba.Core.pas',
  Mamba.CRuntime in '..\..\src\Mamba.CRuntime.pas',
  Mamba.Deps in '..\..\src\Mamba.Deps.pas',
  Mamba.OpenGL in '..\..\src\Mamba.OpenGL.pas',
  Mamba.Database in '..\..\src\Mamba.Database.pas';

begin
  try
    RunTests();
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
