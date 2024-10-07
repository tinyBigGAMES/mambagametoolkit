/****************************************************************************
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
****************************************************************************/


// Workaround for current Delphi when linking static .o files compiled
// by C++ Builder 12.2+. dcc64 does not handle well the case of .rdata
// section w/ nothing but unnamed symbols. Hopfully next update should fix
// the issue.
__attribute__((section(".rdata"), used)) int DummyNamedSymbol = 10;

//=== GLFW ==================================================================
#include "glfw\src\context.c"
#include "glfw\src\egl_context.c"
#include "glfw\src\init.c"
#include "glfw\src\input.c"
#include "glfw\src\monitor.c"
#include "glfw\src\osmesa_context.c"
#include "glfw\src\platform.c"
#include "glfw\src\vulkan.c"
#include "glfw\src\wgl_context.c"
#include "glfw\src\win32_init.c"
#include "glfw\src\win32_joystick.c"
#include "glfw\src\win32_module.c"
#include "glfw\src\win32_monitor.c"
#include "glfw\src\win32_thread.c"
#include "glfw\src\win32_time.c"
#include "glfw\src\win32_window.c"
#include "glfw\src\window.c"

//=== STB ===================================================================
#define STB_IMAGE_IMPLEMENTATION
#define STBI_NO_THREAD_LOCALS
#include "stb_image.h"

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

#define STB_RECT_PACK_IMPLEMENTATION
#include "stb_rect_pack.h"

#define STB_TRUETYPE_IMPLEMENTATION
#include "stb_truetype.h"

//==== CUTEHEADERS =========================================================
#define CUTE_C2_IMPLEMENTATION
#define CUTE_C2_API __attribute__((visibility("default")))
#include "cute_c2.h"

//==== MINIAUDIO ============================================================
#define STB_VORBIS_HEADER_ONLY
#include "stb_vorbis.c"    // Enables Vorbis decoding.

#define MINIAUDIO_IMPLEMENTATION
#include "miniaudio.h"

// The stb_vorbis implementation must come after the implementation of miniaudio.
#undef STB_VORBIS_HEADER_ONLY
#include "stb_vorbis.c"

//=== PL_MPEG ===============================================================
#define PL_MPEG_IMPLEMENTATION
#include "pl_mpeg.h"

//=== MINIZIP ===============================================================
#include "minizip\ioapi.c"
#include "minizip\iowin32.c"
#include "minizip\zip.c"
#include "minizip\unzip.c"





