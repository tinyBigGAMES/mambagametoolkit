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

unit Mamba.OpenGL;

{$I Mamba.Defines.inc}

interface

uses
  System.SysUtils,
  System.StrUtils,
  Mamba.Deps;

var
  glVersionMajor, glVersionMinor: integer;

type
  GLVULKANPROCNV = pointer;
  GLbitfield = uint32;
  GLboolean = byte;
  GLbyte = int8;
  GLchar = char;
  GLcharARB = byte;
  GLclampd = double;
  GLclampf = single;
  GLclampx = int32;
  GLdouble = double;
  GLeglClientBufferEXT = pointer;
  GLeglImageOES = pointer;
  GLenum = uint32;
  GLfixed = int32;
  GLfloat = single;
  GLhalf = uint16;
  GLhalfARB = uint16;
  GLhalfNV = uint16;
  GLhandleARB = uint32;
  GLint = int32;
  GLint64 = int64;
  GLint64EXT = int64;
  GLintptr = int32;
  GLintptrARB = int32;
  GLshort = int16;
  GLsizei = int32;
  GLsizeiptr = int32;
  GLsizeiptrARB = int32;
  GLsync = pointer;
  GLubyte = uint8;
  GLuint = uint32;
  GLuint64 = uint64;
  GLuint64EXT = uint64;
  GLushort = uint16;
  GLvdpauSurfaceNV = int32;
  GLvoid = pointer;
  _cl_context = pointer;
  _cl_event = pointer;

  PGLVULKANPROCNV = ^pointer;
  PGLbitfield = ^uint32;
  PGLboolean = ^byte;
  PGLbyte = ^int8;
  PGLchar = ^char;
  PGLcharARB = ^byte;
  PGLclampd = ^double;
  PGLclampf = ^single;
  PGLclampx = ^int32;
  PGLdouble = ^double;
  PGLeglClientBufferEXT = ^pointer;
  PGLeglImageOES = ^pointer;
  PGLenum = ^uint32;
  PGLfixed = ^int32;
  PGLfloat = ^single;
  PGLhalf = ^uint16;
  PGLhalfARB = ^uint16;
  PGLhalfNV = ^uint16;
  PGLhandleARB = ^uint32;
  PGLint = ^int32;
  PGLint64 = ^int64;
  PGLint64EXT = ^int64;
  PGLintptr = ^int32;
  PGLintptrARB = ^int32;
  PGLshort = ^int16;
  PGLsizei = ^int32;
  PGLsizeiptr = ^int32;
  PGLsizeiptrARB = ^int32;
  PGLsync = ^pointer;
  PGLubyte = ^uint8;
  PGLuint = ^uint32;
  PGLuint64 = ^uint64;
  PGLuint64EXT = ^uint64;
  PGLushort = ^uint16;
  PGLvdpauSurfaceNV = ^int32;
  PGLvoid = ^pointer;
  P_cl_context = ^pointer;
  P_cl_event = ^pointer;
  PPGLchar = ^PGLchar;
  PPGLcharARB = ^PGLcharARB;
  PPGLboolean = ^PGLboolean;

  GLdebugProc = procedure (
    source: GLenum;
    typ: GLenum;
    id: GLuint;
    severity: GLenum;
    length: GLsizei;
    message: PGLchar;
    userParam: pointer); stdcall;
  GLdebugProcArb = GLdebugProc;
  GLdebugProcKhr = GLdebugProc;

  GLdebugProcAmd = procedure (
    id: GLuint;
    category: GLenum;
    severity: GLenum;
    len: GLsizei;
    message: PGLchar;
    userParam: pointer); stdcall;

const
  GL_FALSE = 0;
  GL_INVALID_INDEX = uint32($FFFFFFFF);
  GL_NONE = 0;
  GL_NONE_OES = 0;
  GL_NO_ERROR = 0;
  GL_ONE = 1;
  GL_TIMEOUT_IGNORED = uint64($FFFFFFFFFFFFFFFF);
  GL_TIMEOUT_IGNORED_APPLE = uint64($FFFFFFFFFFFFFFFF);
  GL_TRUE = 1;
  GL_VERSION_ES_CL_1_0 = 1;
  GL_VERSION_ES_CL_1_1 = 1;
  GL_VERSION_ES_CM_1_1 = 1;
  GL_ZERO = 0;

  GL_DEPTH_BUFFER_BIT = $00000100;
  GL_STENCIL_BUFFER_BIT = $00000400;
  GL_COLOR_BUFFER_BIT = $00004000;
  GL_POINTS = $0000;
  GL_LINES = $0001;
  GL_LINE_LOOP = $0002;
  GL_LINE_STRIP = $0003;
  GL_TRIANGLES = $0004;
  GL_TRIANGLE_STRIP = $0005;
  GL_TRIANGLE_FAN = $0006;
  GL_QUADS = $0007;
  GL_NEVER = $0200;
  GL_LESS = $0201;
  GL_EQUAL = $0202;
  GL_LEQUAL = $0203;
  GL_GREATER = $0204;
  GL_NOTEQUAL = $0205;
  GL_GEQUAL = $0206;
  GL_ALWAYS = $0207;
  GL_SRC_COLOR = $0300;
  GL_ONE_MINUS_SRC_COLOR = $0301;
  GL_SRC_ALPHA = $0302;
  GL_ONE_MINUS_SRC_ALPHA = $0303;
  GL_DST_ALPHA = $0304;
  GL_ONE_MINUS_DST_ALPHA = $0305;
  GL_DST_COLOR = $0306;
  GL_ONE_MINUS_DST_COLOR = $0307;
  GL_SRC_ALPHA_SATURATE = $0308;
  GL_FRONT_LEFT = $0400;
  GL_FRONT_RIGHT = $0401;
  GL_BACK_LEFT = $0402;
  GL_BACK_RIGHT = $0403;
  GL_FRONT = $0404;
  GL_BACK = $0405;
  GL_LEFT = $0406;
  GL_RIGHT = $0407;
  GL_FRONT_AND_BACK = $0408;
  GL_INVALID_ENUM = $0500;
  GL_INVALID_VALUE = $0501;
  GL_INVALID_OPERATION = $0502;
  GL_OUT_OF_MEMORY = $0505;
  GL_CW = $0900;
  GL_CCW = $0901;
  GL_POINT_SIZE = $0B11;
  GL_POINT_SIZE_RANGE = $0B12;
  GL_POINT_SIZE_GRANULARITY = $0B13;
  GL_LINE_SMOOTH = $0B20;
  GL_LINE_WIDTH = $0B21;
  GL_LINE_WIDTH_RANGE = $0B22;
  GL_LINE_WIDTH_GRANULARITY = $0B23;
  GL_POLYGON_MODE = $0B40;
  GL_POLYGON_SMOOTH = $0B41;
  GL_CULL_FACE = $0B44;
  GL_CULL_FACE_MODE = $0B45;
  GL_FRONT_FACE = $0B46;
  GL_DEPTH_RANGE = $0B70;
  GL_DEPTH_TEST = $0B71;
  GL_DEPTH_WRITEMASK = $0B72;
  GL_DEPTH_CLEAR_VALUE = $0B73;
  GL_DEPTH_FUNC = $0B74;
  GL_STENCIL_TEST = $0B90;
  GL_STENCIL_CLEAR_VALUE = $0B91;
  GL_STENCIL_FUNC = $0B92;
  GL_STENCIL_VALUE_MASK = $0B93;
  GL_STENCIL_FAIL = $0B94;
  GL_STENCIL_PASS_DEPTH_FAIL = $0B95;
  GL_STENCIL_PASS_DEPTH_PASS = $0B96;
  GL_STENCIL_REF = $0B97;
  GL_STENCIL_WRITEMASK = $0B98;
  GL_VIEWPORT = $0BA2;
  GL_DITHER = $0BD0;
  GL_BLEND_DST = $0BE0;
  GL_BLEND_SRC = $0BE1;
  GL_BLEND = $0BE2;
  GL_LOGIC_OP_MODE = $0BF0;
  GL_DRAW_BUFFER = $0C01;
  GL_READ_BUFFER = $0C02;
  GL_SCISSOR_BOX = $0C10;
  GL_SCISSOR_TEST = $0C11;
  GL_COLOR_CLEAR_VALUE = $0C22;
  GL_COLOR_WRITEMASK = $0C23;
  GL_DOUBLEBUFFER = $0C32;
  GL_STEREO = $0C33;
  GL_LINE_SMOOTH_HINT = $0C52;
  GL_POLYGON_SMOOTH_HINT = $0C53;
  GL_UNPACK_SWAP_BYTES = $0CF0;
  GL_UNPACK_LSB_FIRST = $0CF1;
  GL_UNPACK_ROW_LENGTH = $0CF2;
  GL_UNPACK_SKIP_ROWS = $0CF3;
  GL_UNPACK_SKIP_PIXELS = $0CF4;
  GL_UNPACK_ALIGNMENT = $0CF5;
  GL_PACK_SWAP_BYTES = $0D00;
  GL_PACK_LSB_FIRST = $0D01;
  GL_PACK_ROW_LENGTH = $0D02;
  GL_PACK_SKIP_ROWS = $0D03;
  GL_PACK_SKIP_PIXELS = $0D04;
  GL_PACK_ALIGNMENT = $0D05;
  GL_MAX_TEXTURE_SIZE = $0D33;
  GL_MAX_VIEWPORT_DIMS = $0D3A;
  GL_SUBPIXEL_BITS = $0D50;
  GL_TEXTURE_1D = $0DE0;
  GL_TEXTURE_2D = $0DE1;
  GL_TEXTURE_WIDTH = $1000;
  GL_TEXTURE_HEIGHT = $1001;
  GL_TEXTURE_BORDER_COLOR = $1004;
  GL_DONT_CARE = $1100;
  GL_FASTEST = $1101;
  GL_NICEST = $1102;
  GL_BYTE = $1400;
  GL_UNSIGNED_BYTE = $1401;
  GL_SHORT = $1402;
  GL_UNSIGNED_SHORT = $1403;
  GL_INT = $1404;
  GL_UNSIGNED_INT = $1405;
  GL_FLOAT = $1406;
  GL_STACK_OVERFLOW = $0503;
  GL_STACK_UNDERFLOW = $0504;
  GL_CLEAR = $1500;
  GL_AND = $1501;
  GL_AND_REVERSE = $1502;
  GL_COPY = $1503;
  GL_AND_INVERTED = $1504;
  GL_NOOP = $1505;
  GL_XOR = $1506;
  GL_OR = $1507;
  GL_NOR = $1508;
  GL_EQUIV = $1509;
  GL_INVERT = $150A;
  GL_OR_REVERSE = $150B;
  GL_COPY_INVERTED = $150C;
  GL_OR_INVERTED = $150D;
  GL_NAND = $150E;
  GL_SET = $150F;
  GL_TEXTURE = $1702;
  GL_COLOR = $1800;
  GL_DEPTH = $1801;
  GL_STENCIL = $1802;
  GL_STENCIL_INDEX = $1901;
  GL_DEPTH_COMPONENT = $1902;
  GL_RED = $1903;
  GL_GREEN = $1904;
  GL_BLUE = $1905;
  GL_ALPHA = $1906;
  GL_RGB = $1907;
  GL_RGBA = $1908;
  GL_POINT = $1B00;
  GL_LINE = $1B01;
  GL_FILL = $1B02;
  GL_KEEP = $1E00;
  GL_REPLACE = $1E01;
  GL_INCR = $1E02;
  GL_DECR = $1E03;
  GL_VENDOR = $1F00;
  GL_RENDERER = $1F01;
  GL_VERSION = $1F02;
  GL_EXTENSIONS = $1F03;
  GL_NEAREST = $2600;
  GL_LINEAR = $2601;
  GL_NEAREST_MIPMAP_NEAREST = $2700;
  GL_LINEAR_MIPMAP_NEAREST = $2701;
  GL_NEAREST_MIPMAP_LINEAR = $2702;
  GL_LINEAR_MIPMAP_LINEAR = $2703;
  GL_TEXTURE_MAG_FILTER = $2800;
  GL_TEXTURE_MIN_FILTER = $2801;
  GL_TEXTURE_WRAP_S = $2802;
  GL_TEXTURE_WRAP_T = $2803;
  GL_REPEAT = $2901;
  GL_CURRENT_BIT = $00000001;
  GL_POINT_BIT = $00000002;
  GL_LINE_BIT = $00000004;
  GL_POLYGON_BIT = $00000008;
  GL_POLYGON_STIPPLE_BIT = $00000010;
  GL_PIXEL_MODE_BIT = $00000020;
  GL_LIGHTING_BIT = $00000040;
  GL_FOG_BIT = $00000080;
  GL_ACCUM_BUFFER_BIT = $00000200;
  GL_VIEWPORT_BIT = $00000800;
  GL_TRANSFORM_BIT = $00001000;
  GL_ENABLE_BIT = $00002000;
  GL_HINT_BIT = $00008000;
  GL_EVAL_BIT = $00010000;
  GL_LIST_BIT = $00020000;
  GL_TEXTURE_BIT = $00040000;
  GL_SCISSOR_BIT = $00080000;
  GL_ALL_ATTRIB_BITS = $FFFFFFFF;
  GL_QUAD_STRIP = $0008;
  GL_POLYGON = $0009;
  GL_ACCUM = $0100;
  GL_LOAD = $0101;
  GL_RETURN = $0102;
  GL_MULT = $0103;
  GL_ADD = $0104;
  GL_AUX0 = $0409;
  GL_AUX1 = $040A;
  GL_AUX2 = $040B;
  GL_AUX3 = $040C;
  GL_2D = $0600;
  GL_3D = $0601;
  GL_3D_COLOR = $0602;
  GL_3D_COLOR_TEXTURE = $0603;
  GL_4D_COLOR_TEXTURE = $0604;
  GL_PASS_THROUGH_TOKEN = $0700;
  GL_POINT_TOKEN = $0701;
  GL_LINE_TOKEN = $0702;
  GL_POLYGON_TOKEN = $0703;
  GL_BITMAP_TOKEN = $0704;
  GL_DRAW_PIXEL_TOKEN = $0705;
  GL_COPY_PIXEL_TOKEN = $0706;
  GL_LINE_RESET_TOKEN = $0707;
  GL_EXP = $0800;
  GL_EXP2 = $0801;
  GL_COEFF = $0A00;
  GL_ORDER = $0A01;
  GL_DOMAIN = $0A02;
  GL_PIXEL_MAP_I_TO_I = $0C70;
  GL_PIXEL_MAP_S_TO_S = $0C71;
  GL_PIXEL_MAP_I_TO_R = $0C72;
  GL_PIXEL_MAP_I_TO_G = $0C73;
  GL_PIXEL_MAP_I_TO_B = $0C74;
  GL_PIXEL_MAP_I_TO_A = $0C75;
  GL_PIXEL_MAP_R_TO_R = $0C76;
  GL_PIXEL_MAP_G_TO_G = $0C77;
  GL_PIXEL_MAP_B_TO_B = $0C78;
  GL_PIXEL_MAP_A_TO_A = $0C79;
  GL_CURRENT_COLOR = $0B00;
  GL_CURRENT_INDEX = $0B01;
  GL_CURRENT_NORMAL = $0B02;
  GL_CURRENT_TEXTURE_COORDS = $0B03;
  GL_CURRENT_RASTER_COLOR = $0B04;
  GL_CURRENT_RASTER_INDEX = $0B05;
  GL_CURRENT_RASTER_TEXTURE_COORDS = $0B06;
  GL_CURRENT_RASTER_POSITION = $0B07;
  GL_CURRENT_RASTER_POSITION_VALID = $0B08;
  GL_CURRENT_RASTER_DISTANCE = $0B09;
  GL_POINT_SMOOTH = $0B10;
  GL_LINE_STIPPLE = $0B24;
  GL_LINE_STIPPLE_PATTERN = $0B25;
  GL_LINE_STIPPLE_REPEAT = $0B26;
  GL_LIST_MODE = $0B30;
  GL_MAX_LIST_NESTING = $0B31;
  GL_LIST_BASE = $0B32;
  GL_LIST_INDEX = $0B33;
  GL_POLYGON_STIPPLE = $0B42;
  GL_EDGE_FLAG = $0B43;
  GL_LIGHTING = $0B50;
  GL_LIGHT_MODEL_LOCAL_VIEWER = $0B51;
  GL_LIGHT_MODEL_TWO_SIDE = $0B52;
  GL_LIGHT_MODEL_AMBIENT = $0B53;
  GL_SHADE_MODEL = $0B54;
  GL_COLOR_MATERIAL_FACE = $0B55;
  GL_COLOR_MATERIAL_PARAMETER = $0B56;
  GL_COLOR_MATERIAL = $0B57;
  GL_FOG = $0B60;
  GL_FOG_INDEX = $0B61;
  GL_FOG_DENSITY = $0B62;
  GL_FOG_START = $0B63;
  GL_FOG_END = $0B64;
  GL_FOG_MODE = $0B65;
  GL_FOG_COLOR = $0B66;
  GL_ACCUM_CLEAR_VALUE = $0B80;
  GL_MATRIX_MODE = $0BA0;
  GL_NORMALIZE = $0BA1;
  GL_MODELVIEW_STACK_DEPTH = $0BA3;
  GL_PROJECTION_STACK_DEPTH = $0BA4;
  GL_TEXTURE_STACK_DEPTH = $0BA5;
  GL_MODELVIEW_MATRIX = $0BA6;
  GL_PROJECTION_MATRIX = $0BA7;
  GL_TEXTURE_MATRIX = $0BA8;
  GL_ATTRIB_STACK_DEPTH = $0BB0;
  GL_ALPHA_TEST = $0BC0;
  GL_ALPHA_TEST_FUNC = $0BC1;
  GL_ALPHA_TEST_REF = $0BC2;
  GL_LOGIC_OP = $0BF1;
  GL_AUX_BUFFERS = $0C00;
  GL_INDEX_CLEAR_VALUE = $0C20;
  GL_INDEX_WRITEMASK = $0C21;
  GL_INDEX_MODE = $0C30;
  GL_RGBA_MODE = $0C31;
  GL_RENDER_MODE = $0C40;
  GL_PERSPECTIVE_CORRECTION_HINT = $0C50;
  GL_POINT_SMOOTH_HINT = $0C51;
  GL_FOG_HINT = $0C54;
  GL_TEXTURE_GEN_S = $0C60;
  GL_TEXTURE_GEN_T = $0C61;
  GL_TEXTURE_GEN_R = $0C62;
  GL_TEXTURE_GEN_Q = $0C63;
  GL_PIXEL_MAP_I_TO_I_SIZE = $0CB0;
  GL_PIXEL_MAP_S_TO_S_SIZE = $0CB1;
  GL_PIXEL_MAP_I_TO_R_SIZE = $0CB2;
  GL_PIXEL_MAP_I_TO_G_SIZE = $0CB3;
  GL_PIXEL_MAP_I_TO_B_SIZE = $0CB4;
  GL_PIXEL_MAP_I_TO_A_SIZE = $0CB5;
  GL_PIXEL_MAP_R_TO_R_SIZE = $0CB6;
  GL_PIXEL_MAP_G_TO_G_SIZE = $0CB7;
  GL_PIXEL_MAP_B_TO_B_SIZE = $0CB8;
  GL_PIXEL_MAP_A_TO_A_SIZE = $0CB9;
  GL_MAP_COLOR = $0D10;
  GL_MAP_STENCIL = $0D11;
  GL_INDEX_SHIFT = $0D12;
  GL_INDEX_OFFSET = $0D13;
  GL_RED_SCALE = $0D14;
  GL_RED_BIAS = $0D15;
  GL_ZOOM_X = $0D16;
  GL_ZOOM_Y = $0D17;
  GL_GREEN_SCALE = $0D18;
  GL_GREEN_BIAS = $0D19;
  GL_BLUE_SCALE = $0D1A;
  GL_BLUE_BIAS = $0D1B;
  GL_ALPHA_SCALE = $0D1C;
  GL_ALPHA_BIAS = $0D1D;
  GL_DEPTH_SCALE = $0D1E;
  GL_DEPTH_BIAS = $0D1F;
  GL_MAX_EVAL_ORDER = $0D30;
  GL_MAX_LIGHTS = $0D31;
  GL_MAX_CLIP_PLANES = $0D32;
  GL_MAX_PIXEL_MAP_TABLE = $0D34;
  GL_MAX_ATTRIB_STACK_DEPTH = $0D35;
  GL_MAX_MODELVIEW_STACK_DEPTH = $0D36;
  GL_MAX_NAME_STACK_DEPTH = $0D37;
  GL_MAX_PROJECTION_STACK_DEPTH = $0D38;
  GL_MAX_TEXTURE_STACK_DEPTH = $0D39;
  GL_INDEX_BITS = $0D51;
  GL_RED_BITS = $0D52;
  GL_GREEN_BITS = $0D53;
  GL_BLUE_BITS = $0D54;
  GL_ALPHA_BITS = $0D55;
  GL_DEPTH_BITS = $0D56;
  GL_STENCIL_BITS = $0D57;
  GL_ACCUM_RED_BITS = $0D58;
  GL_ACCUM_GREEN_BITS = $0D59;
  GL_ACCUM_BLUE_BITS = $0D5A;
  GL_ACCUM_ALPHA_BITS = $0D5B;
  GL_NAME_STACK_DEPTH = $0D70;
  GL_AUTO_NORMAL = $0D80;
  GL_MAP1_COLOR_4 = $0D90;
  GL_MAP1_INDEX = $0D91;
  GL_MAP1_NORMAL = $0D92;
  GL_MAP1_TEXTURE_COORD_1 = $0D93;
  GL_MAP1_TEXTURE_COORD_2 = $0D94;
  GL_MAP1_TEXTURE_COORD_3 = $0D95;
  GL_MAP1_TEXTURE_COORD_4 = $0D96;
  GL_MAP1_VERTEX_3 = $0D97;
  GL_MAP1_VERTEX_4 = $0D98;
  GL_MAP2_COLOR_4 = $0DB0;
  GL_MAP2_INDEX = $0DB1;
  GL_MAP2_NORMAL = $0DB2;
  GL_MAP2_TEXTURE_COORD_1 = $0DB3;
  GL_MAP2_TEXTURE_COORD_2 = $0DB4;
  GL_MAP2_TEXTURE_COORD_3 = $0DB5;
  GL_MAP2_TEXTURE_COORD_4 = $0DB6;
  GL_MAP2_VERTEX_3 = $0DB7;
  GL_MAP2_VERTEX_4 = $0DB8;
  GL_MAP1_GRID_DOMAIN = $0DD0;
  GL_MAP1_GRID_SEGMENTS = $0DD1;
  GL_MAP2_GRID_DOMAIN = $0DD2;
  GL_MAP2_GRID_SEGMENTS = $0DD3;
  GL_TEXTURE_COMPONENTS = $1003;
  GL_TEXTURE_BORDER = $1005;
  GL_AMBIENT = $1200;
  GL_DIFFUSE = $1201;
  GL_SPECULAR = $1202;
  GL_POSITION = $1203;
  GL_SPOT_DIRECTION = $1204;
  GL_SPOT_EXPONENT = $1205;
  GL_SPOT_CUTOFF = $1206;
  GL_CONSTANT_ATTENUATION = $1207;
  GL_LINEAR_ATTENUATION = $1208;
  GL_QUADRATIC_ATTENUATION = $1209;
  GL_COMPILE = $1300;
  GL_COMPILE_AND_EXECUTE = $1301;
  GL_2_BYTES = $1407;
  GL_3_BYTES = $1408;
  GL_4_BYTES = $1409;
  GL_EMISSION = $1600;
  GL_SHININESS = $1601;
  GL_AMBIENT_AND_DIFFUSE = $1602;
  GL_COLOR_INDEXES = $1603;
  GL_MODELVIEW = $1700;
  GL_PROJECTION = $1701;
  GL_COLOR_INDEX = $1900;
  GL_LUMINANCE = $1909;
  GL_LUMINANCE_ALPHA = $190A;
  GL_BITMAP = $1A00;
  GL_RENDER = $1C00;
  GL_FEEDBACK = $1C01;
  GL_SELECT = $1C02;
  GL_FLAT = $1D00;
  GL_SMOOTH = $1D01;
  GL_S = $2000;
  GL_T = $2001;
  GL_R = $2002;
  GL_Q = $2003;
  GL_MODULATE = $2100;
  GL_DECAL = $2101;
  GL_TEXTURE_ENV_MODE = $2200;
  GL_TEXTURE_ENV_COLOR = $2201;
  GL_TEXTURE_ENV = $2300;
  GL_EYE_LINEAR = $2400;
  GL_OBJECT_LINEAR = $2401;
  GL_SPHERE_MAP = $2402;
  GL_TEXTURE_GEN_MODE = $2500;
  GL_OBJECT_PLANE = $2501;
  GL_EYE_PLANE = $2502;
  GL_CLAMP = $2900;
  GL_CLIP_PLANE0 = $3000;
  GL_CLIP_PLANE1 = $3001;
  GL_CLIP_PLANE2 = $3002;
  GL_CLIP_PLANE3 = $3003;
  GL_CLIP_PLANE4 = $3004;
  GL_CLIP_PLANE5 = $3005;
  GL_LIGHT0 = $4000;
  GL_LIGHT1 = $4001;
  GL_LIGHT2 = $4002;
  GL_LIGHT3 = $4003;
  GL_LIGHT4 = $4004;
  GL_LIGHT5 = $4005;
  GL_LIGHT6 = $4006;
  GL_LIGHT7 = $4007;
  GL_COLOR_LOGIC_OP = $0BF2;
  GL_POLYGON_OFFSET_UNITS = $2A00;
  GL_POLYGON_OFFSET_POINT = $2A01;
  GL_POLYGON_OFFSET_LINE = $2A02;
  GL_POLYGON_OFFSET_FILL = $8037;
  GL_POLYGON_OFFSET_FACTOR = $8038;
  GL_TEXTURE_BINDING_1D = $8068;
  GL_TEXTURE_BINDING_2D = $8069;
  GL_TEXTURE_INTERNAL_FORMAT = $1003;
  GL_TEXTURE_RED_SIZE = $805C;
  GL_TEXTURE_GREEN_SIZE = $805D;
  GL_TEXTURE_BLUE_SIZE = $805E;
  GL_TEXTURE_ALPHA_SIZE = $805F;
  GL_DOUBLE = $140A;
  GL_PROXY_TEXTURE_1D = $8063;
  GL_PROXY_TEXTURE_2D = $8064;
  GL_R3_G3_B2 = $2A10;
  GL_RGB4 = $804F;
  GL_RGB5 = $8050;
  GL_RGB8 = $8051;
  GL_RGB10 = $8052;
  GL_RGB12 = $8053;
  GL_RGB16 = $8054;
  GL_RGBA2 = $8055;
  GL_RGBA4 = $8056;
  GL_RGB5_A1 = $8057;
  GL_RGBA8 = $8058;
  GL_RGB10_A2 = $8059;
  GL_RGBA12 = $805A;
  GL_RGBA16 = $805B;
  GL_CLIENT_PIXEL_STORE_BIT = $00000001;
  GL_CLIENT_VERTEX_ARRAY_BIT = $00000002;
  GL_CLIENT_ALL_ATTRIB_BITS = $FFFFFFFF;
  GL_VERTEX_ARRAY_POINTER = $808E;
  GL_NORMAL_ARRAY_POINTER = $808F;
  GL_COLOR_ARRAY_POINTER = $8090;
  GL_INDEX_ARRAY_POINTER = $8091;
  GL_TEXTURE_COORD_ARRAY_POINTER = $8092;
  GL_EDGE_FLAG_ARRAY_POINTER = $8093;
  GL_FEEDBACK_BUFFER_POINTER = $0DF0;
  GL_SELECTION_BUFFER_POINTER = $0DF3;
  GL_CLIENT_ATTRIB_STACK_DEPTH = $0BB1;
  GL_INDEX_LOGIC_OP = $0BF1;
  GL_MAX_CLIENT_ATTRIB_STACK_DEPTH = $0D3B;
  GL_FEEDBACK_BUFFER_SIZE = $0DF1;
  GL_FEEDBACK_BUFFER_TYPE = $0DF2;
  GL_SELECTION_BUFFER_SIZE = $0DF4;
  GL_VERTEX_ARRAY = $8074;
  GL_NORMAL_ARRAY = $8075;
  GL_COLOR_ARRAY = $8076;
  GL_INDEX_ARRAY = $8077;
  GL_TEXTURE_COORD_ARRAY = $8078;
  GL_EDGE_FLAG_ARRAY = $8079;
  GL_VERTEX_ARRAY_SIZE = $807A;
  GL_VERTEX_ARRAY_TYPE = $807B;
  GL_VERTEX_ARRAY_STRIDE = $807C;
  GL_NORMAL_ARRAY_TYPE = $807E;
  GL_NORMAL_ARRAY_STRIDE = $807F;
  GL_COLOR_ARRAY_SIZE = $8081;
  GL_COLOR_ARRAY_TYPE = $8082;
  GL_COLOR_ARRAY_STRIDE = $8083;
  GL_INDEX_ARRAY_TYPE = $8085;
  GL_INDEX_ARRAY_STRIDE = $8086;
  GL_TEXTURE_COORD_ARRAY_SIZE = $8088;
  GL_TEXTURE_COORD_ARRAY_TYPE = $8089;
  GL_TEXTURE_COORD_ARRAY_STRIDE = $808A;
  GL_EDGE_FLAG_ARRAY_STRIDE = $808C;
  GL_TEXTURE_LUMINANCE_SIZE = $8060;
  GL_TEXTURE_INTENSITY_SIZE = $8061;
  GL_TEXTURE_PRIORITY = $8066;
  GL_TEXTURE_RESIDENT = $8067;
  GL_ALPHA4 = $803B;
  GL_ALPHA8 = $803C;
  GL_ALPHA12 = $803D;
  GL_ALPHA16 = $803E;
  GL_LUMINANCE4 = $803F;
  GL_LUMINANCE8 = $8040;
  GL_LUMINANCE12 = $8041;
  GL_LUMINANCE16 = $8042;
  GL_LUMINANCE4_ALPHA4 = $8043;
  GL_LUMINANCE6_ALPHA2 = $8044;
  GL_LUMINANCE8_ALPHA8 = $8045;
  GL_LUMINANCE12_ALPHA4 = $8046;
  GL_LUMINANCE12_ALPHA12 = $8047;
  GL_LUMINANCE16_ALPHA16 = $8048;
  GL_INTENSITY = $8049;
  GL_INTENSITY4 = $804A;
  GL_INTENSITY8 = $804B;
  GL_INTENSITY12 = $804C;
  GL_INTENSITY16 = $804D;
  GL_V2F = $2A20;
  GL_V3F = $2A21;
  GL_C4UB_V2F = $2A22;
  GL_C4UB_V3F = $2A23;
  GL_C3F_V3F = $2A24;
  GL_N3F_V3F = $2A25;
  GL_C4F_N3F_V3F = $2A26;
  GL_T2F_V3F = $2A27;
  GL_T4F_V4F = $2A28;
  GL_T2F_C4UB_V3F = $2A29;
  GL_T2F_C3F_V3F = $2A2A;
  GL_T2F_N3F_V3F = $2A2B;
  GL_T2F_C4F_N3F_V3F = $2A2C;
  GL_T4F_C4F_N3F_V4F = $2A2D;
  GL_UNSIGNED_BYTE_3_3_2 = $8032;
  GL_UNSIGNED_SHORT_4_4_4_4 = $8033;
  GL_UNSIGNED_SHORT_5_5_5_1 = $8034;
  GL_UNSIGNED_INT_8_8_8_8 = $8035;
  GL_UNSIGNED_INT_10_10_10_2 = $8036;
  GL_TEXTURE_BINDING_3D = $806A;
  GL_PACK_SKIP_IMAGES = $806B;
  GL_PACK_IMAGE_HEIGHT = $806C;
  GL_UNPACK_SKIP_IMAGES = $806D;
  GL_UNPACK_IMAGE_HEIGHT = $806E;
  GL_TEXTURE_3D = $806F;
  GL_PROXY_TEXTURE_3D = $8070;
  GL_TEXTURE_DEPTH = $8071;
  GL_TEXTURE_WRAP_R = $8072;
  GL_MAX_3D_TEXTURE_SIZE = $8073;
  GL_UNSIGNED_BYTE_2_3_3_REV = $8362;
  GL_UNSIGNED_SHORT_5_6_5 = $8363;
  GL_UNSIGNED_SHORT_5_6_5_REV = $8364;
  GL_UNSIGNED_SHORT_4_4_4_4_REV = $8365;
  GL_UNSIGNED_SHORT_1_5_5_5_REV = $8366;
  GL_UNSIGNED_INT_8_8_8_8_REV = $8367;
  GL_UNSIGNED_INT_2_10_10_10_REV = $8368;
  GL_BGR = $80E0;
  GL_BGRA = $80E1;
  GL_MAX_ELEMENTS_VERTICES = $80E8;
  GL_MAX_ELEMENTS_INDICES = $80E9;
  GL_CLAMP_TO_EDGE = $812F;
  GL_TEXTURE_MIN_LOD = $813A;
  GL_TEXTURE_MAX_LOD = $813B;
  GL_TEXTURE_BASE_LEVEL = $813C;
  GL_TEXTURE_MAX_LEVEL = $813D;
  GL_SMOOTH_POINT_SIZE_RANGE = $0B12;
  GL_SMOOTH_POINT_SIZE_GRANULARITY = $0B13;
  GL_SMOOTH_LINE_WIDTH_RANGE = $0B22;
  GL_SMOOTH_LINE_WIDTH_GRANULARITY = $0B23;
  GL_ALIASED_LINE_WIDTH_RANGE = $846E;
  GL_RESCALE_NORMAL = $803A;
  GL_LIGHT_MODEL_COLOR_CONTROL = $81F8;
  GL_SINGLE_COLOR = $81F9;
  GL_SEPARATE_SPECULAR_COLOR = $81FA;
  GL_ALIASED_POINT_SIZE_RANGE = $846D;
  GL_TEXTURE0 = $84C0;
  GL_TEXTURE1 = $84C1;
  GL_TEXTURE2 = $84C2;
  GL_TEXTURE3 = $84C3;
  GL_TEXTURE4 = $84C4;
  GL_TEXTURE5 = $84C5;
  GL_TEXTURE6 = $84C6;
  GL_TEXTURE7 = $84C7;
  GL_TEXTURE8 = $84C8;
  GL_TEXTURE9 = $84C9;
  GL_TEXTURE10 = $84CA;
  GL_TEXTURE11 = $84CB;
  GL_TEXTURE12 = $84CC;
  GL_TEXTURE13 = $84CD;
  GL_TEXTURE14 = $84CE;
  GL_TEXTURE15 = $84CF;
  GL_TEXTURE16 = $84D0;
  GL_TEXTURE17 = $84D1;
  GL_TEXTURE18 = $84D2;
  GL_TEXTURE19 = $84D3;
  GL_TEXTURE20 = $84D4;
  GL_TEXTURE21 = $84D5;
  GL_TEXTURE22 = $84D6;
  GL_TEXTURE23 = $84D7;
  GL_TEXTURE24 = $84D8;
  GL_TEXTURE25 = $84D9;
  GL_TEXTURE26 = $84DA;
  GL_TEXTURE27 = $84DB;
  GL_TEXTURE28 = $84DC;
  GL_TEXTURE29 = $84DD;
  GL_TEXTURE30 = $84DE;
  GL_TEXTURE31 = $84DF;
  GL_ACTIVE_TEXTURE = $84E0;
  GL_MULTISAMPLE = $809D;
  GL_SAMPLE_ALPHA_TO_COVERAGE = $809E;
  GL_SAMPLE_ALPHA_TO_ONE = $809F;
  GL_SAMPLE_COVERAGE = $80A0;
  GL_SAMPLE_BUFFERS = $80A8;
  GL_SAMPLES = $80A9;
  GL_SAMPLE_COVERAGE_VALUE = $80AA;
  GL_SAMPLE_COVERAGE_INVERT = $80AB;
  GL_TEXTURE_CUBE_MAP = $8513;
  GL_TEXTURE_BINDING_CUBE_MAP = $8514;
  GL_TEXTURE_CUBE_MAP_POSITIVE_X = $8515;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X = $8516;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y = $8517;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y = $8518;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z = $8519;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z = $851A;
  GL_PROXY_TEXTURE_CUBE_MAP = $851B;
  GL_MAX_CUBE_MAP_TEXTURE_SIZE = $851C;
  GL_COMPRESSED_RGB = $84ED;
  GL_COMPRESSED_RGBA = $84EE;
  GL_TEXTURE_COMPRESSION_HINT = $84EF;
  GL_TEXTURE_COMPRESSED_IMAGE_SIZE = $86A0;
  GL_TEXTURE_COMPRESSED = $86A1;
  GL_NUM_COMPRESSED_TEXTURE_FORMATS = $86A2;
  GL_COMPRESSED_TEXTURE_FORMATS = $86A3;
  GL_CLAMP_TO_BORDER = $812D;
  GL_CLIENT_ACTIVE_TEXTURE = $84E1;
  GL_MAX_TEXTURE_UNITS = $84E2;
  GL_TRANSPOSE_MODELVIEW_MATRIX = $84E3;
  GL_TRANSPOSE_PROJECTION_MATRIX = $84E4;
  GL_TRANSPOSE_TEXTURE_MATRIX = $84E5;
  GL_TRANSPOSE_COLOR_MATRIX = $84E6;
  GL_MULTISAMPLE_BIT = $20000000;
  GL_NORMAL_MAP = $8511;
  GL_REFLECTION_MAP = $8512;
  GL_COMPRESSED_ALPHA = $84E9;
  GL_COMPRESSED_LUMINANCE = $84EA;
  GL_COMPRESSED_LUMINANCE_ALPHA = $84EB;
  GL_COMPRESSED_INTENSITY = $84EC;
  GL_COMBINE = $8570;
  GL_COMBINE_RGB = $8571;
  GL_COMBINE_ALPHA = $8572;
  GL_SOURCE0_RGB = $8580;
  GL_SOURCE1_RGB = $8581;
  GL_SOURCE2_RGB = $8582;
  GL_SOURCE0_ALPHA = $8588;
  GL_SOURCE1_ALPHA = $8589;
  GL_SOURCE2_ALPHA = $858A;
  GL_OPERAND0_RGB = $8590;
  GL_OPERAND1_RGB = $8591;
  GL_OPERAND2_RGB = $8592;
  GL_OPERAND0_ALPHA = $8598;
  GL_OPERAND1_ALPHA = $8599;
  GL_OPERAND2_ALPHA = $859A;
  GL_RGB_SCALE = $8573;
  GL_ADD_SIGNED = $8574;
  GL_INTERPOLATE = $8575;
  GL_SUBTRACT = $84E7;
  GL_CONSTANT = $8576;
  GL_PRIMARY_COLOR = $8577;
  GL_PREVIOUS = $8578;
  GL_DOT3_RGB = $86AE;
  GL_DOT3_RGBA = $86AF;
  GL_BLEND_DST_RGB = $80C8;
  GL_BLEND_SRC_RGB = $80C9;
  GL_BLEND_DST_ALPHA = $80CA;
  GL_BLEND_SRC_ALPHA = $80CB;
  GL_POINT_FADE_THRESHOLD_SIZE = $8128;
  GL_DEPTH_COMPONENT16 = $81A5;
  GL_DEPTH_COMPONENT24 = $81A6;
  GL_DEPTH_COMPONENT32 = $81A7;
  GL_MIRRORED_REPEAT = $8370;
  GL_MAX_TEXTURE_LOD_BIAS = $84FD;
  GL_TEXTURE_LOD_BIAS = $8501;
  GL_INCR_WRAP = $8507;
  GL_DECR_WRAP = $8508;
  GL_TEXTURE_DEPTH_SIZE = $884A;
  GL_TEXTURE_COMPARE_MODE = $884C;
  GL_TEXTURE_COMPARE_FUNC = $884D;
  GL_POINT_SIZE_MIN = $8126;
  GL_POINT_SIZE_MAX = $8127;
  GL_POINT_DISTANCE_ATTENUATION = $8129;
  GL_GENERATE_MIPMAP = $8191;
  GL_GENERATE_MIPMAP_HINT = $8192;
  GL_FOG_COORDINATE_SOURCE = $8450;
  GL_FOG_COORDINATE = $8451;
  GL_FRAGMENT_DEPTH = $8452;
  GL_CURRENT_FOG_COORDINATE = $8453;
  GL_FOG_COORDINATE_ARRAY_TYPE = $8454;
  GL_FOG_COORDINATE_ARRAY_STRIDE = $8455;
  GL_FOG_COORDINATE_ARRAY_POINTER = $8456;
  GL_FOG_COORDINATE_ARRAY = $8457;
  GL_COLOR_SUM = $8458;
  GL_CURRENT_SECONDARY_COLOR = $8459;
  GL_SECONDARY_COLOR_ARRAY_SIZE = $845A;
  GL_SECONDARY_COLOR_ARRAY_TYPE = $845B;
  GL_SECONDARY_COLOR_ARRAY_STRIDE = $845C;
  GL_SECONDARY_COLOR_ARRAY_POINTER = $845D;
  GL_SECONDARY_COLOR_ARRAY = $845E;
  GL_TEXTURE_FILTER_CONTROL = $8500;
  GL_DEPTH_TEXTURE_MODE = $884B;
  GL_COMPARE_R_TO_TEXTURE = $884E;
  GL_BLEND_COLOR = $8005;
  GL_BLEND_EQUATION = $8009;
  GL_CONSTANT_COLOR = $8001;
  GL_ONE_MINUS_CONSTANT_COLOR = $8002;
  GL_CONSTANT_ALPHA = $8003;
  GL_ONE_MINUS_CONSTANT_ALPHA = $8004;
  GL_FUNC_ADD = $8006;
  GL_FUNC_REVERSE_SUBTRACT = $800B;
  GL_FUNC_SUBTRACT = $800A;
  GL_MIN = $8007;
  GL_MAX = $8008;
  GL_BUFFER_SIZE = $8764;
  GL_BUFFER_USAGE = $8765;
  GL_QUERY_COUNTER_BITS = $8864;
  GL_CURRENT_QUERY = $8865;
  GL_QUERY_RESULT = $8866;
  GL_QUERY_RESULT_AVAILABLE = $8867;
  GL_ARRAY_BUFFER = $8892;
  GL_ELEMENT_ARRAY_BUFFER = $8893;
  GL_ARRAY_BUFFER_BINDING = $8894;
  GL_ELEMENT_ARRAY_BUFFER_BINDING = $8895;
  GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = $889F;
  GL_READ_ONLY = $88B8;
  GL_WRITE_ONLY = $88B9;
  GL_READ_WRITE = $88BA;
  GL_BUFFER_ACCESS = $88BB;
  GL_BUFFER_MAPPED = $88BC;
  GL_BUFFER_MAP_POINTER = $88BD;
  GL_STREAM_DRAW = $88E0;
  GL_STREAM_READ = $88E1;
  GL_STREAM_COPY = $88E2;
  GL_STATIC_DRAW = $88E4;
  GL_STATIC_READ = $88E5;
  GL_STATIC_COPY = $88E6;
  GL_DYNAMIC_DRAW = $88E8;
  GL_DYNAMIC_READ = $88E9;
  GL_DYNAMIC_COPY = $88EA;
  GL_SAMPLES_PASSED = $8914;
  GL_SRC1_ALPHA = $8589;
  GL_VERTEX_ARRAY_BUFFER_BINDING = $8896;
  GL_NORMAL_ARRAY_BUFFER_BINDING = $8897;
  GL_COLOR_ARRAY_BUFFER_BINDING = $8898;
  GL_INDEX_ARRAY_BUFFER_BINDING = $8899;
  GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING = $889A;
  GL_EDGE_FLAG_ARRAY_BUFFER_BINDING = $889B;
  GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING = $889C;
  GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING = $889D;
  GL_WEIGHT_ARRAY_BUFFER_BINDING = $889E;
  GL_FOG_COORD_SRC = $8450;
  GL_FOG_COORD = $8451;
  GL_CURRENT_FOG_COORD = $8453;
  GL_FOG_COORD_ARRAY_TYPE = $8454;
  GL_FOG_COORD_ARRAY_STRIDE = $8455;
  GL_FOG_COORD_ARRAY_POINTER = $8456;
  GL_FOG_COORD_ARRAY = $8457;
  GL_FOG_COORD_ARRAY_BUFFER_BINDING = $889D;
  GL_SRC0_RGB = $8580;
  GL_SRC1_RGB = $8581;
  GL_SRC2_RGB = $8582;
  GL_SRC0_ALPHA = $8588;
  GL_SRC2_ALPHA = $858A;
  GL_BLEND_EQUATION_RGB = $8009;
  GL_VERTEX_ATTRIB_ARRAY_ENABLED = $8622;
  GL_VERTEX_ATTRIB_ARRAY_SIZE = $8623;
  GL_VERTEX_ATTRIB_ARRAY_STRIDE = $8624;
  GL_VERTEX_ATTRIB_ARRAY_TYPE = $8625;
  GL_CURRENT_VERTEX_ATTRIB = $8626;
  GL_VERTEX_PROGRAM_POINT_SIZE = $8642;
  GL_VERTEX_ATTRIB_ARRAY_POINTER = $8645;
  GL_STENCIL_BACK_FUNC = $8800;
  GL_STENCIL_BACK_FAIL = $8801;
  GL_STENCIL_BACK_PASS_DEPTH_FAIL = $8802;
  GL_STENCIL_BACK_PASS_DEPTH_PASS = $8803;
  GL_MAX_DRAW_BUFFERS = $8824;
  GL_DRAW_BUFFER0 = $8825;
  GL_DRAW_BUFFER1 = $8826;
  GL_DRAW_BUFFER2 = $8827;
  GL_DRAW_BUFFER3 = $8828;
  GL_DRAW_BUFFER4 = $8829;
  GL_DRAW_BUFFER5 = $882A;
  GL_DRAW_BUFFER6 = $882B;
  GL_DRAW_BUFFER7 = $882C;
  GL_DRAW_BUFFER8 = $882D;
  GL_DRAW_BUFFER9 = $882E;
  GL_DRAW_BUFFER10 = $882F;
  GL_DRAW_BUFFER11 = $8830;
  GL_DRAW_BUFFER12 = $8831;
  GL_DRAW_BUFFER13 = $8832;
  GL_DRAW_BUFFER14 = $8833;
  GL_DRAW_BUFFER15 = $8834;
  GL_BLEND_EQUATION_ALPHA = $883D;
  GL_MAX_VERTEX_ATTRIBS = $8869;
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED = $886A;
  GL_MAX_TEXTURE_IMAGE_UNITS = $8872;
  GL_FRAGMENT_SHADER = $8B30;
  GL_VERTEX_SHADER = $8B31;
  GL_MAX_FRAGMENT_UNIFORM_COMPONENTS = $8B49;
  GL_MAX_VERTEX_UNIFORM_COMPONENTS = $8B4A;
  GL_MAX_VARYING_FLOATS = $8B4B;
  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS = $8B4C;
  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS = $8B4D;
  GL_SHADER_TYPE = $8B4F;
  GL_FLOAT_VEC2 = $8B50;
  GL_FLOAT_VEC3 = $8B51;
  GL_FLOAT_VEC4 = $8B52;
  GL_INT_VEC2 = $8B53;
  GL_INT_VEC3 = $8B54;
  GL_INT_VEC4 = $8B55;
  GL_BOOL = $8B56;
  GL_BOOL_VEC2 = $8B57;
  GL_BOOL_VEC3 = $8B58;
  GL_BOOL_VEC4 = $8B59;
  GL_FLOAT_MAT2 = $8B5A;
  GL_FLOAT_MAT3 = $8B5B;
  GL_FLOAT_MAT4 = $8B5C;
  GL_SAMPLER_1D = $8B5D;
  GL_SAMPLER_2D = $8B5E;
  GL_SAMPLER_3D = $8B5F;
  GL_SAMPLER_CUBE = $8B60;
  GL_SAMPLER_1D_SHADOW = $8B61;
  GL_SAMPLER_2D_SHADOW = $8B62;
  GL_DELETE_STATUS = $8B80;
  GL_COMPILE_STATUS = $8B81;
  GL_LINK_STATUS = $8B82;
  GL_VALIDATE_STATUS = $8B83;
  GL_INFO_LOG_LENGTH = $8B84;
  GL_ATTACHED_SHADERS = $8B85;
  GL_ACTIVE_UNIFORMS = $8B86;
  GL_ACTIVE_UNIFORM_MAX_LENGTH = $8B87;
  GL_SHADER_SOURCE_LENGTH = $8B88;
  GL_ACTIVE_ATTRIBUTES = $8B89;
  GL_ACTIVE_ATTRIBUTE_MAX_LENGTH = $8B8A;
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT = $8B8B;
  GL_SHADING_LANGUAGE_VERSION = $8B8C;
  GL_CURRENT_PROGRAM = $8B8D;
  GL_POINT_SPRITE_COORD_ORIGIN = $8CA0;
  GL_LOWER_LEFT = $8CA1;
  GL_UPPER_LEFT = $8CA2;
  GL_STENCIL_BACK_REF = $8CA3;
  GL_STENCIL_BACK_VALUE_MASK = $8CA4;
  GL_STENCIL_BACK_WRITEMASK = $8CA5;
  GL_VERTEX_PROGRAM_TWO_SIDE = $8643;
  GL_POINT_SPRITE = $8861;
  GL_COORD_REPLACE = $8862;
  GL_MAX_TEXTURE_COORDS = $8871;
  GL_PIXEL_PACK_BUFFER = $88EB;
  GL_PIXEL_UNPACK_BUFFER = $88EC;
  GL_PIXEL_PACK_BUFFER_BINDING = $88ED;
  GL_PIXEL_UNPACK_BUFFER_BINDING = $88EF;
  GL_FLOAT_MAT2x3 = $8B65;
  GL_FLOAT_MAT2x4 = $8B66;
  GL_FLOAT_MAT3x2 = $8B67;
  GL_FLOAT_MAT3x4 = $8B68;
  GL_FLOAT_MAT4x2 = $8B69;
  GL_FLOAT_MAT4x3 = $8B6A;
  GL_SRGB = $8C40;
  GL_SRGB8 = $8C41;
  GL_SRGB_ALPHA = $8C42;
  GL_SRGB8_ALPHA8 = $8C43;
  GL_COMPRESSED_SRGB = $8C48;
  GL_COMPRESSED_SRGB_ALPHA = $8C49;
  GL_CURRENT_RASTER_SECONDARY_COLOR = $845F;
  GL_SLUMINANCE_ALPHA = $8C44;
  GL_SLUMINANCE8_ALPHA8 = $8C45;
  GL_SLUMINANCE = $8C46;
  GL_SLUMINANCE8 = $8C47;
  GL_COMPRESSED_SLUMINANCE = $8C4A;
  GL_COMPRESSED_SLUMINANCE_ALPHA = $8C4B;

var
  GLAD_GL_VERSION_1_0: boolean;
  GLAD_GL_VERSION_1_1: boolean;
  GLAD_GL_VERSION_1_2: boolean;
  GLAD_GL_VERSION_1_3: boolean;
  GLAD_GL_VERSION_1_4: boolean;
  GLAD_GL_VERSION_1_5: boolean;
  GLAD_GL_VERSION_2_0: boolean;
  GLAD_GL_VERSION_2_1: boolean;

var
  glCullFace: procedure (mode: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFrontFace: procedure (mode: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glHint: procedure (target: GLenum; mode: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLineWidth: procedure (width: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPointSize: procedure (size: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPolygonMode: procedure (face: GLenum; mode: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glScissor: procedure (x: GLint; y: GLint; width: GLsizei; height: GLsizei); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexParameterf: procedure (target: GLenum; pname: GLenum; param: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexParameterfv: procedure (target: GLenum; pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexParameteri: procedure (target: GLenum; pname: GLenum; param: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexParameteriv: procedure (target: GLenum; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexImage1D: procedure (target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; border: GLint; format: GLenum; type_: GLenum; pixels: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexImage2D: procedure (target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; type_: GLenum; pixels: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDrawBuffer: procedure (buf: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glClear: procedure (mask: GLbitfield); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glClearColor: procedure (red: GLfloat; green: GLfloat; blue: GLfloat; alpha: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glClearStencil: procedure (s: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glClearDepth: procedure (depth: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glStencilMask: procedure (mask: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColorMask: procedure (red: GLboolean; green: GLboolean; blue: GLboolean; alpha: GLboolean); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDepthMask: procedure (flag: GLboolean); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDisable: procedure (cap: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEnable: procedure (cap: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFinish: procedure (); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFlush: procedure (); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glBlendFunc: procedure (sfactor: GLenum; dfactor: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLogicOp: procedure (opcode: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glStencilFunc: procedure (func: GLenum; ref: GLint; mask: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glStencilOp: procedure (fail: GLenum; zfail: GLenum; zpass: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDepthFunc: procedure (func: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPixelStoref: procedure (pname: GLenum; param: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPixelStorei: procedure (pname: GLenum; param: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glReadBuffer: procedure (src: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glReadPixels: procedure (x: GLint; y: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum; pixels: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetBooleanv: procedure (pname: GLenum; data: PGLboolean); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetDoublev: procedure (pname: GLenum; data: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetError: function (): GLenum; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetFloatv: procedure (pname: GLenum; data: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetIntegerv: procedure (pname: GLenum; data: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetString: function (name: GLenum): PGLubyte; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetTexImage: procedure (target: GLenum; level: GLint; format: GLenum; type_: GLenum; pixels: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetTexParameterfv: procedure (target: GLenum; pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetTexParameteriv: procedure (target: GLenum; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetTexLevelParameterfv: procedure (target: GLenum; level: GLint; pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetTexLevelParameteriv: procedure (target: GLenum; level: GLint; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIsEnabled: function (cap: GLenum): GLboolean; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDepthRange: procedure (n: GLdouble; f: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glViewport: procedure (x: GLint; y: GLint; width: GLsizei; height: GLsizei); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glNewList: procedure (list: GLuint; mode: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEndList: procedure (); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCallList: procedure (list: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCallLists: procedure (n: GLsizei; type_: GLenum; lists: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDeleteLists: procedure (list: GLuint; range: GLsizei); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGenLists: function (range: GLsizei): GLuint; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glListBase: procedure (base: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glBegin: procedure (mode: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glBitmap: procedure (width: GLsizei; height: GLsizei; xorig: GLfloat; yorig: GLfloat; xmove: GLfloat; ymove: GLfloat; bitmap: PGLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3b: procedure (red: GLbyte; green: GLbyte; blue: GLbyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3bv: procedure (v: PGLbyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3d: procedure (red: GLdouble; green: GLdouble; blue: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3f: procedure (red: GLfloat; green: GLfloat; blue: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3i: procedure (red: GLint; green: GLint; blue: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3s: procedure (red: GLshort; green: GLshort; blue: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3ub: procedure (red: GLubyte; green: GLubyte; blue: GLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3ubv: procedure (v: PGLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3ui: procedure (red: GLuint; green: GLuint; blue: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3uiv: procedure (v: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3us: procedure (red: GLushort; green: GLushort; blue: GLushort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor3usv: procedure (v: PGLushort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4b: procedure (red: GLbyte; green: GLbyte; blue: GLbyte; alpha: GLbyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4bv: procedure (v: PGLbyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4d: procedure (red: GLdouble; green: GLdouble; blue: GLdouble; alpha: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4f: procedure (red: GLfloat; green: GLfloat; blue: GLfloat; alpha: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4i: procedure (red: GLint; green: GLint; blue: GLint; alpha: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4s: procedure (red: GLshort; green: GLshort; blue: GLshort; alpha: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4ub: procedure (red: GLubyte; green: GLubyte; blue: GLubyte; alpha: GLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4ubv: procedure (v: PGLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4ui: procedure (red: GLuint; green: GLuint; blue: GLuint; alpha: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4uiv: procedure (v: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4us: procedure (red: GLushort; green: GLushort; blue: GLushort; alpha: GLushort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColor4usv: procedure (v: PGLushort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEdgeFlag: procedure (flag: GLboolean); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEdgeFlagv: procedure (flag: PGLboolean); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEnd: procedure (); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIndexd: procedure (c: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIndexdv: procedure (c: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIndexf: procedure (c: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIndexfv: procedure (c: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIndexi: procedure (c: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIndexiv: procedure (c: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIndexs: procedure (c: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIndexsv: procedure (c: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glNormal3b: procedure (nx: GLbyte; ny: GLbyte; nz: GLbyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glNormal3bv: procedure (v: PGLbyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glNormal3d: procedure (nx: GLdouble; ny: GLdouble; nz: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glNormal3dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glNormal3f: procedure (nx: GLfloat; ny: GLfloat; nz: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glNormal3fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glNormal3i: procedure (nx: GLint; ny: GLint; nz: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glNormal3iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glNormal3s: procedure (nx: GLshort; ny: GLshort; nz: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glNormal3sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos2d: procedure (x: GLdouble; y: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos2dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos2f: procedure (x: GLfloat; y: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos2fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos2i: procedure (x: GLint; y: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos2iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos2s: procedure (x: GLshort; y: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos2sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos3d: procedure (x: GLdouble; y: GLdouble; z: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos3dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos3f: procedure (x: GLfloat; y: GLfloat; z: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos3fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos3i: procedure (x: GLint; y: GLint; z: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos3iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos3s: procedure (x: GLshort; y: GLshort; z: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos3sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos4d: procedure (x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos4dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos4f: procedure (x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos4fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos4i: procedure (x: GLint; y: GLint; z: GLint; w: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos4iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos4s: procedure (x: GLshort; y: GLshort; z: GLshort; w: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRasterPos4sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRectd: procedure (x1: GLdouble; y1: GLdouble; x2: GLdouble; y2: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRectdv: procedure (v1: PGLdouble; v2: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRectf: procedure (x1: GLfloat; y1: GLfloat; x2: GLfloat; y2: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRectfv: procedure (v1: PGLfloat; v2: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRecti: procedure (x1: GLint; y1: GLint; x2: GLint; y2: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRectiv: procedure (v1: PGLint; v2: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRects: procedure (x1: GLshort; y1: GLshort; x2: GLshort; y2: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRectsv: procedure (v1: PGLshort; v2: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord1d: procedure (s: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord1dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord1f: procedure (s: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord1fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord1i: procedure (s: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord1iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord1s: procedure (s: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord1sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord2d: procedure (s: GLdouble; t: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord2dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord2f: procedure (s: GLfloat; t: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord2fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord2i: procedure (s: GLint; t: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord2iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord2s: procedure (s: GLshort; t: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord2sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord3d: procedure (s: GLdouble; t: GLdouble; r: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord3dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord3f: procedure (s: GLfloat; t: GLfloat; r: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord3fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord3i: procedure (s: GLint; t: GLint; r: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord3iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord3s: procedure (s: GLshort; t: GLshort; r: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord3sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord4d: procedure (s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord4dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord4f: procedure (s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord4fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord4i: procedure (s: GLint; t: GLint; r: GLint; q: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord4iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord4s: procedure (s: GLshort; t: GLshort; r: GLshort; q: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoord4sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex2d: procedure (x: GLdouble; y: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex2dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex2f: procedure (x: GLfloat; y: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex2fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex2i: procedure (x: GLint; y: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex2iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex2s: procedure (x: GLshort; y: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex2sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex3d: procedure (x: GLdouble; y: GLdouble; z: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex3dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex3f: procedure (x: GLfloat; y: GLfloat; z: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex3fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex3i: procedure (x: GLint; y: GLint; z: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex3iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex3s: procedure (x: GLshort; y: GLshort; z: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex3sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex4d: procedure (x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex4dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex4f: procedure (x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex4fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex4i: procedure (x: GLint; y: GLint; z: GLint; w: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex4iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex4s: procedure (x: GLshort; y: GLshort; z: GLshort; w: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertex4sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glClipPlane: procedure (plane: GLenum; equation: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColorMaterial: procedure (face: GLenum; mode: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFogf: procedure (pname: GLenum; param: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFogfv: procedure (pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFogi: procedure (pname: GLenum; param: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFogiv: procedure (pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLightf: procedure (light: GLenum; pname: GLenum; param: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLightfv: procedure (light: GLenum; pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLighti: procedure (light: GLenum; pname: GLenum; param: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLightiv: procedure (light: GLenum; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLightModelf: procedure (pname: GLenum; param: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLightModelfv: procedure (pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLightModeli: procedure (pname: GLenum; param: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLightModeliv: procedure (pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLineStipple: procedure (factor: GLint; pattern: GLushort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMaterialf: procedure (face: GLenum; pname: GLenum; param: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMaterialfv: procedure (face: GLenum; pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMateriali: procedure (face: GLenum; pname: GLenum; param: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMaterialiv: procedure (face: GLenum; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPolygonStipple: procedure (mask: PGLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glShadeModel: procedure (mode: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexEnvf: procedure (target: GLenum; pname: GLenum; param: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexEnvfv: procedure (target: GLenum; pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexEnvi: procedure (target: GLenum; pname: GLenum; param: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexEnviv: procedure (target: GLenum; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexGend: procedure (coord: GLenum; pname: GLenum; param: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexGendv: procedure (coord: GLenum; pname: GLenum; params: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexGenf: procedure (coord: GLenum; pname: GLenum; param: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexGenfv: procedure (coord: GLenum; pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexGeni: procedure (coord: GLenum; pname: GLenum; param: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexGeniv: procedure (coord: GLenum; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFeedbackBuffer: procedure (size: GLsizei; type_: GLenum; buffer: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSelectBuffer: procedure (size: GLsizei; buffer: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRenderMode: function (mode: GLenum): GLint; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glInitNames: procedure (); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLoadName: procedure (name: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPassThrough: procedure (token: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPopName: procedure (); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPushName: procedure (name: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glClearAccum: procedure (red: GLfloat; green: GLfloat; blue: GLfloat; alpha: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glClearIndex: procedure (c: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIndexMask: procedure (mask: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glAccum: procedure (op: GLenum; value: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPopAttrib: procedure (); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPushAttrib: procedure (mask: GLbitfield); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMap1d: procedure (target: GLenum; u1: GLdouble; u2: GLdouble; stride: GLint; order: GLint; points: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMap1f: procedure (target: GLenum; u1: GLfloat; u2: GLfloat; stride: GLint; order: GLint; points: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMap2d: procedure (target: GLenum; u1: GLdouble; u2: GLdouble; ustride: GLint; uorder: GLint; v1: GLdouble; v2: GLdouble; vstride: GLint; vorder: GLint; points: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMap2f: procedure (target: GLenum; u1: GLfloat; u2: GLfloat; ustride: GLint; uorder: GLint; v1: GLfloat; v2: GLfloat; vstride: GLint; vorder: GLint; points: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMapGrid1d: procedure (un: GLint; u1: GLdouble; u2: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMapGrid1f: procedure (un: GLint; u1: GLfloat; u2: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMapGrid2d: procedure (un: GLint; u1: GLdouble; u2: GLdouble; vn: GLint; v1: GLdouble; v2: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMapGrid2f: procedure (un: GLint; u1: GLfloat; u2: GLfloat; vn: GLint; v1: GLfloat; v2: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEvalCoord1d: procedure (u: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEvalCoord1dv: procedure (u: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEvalCoord1f: procedure (u: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEvalCoord1fv: procedure (u: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEvalCoord2d: procedure (u: GLdouble; v: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEvalCoord2dv: procedure (u: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEvalCoord2f: procedure (u: GLfloat; v: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEvalCoord2fv: procedure (u: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEvalMesh1: procedure (mode: GLenum; i1: GLint; i2: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEvalPoint1: procedure (i: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEvalMesh2: procedure (mode: GLenum; i1: GLint; i2: GLint; j1: GLint; j2: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEvalPoint2: procedure (i: GLint; j: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glAlphaFunc: procedure (func: GLenum; ref: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPixelZoom: procedure (xfactor: GLfloat; yfactor: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPixelTransferf: procedure (pname: GLenum; param: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPixelTransferi: procedure (pname: GLenum; param: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPixelMapfv: procedure (map: GLenum; mapsize: GLsizei; values: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPixelMapuiv: procedure (map: GLenum; mapsize: GLsizei; values: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPixelMapusv: procedure (map: GLenum; mapsize: GLsizei; values: PGLushort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCopyPixels: procedure (x: GLint; y: GLint; width: GLsizei; height: GLsizei; type_: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDrawPixels: procedure (width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum; pixels: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetClipPlane: procedure (plane: GLenum; equation: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetLightfv: procedure (light: GLenum; pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetLightiv: procedure (light: GLenum; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetMapdv: procedure (target: GLenum; query: GLenum; v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetMapfv: procedure (target: GLenum; query: GLenum; v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetMapiv: procedure (target: GLenum; query: GLenum; v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetMaterialfv: procedure (face: GLenum; pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetMaterialiv: procedure (face: GLenum; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetPixelMapfv: procedure (map: GLenum; values: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetPixelMapuiv: procedure (map: GLenum; values: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetPixelMapusv: procedure (map: GLenum; values: PGLushort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetPolygonStipple: procedure (mask: PGLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetTexEnvfv: procedure (target: GLenum; pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetTexEnviv: procedure (target: GLenum; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetTexGendv: procedure (coord: GLenum; pname: GLenum; params: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetTexGenfv: procedure (coord: GLenum; pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetTexGeniv: procedure (coord: GLenum; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIsList: function (list: GLuint): GLboolean; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFrustum: procedure (left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLoadIdentity: procedure (); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLoadMatrixf: procedure (m: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLoadMatrixd: procedure (m: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMatrixMode: procedure (mode: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultMatrixf: procedure (m: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultMatrixd: procedure (m: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glOrtho: procedure (left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPopMatrix: procedure (); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPushMatrix: procedure (); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRotated: procedure (angle: GLdouble; x: GLdouble; y: GLdouble; z: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glRotatef: procedure (angle: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glScaled: procedure (x: GLdouble; y: GLdouble; z: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glScalef: procedure (x: GLfloat; y: GLfloat; z: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTranslated: procedure (x: GLdouble; y: GLdouble; z: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTranslatef: procedure (x: GLfloat; y: GLfloat; z: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDrawArrays: procedure (mode: GLenum; first: GLint; count: GLsizei); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDrawElements: procedure (mode: GLenum; count: GLsizei; type_: GLenum; indices: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetPointerv: procedure (pname: GLenum; params: PPointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPolygonOffset: procedure (factor: GLfloat; units: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCopyTexImage1D: procedure (target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCopyTexImage2D: procedure (target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCopyTexSubImage1D: procedure (target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCopyTexSubImage2D: procedure (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexSubImage1D: procedure (target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; type_: GLenum; pixels: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexSubImage2D: procedure (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum; pixels: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glBindTexture: procedure (target: GLenum; texture: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDeleteTextures: procedure (n: GLsizei; textures: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGenTextures: procedure (n: GLsizei; textures: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIsTexture: function (texture: GLuint): GLboolean; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glArrayElement: procedure (i: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glColorPointer: procedure (size: GLint; type_: GLenum; stride: GLsizei; pointer: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDisableClientState: procedure (array_: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEdgeFlagPointer: procedure (stride: GLsizei; pointer: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEnableClientState: procedure (array_: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIndexPointer: procedure (type_: GLenum; stride: GLsizei; pointer: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glInterleavedArrays: procedure (format: GLenum; stride: GLsizei; pointer: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glNormalPointer: procedure (type_: GLenum; stride: GLsizei; pointer: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexCoordPointer: procedure (size: GLint; type_: GLenum; stride: GLsizei; pointer: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexPointer: procedure (size: GLint; type_: GLenum; stride: GLsizei; pointer: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glAreTexturesResident: function (n: GLsizei; textures: PGLuint; residences: PGLboolean): GLboolean; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPrioritizeTextures: procedure (n: GLsizei; textures: PGLuint; priorities: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIndexub: procedure (c: GLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIndexubv: procedure (c: PGLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPopClientAttrib: procedure (); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPushClientAttrib: procedure (mask: GLbitfield); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDrawRangeElements: procedure (mode: GLenum; start: GLuint; end_: GLuint; count: GLsizei; type_: GLenum; indices: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexImage3D: procedure (target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; type_: GLenum; pixels: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glTexSubImage3D: procedure (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; type_: GLenum; pixels: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCopyTexSubImage3D: procedure (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glActiveTexture: procedure (texture: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSampleCoverage: procedure (value: GLfloat; invert: GLboolean); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCompressedTexImage3D: procedure (target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei; data: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCompressedTexImage2D: procedure (target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei; data: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCompressedTexImage1D: procedure (target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei; data: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCompressedTexSubImage3D: procedure (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei; data: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCompressedTexSubImage2D: procedure (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei; data: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCompressedTexSubImage1D: procedure (target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei; data: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetCompressedTexImage: procedure (target: GLenum; level: GLint; img: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glClientActiveTexture: procedure (texture: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord1d: procedure (target: GLenum; s: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord1dv: procedure (target: GLenum; v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord1f: procedure (target: GLenum; s: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord1fv: procedure (target: GLenum; v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord1i: procedure (target: GLenum; s: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord1iv: procedure (target: GLenum; v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord1s: procedure (target: GLenum; s: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord1sv: procedure (target: GLenum; v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord2d: procedure (target: GLenum; s: GLdouble; t: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord2dv: procedure (target: GLenum; v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord2f: procedure (target: GLenum; s: GLfloat; t: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord2fv: procedure (target: GLenum; v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord2i: procedure (target: GLenum; s: GLint; t: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord2iv: procedure (target: GLenum; v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord2s: procedure (target: GLenum; s: GLshort; t: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord2sv: procedure (target: GLenum; v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord3d: procedure (target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord3dv: procedure (target: GLenum; v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord3f: procedure (target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord3fv: procedure (target: GLenum; v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord3i: procedure (target: GLenum; s: GLint; t: GLint; r: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord3iv: procedure (target: GLenum; v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord3s: procedure (target: GLenum; s: GLshort; t: GLshort; r: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord3sv: procedure (target: GLenum; v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord4d: procedure (target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord4dv: procedure (target: GLenum; v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord4f: procedure (target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord4fv: procedure (target: GLenum; v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord4i: procedure (target: GLenum; s: GLint; t: GLint; r: GLint; q: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord4iv: procedure (target: GLenum; v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord4s: procedure (target: GLenum; s: GLshort; t: GLshort; r: GLshort; q: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiTexCoord4sv: procedure (target: GLenum; v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLoadTransposeMatrixf: procedure (m: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLoadTransposeMatrixd: procedure (m: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultTransposeMatrixf: procedure (m: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultTransposeMatrixd: procedure (m: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glBlendFuncSeparate: procedure (sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiDrawArrays: procedure (mode: GLenum; first: PGLint; count: PGLsizei; drawcount: GLsizei); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMultiDrawElements: procedure (mode: GLenum; count: PGLsizei; type_: GLenum; indices: PPointer; drawcount: GLsizei); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPointParameterf: procedure (pname: GLenum; param: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPointParameterfv: procedure (pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPointParameteri: procedure (pname: GLenum; param: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glPointParameteriv: procedure (pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFogCoordf: procedure (coord: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFogCoordfv: procedure (coord: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFogCoordd: procedure (coord: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFogCoorddv: procedure (coord: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glFogCoordPointer: procedure (type_: GLenum; stride: GLsizei; pointer: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3b: procedure (red: GLbyte; green: GLbyte; blue: GLbyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3bv: procedure (v: PGLbyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3d: procedure (red: GLdouble; green: GLdouble; blue: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3f: procedure (red: GLfloat; green: GLfloat; blue: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3i: procedure (red: GLint; green: GLint; blue: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3s: procedure (red: GLshort; green: GLshort; blue: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3ub: procedure (red: GLubyte; green: GLubyte; blue: GLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3ubv: procedure (v: PGLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3ui: procedure (red: GLuint; green: GLuint; blue: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3uiv: procedure (v: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3us: procedure (red: GLushort; green: GLushort; blue: GLushort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColor3usv: procedure (v: PGLushort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glSecondaryColorPointer: procedure (size: GLint; type_: GLenum; stride: GLsizei; pointer: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos2d: procedure (x: GLdouble; y: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos2dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos2f: procedure (x: GLfloat; y: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos2fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos2i: procedure (x: GLint; y: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos2iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos2s: procedure (x: GLshort; y: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos2sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos3d: procedure (x: GLdouble; y: GLdouble; z: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos3dv: procedure (v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos3f: procedure (x: GLfloat; y: GLfloat; z: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos3fv: procedure (v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos3i: procedure (x: GLint; y: GLint; z: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos3iv: procedure (v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos3s: procedure (x: GLshort; y: GLshort; z: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glWindowPos3sv: procedure (v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glBlendColor: procedure (red: GLfloat; green: GLfloat; blue: GLfloat; alpha: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glBlendEquation: procedure (mode: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGenQueries: procedure (n: GLsizei; ids: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDeleteQueries: procedure (n: GLsizei; ids: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIsQuery: function (id: GLuint): GLboolean; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glBeginQuery: procedure (target: GLenum; id: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEndQuery: procedure (target: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetQueryiv: procedure (target: GLenum; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetQueryObjectiv: procedure (id: GLuint; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetQueryObjectuiv: procedure (id: GLuint; pname: GLenum; params: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glBindBuffer: procedure (target: GLenum; buffer: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDeleteBuffers: procedure (n: GLsizei; buffers: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGenBuffers: procedure (n: GLsizei; buffers: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIsBuffer: function (buffer: GLuint): GLboolean; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glBufferData: procedure (target: GLenum; size: GLsizeiptr; data: Pointer; usage: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glBufferSubData: procedure (target: GLenum; offset: GLintptr; size: GLsizeiptr; data: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetBufferSubData: procedure (target: GLenum; offset: GLintptr; size: GLsizeiptr; data: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glMapBuffer: function (target: GLenum; access: GLenum): Pointer; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUnmapBuffer: function (target: GLenum): GLboolean; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetBufferParameteriv: procedure (target: GLenum; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetBufferPointerv: procedure (target: GLenum; pname: GLenum; params: PPointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glBlendEquationSeparate: procedure (modeRGB: GLenum; modeAlpha: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDrawBuffers: procedure (n: GLsizei; bufs: PGLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glStencilOpSeparate: procedure (face: GLenum; sfail: GLenum; dpfail: GLenum; dppass: GLenum); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glStencilFuncSeparate: procedure (face: GLenum; func: GLenum; ref: GLint; mask: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glStencilMaskSeparate: procedure (face: GLenum; mask: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glAttachShader: procedure (program_: GLuint; shader: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glBindAttribLocation: procedure (program_: GLuint; index: GLuint; name: PGLchar); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCompileShader: procedure (shader: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCreateProgram: function (): GLuint; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glCreateShader: function (type_: GLenum): GLuint; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDeleteProgram: procedure (program_: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDeleteShader: procedure (shader: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDetachShader: procedure (program_: GLuint; shader: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glDisableVertexAttribArray: procedure (index: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glEnableVertexAttribArray: procedure (index: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetActiveAttrib: procedure (program_: GLuint; index: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLint; type_: PGLenum; name: PGLchar); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetActiveUniform: procedure (program_: GLuint; index: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLint; type_: PGLenum; name: PGLchar); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetAttachedShaders: procedure (program_: GLuint; maxCount: GLsizei; count: PGLsizei; shaders: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetAttribLocation: function (program_: GLuint; name: PGLchar): GLint; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetProgramiv: procedure (program_: GLuint; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetProgramInfoLog: procedure (program_: GLuint; bufSize: GLsizei; length: PGLsizei; infoLog: PGLchar); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetShaderiv: procedure (shader: GLuint; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetShaderInfoLog: procedure (shader: GLuint; bufSize: GLsizei; length: PGLsizei; infoLog: PGLchar); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetShaderSource: procedure (shader: GLuint; bufSize: GLsizei; length: PGLsizei; source: PGLchar); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetUniformLocation: function (program_: GLuint; name: PGLchar): GLint; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetUniformfv: procedure (program_: GLuint; location: GLint; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetUniformiv: procedure (program_: GLuint; location: GLint; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetVertexAttribdv: procedure (index: GLuint; pname: GLenum; params: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetVertexAttribfv: procedure (index: GLuint; pname: GLenum; params: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetVertexAttribiv: procedure (index: GLuint; pname: GLenum; params: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glGetVertexAttribPointerv: procedure (index: GLuint; pname: GLenum; pointer: PPointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIsProgram: function (program_: GLuint): GLboolean; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glIsShader: function (shader: GLuint): GLboolean; {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glLinkProgram: procedure (program_: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glShaderSource: procedure (shader: GLuint; count: GLsizei; string_: PPGLchar; length: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUseProgram: procedure (program_: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform1f: procedure (location: GLint; v0: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform2f: procedure (location: GLint; v0: GLfloat; v1: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform3f: procedure (location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform4f: procedure (location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform1i: procedure (location: GLint; v0: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform2i: procedure (location: GLint; v0: GLint; v1: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform3i: procedure (location: GLint; v0: GLint; v1: GLint; v2: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform4i: procedure (location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform1fv: procedure (location: GLint; count: GLsizei; value: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform2fv: procedure (location: GLint; count: GLsizei; value: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform3fv: procedure (location: GLint; count: GLsizei; value: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform4fv: procedure (location: GLint; count: GLsizei; value: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform1iv: procedure (location: GLint; count: GLsizei; value: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform2iv: procedure (location: GLint; count: GLsizei; value: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform3iv: procedure (location: GLint; count: GLsizei; value: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniform4iv: procedure (location: GLint; count: GLsizei; value: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniformMatrix2fv: procedure (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniformMatrix3fv: procedure (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniformMatrix4fv: procedure (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glValidateProgram: procedure (program_: GLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib1d: procedure (index: GLuint; x: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib1dv: procedure (index: GLuint; v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib1f: procedure (index: GLuint; x: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib1fv: procedure (index: GLuint; v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib1s: procedure (index: GLuint; x: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib1sv: procedure (index: GLuint; v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib2d: procedure (index: GLuint; x: GLdouble; y: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib2dv: procedure (index: GLuint; v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib2f: procedure (index: GLuint; x: GLfloat; y: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib2fv: procedure (index: GLuint; v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib2s: procedure (index: GLuint; x: GLshort; y: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib2sv: procedure (index: GLuint; v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib3d: procedure (index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib3dv: procedure (index: GLuint; v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib3f: procedure (index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib3fv: procedure (index: GLuint; v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib3s: procedure (index: GLuint; x: GLshort; y: GLshort; z: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib3sv: procedure (index: GLuint; v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4Nbv: procedure (index: GLuint; v: PGLbyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4Niv: procedure (index: GLuint; v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4Nsv: procedure (index: GLuint; v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4Nub: procedure (index: GLuint; x: GLubyte; y: GLubyte; z: GLubyte; w: GLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4Nubv: procedure (index: GLuint; v: PGLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4Nuiv: procedure (index: GLuint; v: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4Nusv: procedure (index: GLuint; v: PGLushort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4bv: procedure (index: GLuint; v: PGLbyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4d: procedure (index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4dv: procedure (index: GLuint; v: PGLdouble); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4f: procedure (index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4fv: procedure (index: GLuint; v: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4iv: procedure (index: GLuint; v: PGLint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4s: procedure (index: GLuint; x: GLshort; y: GLshort; z: GLshort; w: GLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4sv: procedure (index: GLuint; v: PGLshort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4ubv: procedure (index: GLuint; v: PGLubyte); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4uiv: procedure (index: GLuint; v: PGLuint); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttrib4usv: procedure (index: GLuint; v: PGLushort); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glVertexAttribPointer: procedure (index: GLuint; size: GLint; type_: GLenum; normalized: GLboolean; stride: GLsizei; pointer: Pointer); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniformMatrix2x3fv: procedure (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniformMatrix3x2fv: procedure (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniformMatrix2x4fv: procedure (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniformMatrix4x2fv: procedure (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniformMatrix3x4fv: procedure (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}
  glUniformMatrix4x3fv: procedure (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IF Defined(Windows) or Defined(MSWindows)}stdcall;{$ELSE}cdecl;{$ENDIF}

function LoadOpenGL(): Boolean;

implementation

type
  TLoadProc = function(proc: PAnsiChar): Pointer;

function hasExt(const extname: string): Boolean;
var
  extensions: PChar;
  loc, terminator: Pchar;
{$IFDEF HAS_GL_NUM_EXTENSIONS}
  num_extensions, i: integer;
  ext: pchar;
{$ENDIF}
begin
  result := false;
{$IFDEF HAS_GL_NUM_EXTENSIONS}
  if glVersionMajor >= 3 then begin
      glGetIntegerv(GL_NUM_EXTENSIONS, @num_extensions);
      for i := 0 to num_extensions - 1 do begin
          ext := PChar( glGetStringi(GL_EXTENSIONS, i) );
          if strcomp(ext, PChar(extname)) = 0 then
              exit(true);
      end;
      exit;
  end;
{$ENDIF}
  extensions := PChar( glGetString(GL_EXTENSIONS) );
  while true do begin
      loc := strpos(extensions, PChar(extname));
      if loc = nil then
          exit;
      terminator := loc + length(extname);
      if (loc = extensions) or (loc[-1] = ' ') then
          if (terminator[0] = ' ') or (terminator[0] = #0) then
              exit(true);
      extensions := terminator;
  end;
end;

procedure load_GL_VERSION_1_0(load: TLoadProc);
begin
  if not GLAD_GL_VERSION_1_0 then exit;
  glCullFace := load('glCullFace');
  glFrontFace := load('glFrontFace');
  glHint := load('glHint');
  glLineWidth := load('glLineWidth');
  glPointSize := load('glPointSize');
  glPolygonMode := load('glPolygonMode');
  glScissor := load('glScissor');
  glTexParameterf := load('glTexParameterf');
  glTexParameterfv := load('glTexParameterfv');
  glTexParameteri := load('glTexParameteri');
  glTexParameteriv := load('glTexParameteriv');
  glTexImage1D := load('glTexImage1D');
  glTexImage2D := load('glTexImage2D');
  glDrawBuffer := load('glDrawBuffer');
  glClear := load('glClear');
  glClearColor := load('glClearColor');
  glClearStencil := load('glClearStencil');
  glClearDepth := load('glClearDepth');
  glStencilMask := load('glStencilMask');
  glColorMask := load('glColorMask');
  glDepthMask := load('glDepthMask');
  glDisable := load('glDisable');
  glEnable := load('glEnable');
  glFinish := load('glFinish');
  glFlush := load('glFlush');
  glBlendFunc := load('glBlendFunc');
  glLogicOp := load('glLogicOp');
  glStencilFunc := load('glStencilFunc');
  glStencilOp := load('glStencilOp');
  glDepthFunc := load('glDepthFunc');
  glPixelStoref := load('glPixelStoref');
  glPixelStorei := load('glPixelStorei');
  glReadBuffer := load('glReadBuffer');
  glReadPixels := load('glReadPixels');
  glGetBooleanv := load('glGetBooleanv');
  glGetDoublev := load('glGetDoublev');
  glGetError := load('glGetError');
  glGetFloatv := load('glGetFloatv');
  glGetIntegerv := load('glGetIntegerv');
  glGetString := load('glGetString');
  glGetTexImage := load('glGetTexImage');
  glGetTexParameterfv := load('glGetTexParameterfv');
  glGetTexParameteriv := load('glGetTexParameteriv');
  glGetTexLevelParameterfv := load('glGetTexLevelParameterfv');
  glGetTexLevelParameteriv := load('glGetTexLevelParameteriv');
  glIsEnabled := load('glIsEnabled');
  glDepthRange := load('glDepthRange');
  glViewport := load('glViewport');
  glNewList := load('glNewList');
  glEndList := load('glEndList');
  glCallList := load('glCallList');
  glCallLists := load('glCallLists');
  glDeleteLists := load('glDeleteLists');
  glGenLists := load('glGenLists');
  glListBase := load('glListBase');
  glBegin := load('glBegin');
  glBitmap := load('glBitmap');
  glColor3b := load('glColor3b');
  glColor3bv := load('glColor3bv');
  glColor3d := load('glColor3d');
  glColor3dv := load('glColor3dv');
  glColor3f := load('glColor3f');
  glColor3fv := load('glColor3fv');
  glColor3i := load('glColor3i');
  glColor3iv := load('glColor3iv');
  glColor3s := load('glColor3s');
  glColor3sv := load('glColor3sv');
  glColor3ub := load('glColor3ub');
  glColor3ubv := load('glColor3ubv');
  glColor3ui := load('glColor3ui');
  glColor3uiv := load('glColor3uiv');
  glColor3us := load('glColor3us');
  glColor3usv := load('glColor3usv');
  glColor4b := load('glColor4b');
  glColor4bv := load('glColor4bv');
  glColor4d := load('glColor4d');
  glColor4dv := load('glColor4dv');
  glColor4f := load('glColor4f');
  glColor4fv := load('glColor4fv');
  glColor4i := load('glColor4i');
  glColor4iv := load('glColor4iv');
  glColor4s := load('glColor4s');
  glColor4sv := load('glColor4sv');
  glColor4ub := load('glColor4ub');
  glColor4ubv := load('glColor4ubv');
  glColor4ui := load('glColor4ui');
  glColor4uiv := load('glColor4uiv');
  glColor4us := load('glColor4us');
  glColor4usv := load('glColor4usv');
  glEdgeFlag := load('glEdgeFlag');
  glEdgeFlagv := load('glEdgeFlagv');
  glEnd := load('glEnd');
  glIndexd := load('glIndexd');
  glIndexdv := load('glIndexdv');
  glIndexf := load('glIndexf');
  glIndexfv := load('glIndexfv');
  glIndexi := load('glIndexi');
  glIndexiv := load('glIndexiv');
  glIndexs := load('glIndexs');
  glIndexsv := load('glIndexsv');
  glNormal3b := load('glNormal3b');
  glNormal3bv := load('glNormal3bv');
  glNormal3d := load('glNormal3d');
  glNormal3dv := load('glNormal3dv');
  glNormal3f := load('glNormal3f');
  glNormal3fv := load('glNormal3fv');
  glNormal3i := load('glNormal3i');
  glNormal3iv := load('glNormal3iv');
  glNormal3s := load('glNormal3s');
  glNormal3sv := load('glNormal3sv');
  glRasterPos2d := load('glRasterPos2d');
  glRasterPos2dv := load('glRasterPos2dv');
  glRasterPos2f := load('glRasterPos2f');
  glRasterPos2fv := load('glRasterPos2fv');
  glRasterPos2i := load('glRasterPos2i');
  glRasterPos2iv := load('glRasterPos2iv');
  glRasterPos2s := load('glRasterPos2s');
  glRasterPos2sv := load('glRasterPos2sv');
  glRasterPos3d := load('glRasterPos3d');
  glRasterPos3dv := load('glRasterPos3dv');
  glRasterPos3f := load('glRasterPos3f');
  glRasterPos3fv := load('glRasterPos3fv');
  glRasterPos3i := load('glRasterPos3i');
  glRasterPos3iv := load('glRasterPos3iv');
  glRasterPos3s := load('glRasterPos3s');
  glRasterPos3sv := load('glRasterPos3sv');
  glRasterPos4d := load('glRasterPos4d');
  glRasterPos4dv := load('glRasterPos4dv');
  glRasterPos4f := load('glRasterPos4f');
  glRasterPos4fv := load('glRasterPos4fv');
  glRasterPos4i := load('glRasterPos4i');
  glRasterPos4iv := load('glRasterPos4iv');
  glRasterPos4s := load('glRasterPos4s');
  glRasterPos4sv := load('glRasterPos4sv');
  glRectd := load('glRectd');
  glRectdv := load('glRectdv');
  glRectf := load('glRectf');
  glRectfv := load('glRectfv');
  glRecti := load('glRecti');
  glRectiv := load('glRectiv');
  glRects := load('glRects');
  glRectsv := load('glRectsv');
  glTexCoord1d := load('glTexCoord1d');
  glTexCoord1dv := load('glTexCoord1dv');
  glTexCoord1f := load('glTexCoord1f');
  glTexCoord1fv := load('glTexCoord1fv');
  glTexCoord1i := load('glTexCoord1i');
  glTexCoord1iv := load('glTexCoord1iv');
  glTexCoord1s := load('glTexCoord1s');
  glTexCoord1sv := load('glTexCoord1sv');
  glTexCoord2d := load('glTexCoord2d');
  glTexCoord2dv := load('glTexCoord2dv');
  glTexCoord2f := load('glTexCoord2f');
  glTexCoord2fv := load('glTexCoord2fv');
  glTexCoord2i := load('glTexCoord2i');
  glTexCoord2iv := load('glTexCoord2iv');
  glTexCoord2s := load('glTexCoord2s');
  glTexCoord2sv := load('glTexCoord2sv');
  glTexCoord3d := load('glTexCoord3d');
  glTexCoord3dv := load('glTexCoord3dv');
  glTexCoord3f := load('glTexCoord3f');
  glTexCoord3fv := load('glTexCoord3fv');
  glTexCoord3i := load('glTexCoord3i');
  glTexCoord3iv := load('glTexCoord3iv');
  glTexCoord3s := load('glTexCoord3s');
  glTexCoord3sv := load('glTexCoord3sv');
  glTexCoord4d := load('glTexCoord4d');
  glTexCoord4dv := load('glTexCoord4dv');
  glTexCoord4f := load('glTexCoord4f');
  glTexCoord4fv := load('glTexCoord4fv');
  glTexCoord4i := load('glTexCoord4i');
  glTexCoord4iv := load('glTexCoord4iv');
  glTexCoord4s := load('glTexCoord4s');
  glTexCoord4sv := load('glTexCoord4sv');
  glVertex2d := load('glVertex2d');
  glVertex2dv := load('glVertex2dv');
  glVertex2f := load('glVertex2f');
  glVertex2fv := load('glVertex2fv');
  glVertex2i := load('glVertex2i');
  glVertex2iv := load('glVertex2iv');
  glVertex2s := load('glVertex2s');
  glVertex2sv := load('glVertex2sv');
  glVertex3d := load('glVertex3d');
  glVertex3dv := load('glVertex3dv');
  glVertex3f := load('glVertex3f');
  glVertex3fv := load('glVertex3fv');
  glVertex3i := load('glVertex3i');
  glVertex3iv := load('glVertex3iv');
  glVertex3s := load('glVertex3s');
  glVertex3sv := load('glVertex3sv');
  glVertex4d := load('glVertex4d');
  glVertex4dv := load('glVertex4dv');
  glVertex4f := load('glVertex4f');
  glVertex4fv := load('glVertex4fv');
  glVertex4i := load('glVertex4i');
  glVertex4iv := load('glVertex4iv');
  glVertex4s := load('glVertex4s');
  glVertex4sv := load('glVertex4sv');
  glClipPlane := load('glClipPlane');
  glColorMaterial := load('glColorMaterial');
  glFogf := load('glFogf');
  glFogfv := load('glFogfv');
  glFogi := load('glFogi');
  glFogiv := load('glFogiv');
  glLightf := load('glLightf');
  glLightfv := load('glLightfv');
  glLighti := load('glLighti');
  glLightiv := load('glLightiv');
  glLightModelf := load('glLightModelf');
  glLightModelfv := load('glLightModelfv');
  glLightModeli := load('glLightModeli');
  glLightModeliv := load('glLightModeliv');
  glLineStipple := load('glLineStipple');
  glMaterialf := load('glMaterialf');
  glMaterialfv := load('glMaterialfv');
  glMateriali := load('glMateriali');
  glMaterialiv := load('glMaterialiv');
  glPolygonStipple := load('glPolygonStipple');
  glShadeModel := load('glShadeModel');
  glTexEnvf := load('glTexEnvf');
  glTexEnvfv := load('glTexEnvfv');
  glTexEnvi := load('glTexEnvi');
  glTexEnviv := load('glTexEnviv');
  glTexGend := load('glTexGend');
  glTexGendv := load('glTexGendv');
  glTexGenf := load('glTexGenf');
  glTexGenfv := load('glTexGenfv');
  glTexGeni := load('glTexGeni');
  glTexGeniv := load('glTexGeniv');
  glFeedbackBuffer := load('glFeedbackBuffer');
  glSelectBuffer := load('glSelectBuffer');
  glRenderMode := load('glRenderMode');
  glInitNames := load('glInitNames');
  glLoadName := load('glLoadName');
  glPassThrough := load('glPassThrough');
  glPopName := load('glPopName');
  glPushName := load('glPushName');
  glClearAccum := load('glClearAccum');
  glClearIndex := load('glClearIndex');
  glIndexMask := load('glIndexMask');
  glAccum := load('glAccum');
  glPopAttrib := load('glPopAttrib');
  glPushAttrib := load('glPushAttrib');
  glMap1d := load('glMap1d');
  glMap1f := load('glMap1f');
  glMap2d := load('glMap2d');
  glMap2f := load('glMap2f');
  glMapGrid1d := load('glMapGrid1d');
  glMapGrid1f := load('glMapGrid1f');
  glMapGrid2d := load('glMapGrid2d');
  glMapGrid2f := load('glMapGrid2f');
  glEvalCoord1d := load('glEvalCoord1d');
  glEvalCoord1dv := load('glEvalCoord1dv');
  glEvalCoord1f := load('glEvalCoord1f');
  glEvalCoord1fv := load('glEvalCoord1fv');
  glEvalCoord2d := load('glEvalCoord2d');
  glEvalCoord2dv := load('glEvalCoord2dv');
  glEvalCoord2f := load('glEvalCoord2f');
  glEvalCoord2fv := load('glEvalCoord2fv');
  glEvalMesh1 := load('glEvalMesh1');
  glEvalPoint1 := load('glEvalPoint1');
  glEvalMesh2 := load('glEvalMesh2');
  glEvalPoint2 := load('glEvalPoint2');
  glAlphaFunc := load('glAlphaFunc');
  glPixelZoom := load('glPixelZoom');
  glPixelTransferf := load('glPixelTransferf');
  glPixelTransferi := load('glPixelTransferi');
  glPixelMapfv := load('glPixelMapfv');
  glPixelMapuiv := load('glPixelMapuiv');
  glPixelMapusv := load('glPixelMapusv');
  glCopyPixels := load('glCopyPixels');
  glDrawPixels := load('glDrawPixels');
  glGetClipPlane := load('glGetClipPlane');
  glGetLightfv := load('glGetLightfv');
  glGetLightiv := load('glGetLightiv');
  glGetMapdv := load('glGetMapdv');
  glGetMapfv := load('glGetMapfv');
  glGetMapiv := load('glGetMapiv');
  glGetMaterialfv := load('glGetMaterialfv');
  glGetMaterialiv := load('glGetMaterialiv');
  glGetPixelMapfv := load('glGetPixelMapfv');
  glGetPixelMapuiv := load('glGetPixelMapuiv');
  glGetPixelMapusv := load('glGetPixelMapusv');
  glGetPolygonStipple := load('glGetPolygonStipple');
  glGetTexEnvfv := load('glGetTexEnvfv');
  glGetTexEnviv := load('glGetTexEnviv');
  glGetTexGendv := load('glGetTexGendv');
  glGetTexGenfv := load('glGetTexGenfv');
  glGetTexGeniv := load('glGetTexGeniv');
  glIsList := load('glIsList');
  glFrustum := load('glFrustum');
  glLoadIdentity := load('glLoadIdentity');
  glLoadMatrixf := load('glLoadMatrixf');
  glLoadMatrixd := load('glLoadMatrixd');
  glMatrixMode := load('glMatrixMode');
  glMultMatrixf := load('glMultMatrixf');
  glMultMatrixd := load('glMultMatrixd');
  glOrtho := load('glOrtho');
  glPopMatrix := load('glPopMatrix');
  glPushMatrix := load('glPushMatrix');
  glRotated := load('glRotated');
  glRotatef := load('glRotatef');
  glScaled := load('glScaled');
  glScalef := load('glScalef');
  glTranslated := load('glTranslated');
  glTranslatef := load('glTranslatef');
end;

procedure load_GL_VERSION_1_1(load: TLoadProc);
begin
  if not GLAD_GL_VERSION_1_1 then exit;
  glDrawArrays := load('glDrawArrays');
  glDrawElements := load('glDrawElements');
  glGetPointerv := load('glGetPointerv');
  glPolygonOffset := load('glPolygonOffset');
  glCopyTexImage1D := load('glCopyTexImage1D');
  glCopyTexImage2D := load('glCopyTexImage2D');
  glCopyTexSubImage1D := load('glCopyTexSubImage1D');
  glCopyTexSubImage2D := load('glCopyTexSubImage2D');
  glTexSubImage1D := load('glTexSubImage1D');
  glTexSubImage2D := load('glTexSubImage2D');
  glBindTexture := load('glBindTexture');
  glDeleteTextures := load('glDeleteTextures');
  glGenTextures := load('glGenTextures');
  glIsTexture := load('glIsTexture');
  glArrayElement := load('glArrayElement');
  glColorPointer := load('glColorPointer');
  glDisableClientState := load('glDisableClientState');
  glEdgeFlagPointer := load('glEdgeFlagPointer');
  glEnableClientState := load('glEnableClientState');
  glIndexPointer := load('glIndexPointer');
  glInterleavedArrays := load('glInterleavedArrays');
  glNormalPointer := load('glNormalPointer');
  glTexCoordPointer := load('glTexCoordPointer');
  glVertexPointer := load('glVertexPointer');
  glAreTexturesResident := load('glAreTexturesResident');
  glPrioritizeTextures := load('glPrioritizeTextures');
  glIndexub := load('glIndexub');
  glIndexubv := load('glIndexubv');
  glPopClientAttrib := load('glPopClientAttrib');
  glPushClientAttrib := load('glPushClientAttrib');
end;

procedure load_GL_VERSION_1_2(load: TLoadProc);
begin
  if not GLAD_GL_VERSION_1_2 then exit;
  glDrawRangeElements := load('glDrawRangeElements');
  glTexImage3D := load('glTexImage3D');
  glTexSubImage3D := load('glTexSubImage3D');
  glCopyTexSubImage3D := load('glCopyTexSubImage3D');
end;

procedure load_GL_VERSION_1_3(load: TLoadProc);
begin
  if not GLAD_GL_VERSION_1_3 then exit;
  glActiveTexture := load('glActiveTexture');
  glSampleCoverage := load('glSampleCoverage');
  glCompressedTexImage3D := load('glCompressedTexImage3D');
  glCompressedTexImage2D := load('glCompressedTexImage2D');
  glCompressedTexImage1D := load('glCompressedTexImage1D');
  glCompressedTexSubImage3D := load('glCompressedTexSubImage3D');
  glCompressedTexSubImage2D := load('glCompressedTexSubImage2D');
  glCompressedTexSubImage1D := load('glCompressedTexSubImage1D');
  glGetCompressedTexImage := load('glGetCompressedTexImage');
  glClientActiveTexture := load('glClientActiveTexture');
  glMultiTexCoord1d := load('glMultiTexCoord1d');
  glMultiTexCoord1dv := load('glMultiTexCoord1dv');
  glMultiTexCoord1f := load('glMultiTexCoord1f');
  glMultiTexCoord1fv := load('glMultiTexCoord1fv');
  glMultiTexCoord1i := load('glMultiTexCoord1i');
  glMultiTexCoord1iv := load('glMultiTexCoord1iv');
  glMultiTexCoord1s := load('glMultiTexCoord1s');
  glMultiTexCoord1sv := load('glMultiTexCoord1sv');
  glMultiTexCoord2d := load('glMultiTexCoord2d');
  glMultiTexCoord2dv := load('glMultiTexCoord2dv');
  glMultiTexCoord2f := load('glMultiTexCoord2f');
  glMultiTexCoord2fv := load('glMultiTexCoord2fv');
  glMultiTexCoord2i := load('glMultiTexCoord2i');
  glMultiTexCoord2iv := load('glMultiTexCoord2iv');
  glMultiTexCoord2s := load('glMultiTexCoord2s');
  glMultiTexCoord2sv := load('glMultiTexCoord2sv');
  glMultiTexCoord3d := load('glMultiTexCoord3d');
  glMultiTexCoord3dv := load('glMultiTexCoord3dv');
  glMultiTexCoord3f := load('glMultiTexCoord3f');
  glMultiTexCoord3fv := load('glMultiTexCoord3fv');
  glMultiTexCoord3i := load('glMultiTexCoord3i');
  glMultiTexCoord3iv := load('glMultiTexCoord3iv');
  glMultiTexCoord3s := load('glMultiTexCoord3s');
  glMultiTexCoord3sv := load('glMultiTexCoord3sv');
  glMultiTexCoord4d := load('glMultiTexCoord4d');
  glMultiTexCoord4dv := load('glMultiTexCoord4dv');
  glMultiTexCoord4f := load('glMultiTexCoord4f');
  glMultiTexCoord4fv := load('glMultiTexCoord4fv');
  glMultiTexCoord4i := load('glMultiTexCoord4i');
  glMultiTexCoord4iv := load('glMultiTexCoord4iv');
  glMultiTexCoord4s := load('glMultiTexCoord4s');
  glMultiTexCoord4sv := load('glMultiTexCoord4sv');
  glLoadTransposeMatrixf := load('glLoadTransposeMatrixf');
  glLoadTransposeMatrixd := load('glLoadTransposeMatrixd');
  glMultTransposeMatrixf := load('glMultTransposeMatrixf');
  glMultTransposeMatrixd := load('glMultTransposeMatrixd');
end;

procedure load_GL_VERSION_1_4(load: TLoadProc);
begin
  if not GLAD_GL_VERSION_1_4 then exit;
  glBlendFuncSeparate := load('glBlendFuncSeparate');
  glMultiDrawArrays := load('glMultiDrawArrays');
  glMultiDrawElements := load('glMultiDrawElements');
  glPointParameterf := load('glPointParameterf');
  glPointParameterfv := load('glPointParameterfv');
  glPointParameteri := load('glPointParameteri');
  glPointParameteriv := load('glPointParameteriv');
  glFogCoordf := load('glFogCoordf');
  glFogCoordfv := load('glFogCoordfv');
  glFogCoordd := load('glFogCoordd');
  glFogCoorddv := load('glFogCoorddv');
  glFogCoordPointer := load('glFogCoordPointer');
  glSecondaryColor3b := load('glSecondaryColor3b');
  glSecondaryColor3bv := load('glSecondaryColor3bv');
  glSecondaryColor3d := load('glSecondaryColor3d');
  glSecondaryColor3dv := load('glSecondaryColor3dv');
  glSecondaryColor3f := load('glSecondaryColor3f');
  glSecondaryColor3fv := load('glSecondaryColor3fv');
  glSecondaryColor3i := load('glSecondaryColor3i');
  glSecondaryColor3iv := load('glSecondaryColor3iv');
  glSecondaryColor3s := load('glSecondaryColor3s');
  glSecondaryColor3sv := load('glSecondaryColor3sv');
  glSecondaryColor3ub := load('glSecondaryColor3ub');
  glSecondaryColor3ubv := load('glSecondaryColor3ubv');
  glSecondaryColor3ui := load('glSecondaryColor3ui');
  glSecondaryColor3uiv := load('glSecondaryColor3uiv');
  glSecondaryColor3us := load('glSecondaryColor3us');
  glSecondaryColor3usv := load('glSecondaryColor3usv');
  glSecondaryColorPointer := load('glSecondaryColorPointer');
  glWindowPos2d := load('glWindowPos2d');
  glWindowPos2dv := load('glWindowPos2dv');
  glWindowPos2f := load('glWindowPos2f');
  glWindowPos2fv := load('glWindowPos2fv');
  glWindowPos2i := load('glWindowPos2i');
  glWindowPos2iv := load('glWindowPos2iv');
  glWindowPos2s := load('glWindowPos2s');
  glWindowPos2sv := load('glWindowPos2sv');
  glWindowPos3d := load('glWindowPos3d');
  glWindowPos3dv := load('glWindowPos3dv');
  glWindowPos3f := load('glWindowPos3f');
  glWindowPos3fv := load('glWindowPos3fv');
  glWindowPos3i := load('glWindowPos3i');
  glWindowPos3iv := load('glWindowPos3iv');
  glWindowPos3s := load('glWindowPos3s');
  glWindowPos3sv := load('glWindowPos3sv');
  glBlendColor := load('glBlendColor');
  glBlendEquation := load('glBlendEquation');
end;

procedure load_GL_VERSION_1_5(load: TLoadProc);
begin
  if not GLAD_GL_VERSION_1_5 then exit;
  glGenQueries := load('glGenQueries');
  glDeleteQueries := load('glDeleteQueries');
  glIsQuery := load('glIsQuery');
  glBeginQuery := load('glBeginQuery');
  glEndQuery := load('glEndQuery');
  glGetQueryiv := load('glGetQueryiv');
  glGetQueryObjectiv := load('glGetQueryObjectiv');
  glGetQueryObjectuiv := load('glGetQueryObjectuiv');
  glBindBuffer := load('glBindBuffer');
  glDeleteBuffers := load('glDeleteBuffers');
  glGenBuffers := load('glGenBuffers');
  glIsBuffer := load('glIsBuffer');
  glBufferData := load('glBufferData');
  glBufferSubData := load('glBufferSubData');
  glGetBufferSubData := load('glGetBufferSubData');
  glMapBuffer := load('glMapBuffer');
  glUnmapBuffer := load('glUnmapBuffer');
  glGetBufferParameteriv := load('glGetBufferParameteriv');
  glGetBufferPointerv := load('glGetBufferPointerv');
end;

procedure load_GL_VERSION_2_0(load: TLoadProc);
begin
  if not GLAD_GL_VERSION_2_0 then exit;
  glBlendEquationSeparate := load('glBlendEquationSeparate');
  glDrawBuffers := load('glDrawBuffers');
  glStencilOpSeparate := load('glStencilOpSeparate');
  glStencilFuncSeparate := load('glStencilFuncSeparate');
  glStencilMaskSeparate := load('glStencilMaskSeparate');
  glAttachShader := load('glAttachShader');
  glBindAttribLocation := load('glBindAttribLocation');
  glCompileShader := load('glCompileShader');
  glCreateProgram := load('glCreateProgram');
  glCreateShader := load('glCreateShader');
  glDeleteProgram := load('glDeleteProgram');
  glDeleteShader := load('glDeleteShader');
  glDetachShader := load('glDetachShader');
  glDisableVertexAttribArray := load('glDisableVertexAttribArray');
  glEnableVertexAttribArray := load('glEnableVertexAttribArray');
  glGetActiveAttrib := load('glGetActiveAttrib');
  glGetActiveUniform := load('glGetActiveUniform');
  glGetAttachedShaders := load('glGetAttachedShaders');
  glGetAttribLocation := load('glGetAttribLocation');
  glGetProgramiv := load('glGetProgramiv');
  glGetProgramInfoLog := load('glGetProgramInfoLog');
  glGetShaderiv := load('glGetShaderiv');
  glGetShaderInfoLog := load('glGetShaderInfoLog');
  glGetShaderSource := load('glGetShaderSource');
  glGetUniformLocation := load('glGetUniformLocation');
  glGetUniformfv := load('glGetUniformfv');
  glGetUniformiv := load('glGetUniformiv');
  glGetVertexAttribdv := load('glGetVertexAttribdv');
  glGetVertexAttribfv := load('glGetVertexAttribfv');
  glGetVertexAttribiv := load('glGetVertexAttribiv');
  glGetVertexAttribPointerv := load('glGetVertexAttribPointerv');
  glIsProgram := load('glIsProgram');
  glIsShader := load('glIsShader');
  glLinkProgram := load('glLinkProgram');
  glShaderSource := load('glShaderSource');
  glUseProgram := load('glUseProgram');
  glUniform1f := load('glUniform1f');
  glUniform2f := load('glUniform2f');
  glUniform3f := load('glUniform3f');
  glUniform4f := load('glUniform4f');
  glUniform1i := load('glUniform1i');
  glUniform2i := load('glUniform2i');
  glUniform3i := load('glUniform3i');
  glUniform4i := load('glUniform4i');
  glUniform1fv := load('glUniform1fv');
  glUniform2fv := load('glUniform2fv');
  glUniform3fv := load('glUniform3fv');
  glUniform4fv := load('glUniform4fv');
  glUniform1iv := load('glUniform1iv');
  glUniform2iv := load('glUniform2iv');
  glUniform3iv := load('glUniform3iv');
  glUniform4iv := load('glUniform4iv');
  glUniformMatrix2fv := load('glUniformMatrix2fv');
  glUniformMatrix3fv := load('glUniformMatrix3fv');
  glUniformMatrix4fv := load('glUniformMatrix4fv');
  glValidateProgram := load('glValidateProgram');
  glVertexAttrib1d := load('glVertexAttrib1d');
  glVertexAttrib1dv := load('glVertexAttrib1dv');
  glVertexAttrib1f := load('glVertexAttrib1f');
  glVertexAttrib1fv := load('glVertexAttrib1fv');
  glVertexAttrib1s := load('glVertexAttrib1s');
  glVertexAttrib1sv := load('glVertexAttrib1sv');
  glVertexAttrib2d := load('glVertexAttrib2d');
  glVertexAttrib2dv := load('glVertexAttrib2dv');
  glVertexAttrib2f := load('glVertexAttrib2f');
  glVertexAttrib2fv := load('glVertexAttrib2fv');
  glVertexAttrib2s := load('glVertexAttrib2s');
  glVertexAttrib2sv := load('glVertexAttrib2sv');
  glVertexAttrib3d := load('glVertexAttrib3d');
  glVertexAttrib3dv := load('glVertexAttrib3dv');
  glVertexAttrib3f := load('glVertexAttrib3f');
  glVertexAttrib3fv := load('glVertexAttrib3fv');
  glVertexAttrib3s := load('glVertexAttrib3s');
  glVertexAttrib3sv := load('glVertexAttrib3sv');
  glVertexAttrib4Nbv := load('glVertexAttrib4Nbv');
  glVertexAttrib4Niv := load('glVertexAttrib4Niv');
  glVertexAttrib4Nsv := load('glVertexAttrib4Nsv');
  glVertexAttrib4Nub := load('glVertexAttrib4Nub');
  glVertexAttrib4Nubv := load('glVertexAttrib4Nubv');
  glVertexAttrib4Nuiv := load('glVertexAttrib4Nuiv');
  glVertexAttrib4Nusv := load('glVertexAttrib4Nusv');
  glVertexAttrib4bv := load('glVertexAttrib4bv');
  glVertexAttrib4d := load('glVertexAttrib4d');
  glVertexAttrib4dv := load('glVertexAttrib4dv');
  glVertexAttrib4f := load('glVertexAttrib4f');
  glVertexAttrib4fv := load('glVertexAttrib4fv');
  glVertexAttrib4iv := load('glVertexAttrib4iv');
  glVertexAttrib4s := load('glVertexAttrib4s');
  glVertexAttrib4sv := load('glVertexAttrib4sv');
  glVertexAttrib4ubv := load('glVertexAttrib4ubv');
  glVertexAttrib4uiv := load('glVertexAttrib4uiv');
  glVertexAttrib4usv := load('glVertexAttrib4usv');
  glVertexAttribPointer := load('glVertexAttribPointer');
end;

procedure load_GL_VERSION_2_1(load: TLoadProc);
begin
  if not GLAD_GL_VERSION_2_1 then exit;
  glUniformMatrix2x3fv := load('glUniformMatrix2x3fv');
  glUniformMatrix3x2fv := load('glUniformMatrix3x2fv');
  glUniformMatrix2x4fv := load('glUniformMatrix2x4fv');
  glUniformMatrix4x2fv := load('glUniformMatrix4x2fv');
  glUniformMatrix3x4fv := load('glUniformMatrix3x4fv');
  glUniformMatrix4x3fv := load('glUniformMatrix4x3fv');
end;

procedure findExtensionsGL();
begin
end;

procedure findCoreGL(glVersion: string);
const
  prefixes: array[0..2] of string = ('OpenGL ES-CM ', 'OpenGL ES-CL ', 'OpenGL ES ');
var
  version, p: string;
  major, minor: integer;
begin
  version := glVersion;
  for p in prefixes do
    if LeftStr(version, length(p)) = p then begin
      version := StringReplace(version, p, '', [rfReplaceAll]);
      break;
    end;

  major := ord(version[1]) - ord('0');
  minor := ord(version[3]) - ord('0');

  glVersionMajor := major;
  glVersionMinor := minor;

  GLAD_GL_VERSION_1_0 := ((major = 1) and (minor >= 0)) or (major > 1);
  GLAD_GL_VERSION_1_1 := ((major = 1) and (minor >= 1)) or (major > 1);
  GLAD_GL_VERSION_1_2 := ((major = 1) and (minor >= 2)) or (major > 1);
  GLAD_GL_VERSION_1_3 := ((major = 1) and (minor >= 3)) or (major > 1);
  GLAD_GL_VERSION_1_4 := ((major = 1) and (minor >= 4)) or (major > 1);
  GLAD_GL_VERSION_1_5 := ((major = 1) and (minor >= 5)) or (major > 1);
  GLAD_GL_VERSION_2_0 := ((major = 2) and (minor >= 0)) or (major > 2);
  GLAD_GL_VERSION_2_1 := ((major = 2) and (minor >= 1)) or (major > 2);
end;

function gladLoadGL(load: TLoadProc): boolean;
var
  glVersion: PAnsiChar;
begin
  glGetString := load('glGetString');
  if not Assigned(glGetString) then exit(false);
  glVersion := PAnsiChar( glGetString(GL_VERSION) );
  if glVersion = nil then exit(false);

  findCoreGL(string(glVersion));
  load_GL_VERSION_1_0(load);
  load_GL_VERSION_1_1(load);
  load_GL_VERSION_1_2(load);
  load_GL_VERSION_1_3(load);
  load_GL_VERSION_1_4(load);
  load_GL_VERSION_1_5(load);
  load_GL_VERSION_2_0(load);
  load_GL_VERSION_2_1(load);

  findExtensionsGL();

  result := (glVersionMajor <> 0) or (glVersionMinor <> 0);
end;

function loadGLProc(proc: PAnsiChar): Pointer; cdecl;
begin
  Result := Pointer(glfwGetProcAddress(proc));
end;

function LoadOpenGL(): Boolean;
begin
  Result := False;
  if glfwGetCurrentContext() = nil then Exit;
  Result := gladLoadGL(@loadGLProc);
end;

initialization
begin

end;

finalization
begin

end;

end.


