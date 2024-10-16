:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                   __  __               _                                  ::
::                  |  \/  | __ _  _ __  | |__  __ _                         ::
::                  | |\/| |/ _` || '  \ | '_ \/ _` |                        ::
::                  |_|  |_|\__,_||_|_|_||_.__/\__,_|                        ::
::                            Game Toolkit™                                  ::
::                                                                           ::
::               Copyright © 2024-present tinyBigGAMES™ LLC                  ::
::                        All Rights Reserved.                               ::
::                                                                           ::
::                  Website: https://tinybiggames.com                        ::
::                  Email  : support@tinybiggames.com                        ::
::                                                                           ::
::               See LICENSE file for license information                    ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
cd /d %~dp0
call brcc32.exe "resdata.rc" -v -fo..\..\Mamba.Deps.res
