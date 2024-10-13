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

unit Mamba.CRuntime;

{$I Mamba.Defines.inc}

interface

const
  kernelbase = 'kernelbase.dll';
  kernel32 = 'kernel32.dll';
  gdi32 = 'gdi32.dll';
  shell32 = 'shell32.dll';
  ucrt = 'api-ms-win-crt-stdio-l1-1-0.dll';
  msvcrt = 'msvcrt.dll';
  user32 = 'user32.dll';

//=== KERNELBASE ============================================================
procedure ___chkstk_ms; stdcall; external kernelbase name '__chkstk';

//=== KERNEL32 ==============================================================
procedure GetModuleHandleExW; stdcall; external kernel32;

//=== USER32 ================================================================
procedure EnumDisplaySettingsExW; stdcall; external user32;
procedure GetMonitorInfoW; stdcall; external user32;
procedure DragAcceptFiles; stdcall; external shell32;
procedure MonitorFromWindow; stdcall; external user32;
procedure EnumDisplayMonitors; stdcall; external user32;
procedure GetRawInputDeviceList; stdcall; external user32;
procedure GetRawInputDeviceInfoA; stdcall; external user32;
procedure RegisterRawInputDevices; stdcall; external user32;
procedure GetRawInputData; stdcall; external user32;

//=== SHELL32 ===============================================================
procedure DragQueryFileW; stdcall; external shell32;
procedure DragQueryPoint; stdcall; external shell32;
procedure DragFinish; stdcall; external shell32;

//=== UCRT ==================================================================
procedure feof; cdecl; external ucrt;
procedure memset; cdecl; external ucrt;
procedure strcpy; cdecl; external ucrt;
procedure strncmp; cdecl; external ucrt;
procedure strstr; cdecl; external ucrt;
procedure strlen; cdecl; external ucrt;
procedure strtok; cdecl; external ucrt;
procedure memcpy; external ucrt;
procedure malloc; cdecl; external ucrt;
procedure realloc; cdecl; external ucrt;
procedure free; cdecl; external ucrt;
procedure strcspn; cdecl; external ucrt;
procedure strspn; cdecl; external ucrt;
procedure strtoul; cdecl; external ucrt;
procedure strncpy; cdecl; external ucrt;
procedure memmove; cdecl; external ucrt;
procedure qsort; cdecl; external ucrt;
procedure pow; cdecl; external ucrt;
procedure wcscmp; cdecl; external ucrt;
procedure wcscpy; cdecl; external ucrt;
procedure strcmp; cdecl; external ucrt;
procedure strtol; cdecl; external ucrt;
procedure fseek; cdecl; external ucrt;
procedure fclose; cdecl; external ucrt;
procedure ftell; cdecl; external ucrt;
procedure calloc; cdecl; external ucrt;
procedure memcmp; cdecl; external ucrt;
procedure frexp; cdecl; external ucrt;
procedure fwrite; cdecl; external ucrt;
procedure sqrtf; cdecl; external ucrt;
procedure floor; cdecl; external ucrt;
procedure ceilf; cdecl; external ucrt;
procedure fmod; cdecl; external ucrt;
procedure acos; cdecl; external ucrt;
procedure wcslen; cdecl; external ucrt;
procedure _errno; cdecl; external ucrt;
procedure log; cdecl; external ucrt;
procedure fread; cdecl; external ucrt;
procedure floorf; cdecl; external ucrt;
procedure _wfopen; cdecl; external ucrt;
procedure _stricmp; cdecl; external ucrt;
procedure wcsrtombs; cdecl; external ucrt;
procedure fgetc; cdecl; external ucrt;
procedure ferror; cdecl; external ucrt;
procedure _ftelli64; cdecl; external ucrt;
procedure _fseeki64; cdecl; external ucrt;
procedure longjmp; cdecl; external ucrt;
procedure clock; cdecl; external ucrt;
procedure memchr; cdecl; external ucrt;
procedure srand; cdecl; external ucrt;
procedure rand; external ucrt;
procedure _time64; cdecl; external ucrt;
procedure ungetc; cdecl; external ucrt;
procedure ldexp; cdecl; external ucrt;
procedure fopen; cdecl; external ucrt;
procedure fopen64; cdecl; external ucrt name 'fopen';
procedure __intrinsic_setjmpex; cdecl; external ucrt name '_setjmp';

//=== MSVCRT ================================================================
procedure vsnprintf; cdecl; external msvcrt name '_vsnprintf';
procedure sscanf; cdecl varargs; external msvcrt name 'sscanf';
procedure sprintf; cdecl varargs; external msvcrt name 'sprintf';

implementation

end.
