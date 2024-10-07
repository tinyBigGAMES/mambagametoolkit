:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                   __  __               _                                ::
::                  |  \/  | __ _  _ __  | |__  __ _                       ::
::                  | |\/| |/ _` || '  \ | '_ \/ _` |                      ::
::                  |_|  |_|\__,_||_|_|_||_.__/\__,_|                      ::
::                            Game Toolkit™                                ::
::                                                                         ::
::               Copyright © 2024-present tinyBigGAMES™ LLC                ::
::                        All Rights Reserved.                             ::
::                                                                         ::
::                  Website: https://tinybiggames.com                      ::
::                  Email  : support@tinybiggames.com                      ::
::                                                                         ::
::               See LICENSE file for license information                  ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
cd /d "%~dp0"
@TITLE ConvertAudio
echo Converting video to MGT compatible format....
echo(
rem ffmpeg.exe -i "%1" -c:v mpeg1video -q:v 11 -b:v 11055k -b:a 384k -maxrate 22110k -bufsize 22110k -c:a mp2 -format mpeg "%2" -loglevel quiet -stats -y
rem ffmpeg -i "%1" -c:v mpeg1video -q:v 0 -c:a mp2 -format mpeg "%2" -loglevel quiet -stats -y
rem ffmpeg -i "%1" -c:v mpeg1video -q:v 11 -c:a mp2 -format mpeg "%2" -y
ffmpeg -i "%1" -c:v mpeg1video -q:v 11 -b:v 1500k -c:a mp2 -format mpeg "%2" -y

