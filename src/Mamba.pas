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

unit Mamba;

{$I Mamba.Defines.inc}

interface

{$REGION ' MISC '}
//=== MISC ==================================================================
const
  { Version }
  MGT_VERSION_MAJOR = '0';
  MGT_VERSION_MINOR = '1';
  MGT_VERSION_PATCH = '0';
  MGT_VERSION_FULL  = MGT_VERSION_MAJOR + '.' + MGT_VERSION_MINOR + '.' + MGT_VERSION_PATCH;

type
  { TCharSet }
  TCharSet = set of AnsiChar;

  { THAlign }
  THAlign = (haLeft, haCenter, haRight);

  { TVAlign }
  TVAlign = (vaTop, vaCenter, vaBottom);
{$ENDREGION}

{$REGION ' BASE '}
//=== BASEINTERFACE =========================================================
type
  { IBaseInterface }
  IBaseInterface = interface
    ['{29D01AA3-E370-4EB0-B258-FB9D17BB090A}']
    function  GetTag(): string;
    procedure SetTag(const ATag: string);
  end;

type
  { TBaseInterface }
  TBaseInterface = class(TNoRefCountObject, IBaseInterface)
  protected
    FTag: string;
  public
    constructor Create(); virtual;
    destructor Destroy(); override;
    function  GetTag(): string;
    procedure SetTag(const ATag: string);
  end;

  { TBaseInterfaceClass }
  TBaseInterfaceClass = class of TBaseInterface;

//=== BASEOBJECT ==========================================================
type
  { TBaseObject }
  TBaseObject = class(TObject)
  public
    constructor Create(); virtual;
    destructor Destroy(); override;
  end;

//=== INTERFACEFACTORY ======================================================
function IRegister(const AGUID: TGUID; const AClass: TBaseInterfaceClass): Boolean;
function IGet(const AGUID: TGUID; const [ref] AInterface: IBaseInterface): Boolean;
function IRelease(const [ref] AInterface: IBaseInterface): Boolean;
function ICount(): NativeInt;
{$ENDREGION}

{$REGION ' CONSOLE '}
//=== CONSOLE ===============================================================
const
  LF   = #10;
  CR   = #13;
  CRLF = LF+CR;
  ESC  = #27;

  VK_ESC = 27;

  // Cursor Movement
  CSICursorPos = ESC + '[%d;%dH';         // Set cursor position
  CSICursorUp = ESC + '[%dA';             // Move cursor up
  CSICursorDown = ESC + '[%dB';           // Move cursor down
  CSICursorForward = ESC + '[%dC';        // Move cursor forward
  CSICursorBack = ESC + '[%dD';           // Move cursor backward
  CSISaveCursorPos = ESC + '[s';          // Save cursor position
  CSIRestoreCursorPos = ESC + '[u';       // Restore cursor position

  // Cursor Visibility
  CSIShowCursor = ESC + '[?25h';          // Show cursor
  CSIHideCursor = ESC + '[?25l';          // Hide cursor
  CSIBlinkCursor = ESC + '[?12h';         // Enable cursor blinking
  CSISteadyCursor = ESC + '[?12l';        // Disable cursor blinking

  // Screen Manipulation
  CSIClearScreen = ESC + '[2J';           // Clear screen
  CSIClearLine = ESC + '[2K';             // Clear line
  CSIScrollUp = ESC + '[%dS';             // Scroll up by n lines
  CSIScrollDown = ESC + '[%dT';           // Scroll down by n lines

  // Text Formatting
  CSIBold = ESC + '[1m';                  // Bold text
  CSIUnderline = ESC + '[4m';             // Underline text
  CSIResetFormat = ESC + '[0m';           // Reset text formatting
  CSIResetBackground = #27'[49m';         // Reset background text formatting
  CSIResetForeground = #27'[39m';         // Reset forground text formatting
  CSIInvertColors = ESC + '[7m';          // Invert foreground/background
  CSINormalColors = ESC + '[27m';         // Normal colors

  CSIDim = ESC + '[2m';
  CSIItalic = ESC + '[3m';
  CSIBlink = ESC + '[5m';
  CSIFramed = ESC + '[51m';
  CSIEncircled = ESC + '[52m';

  // Text Modification
  CSIInsertChar = ESC + '[%d@';           // Insert n spaces at cursor position
  CSIDeleteChar = ESC + '[%dP';           // Delete n characters at cursor position
  CSIEraseChar = ESC + '[%dX';            // Erase n characters at cursor position

  // Colors (Foreground and Background)
  CSIFGBlack = ESC + '[30m';
  CSIFGRed = ESC + '[31m';
  CSIFGGreen = ESC + '[32m';
  CSIFGYellow = ESC + '[33m';
  CSIFGBlue = ESC + '[34m';
  CSIFGMagenta = ESC + '[35m';
  CSIFGCyan = ESC + '[36m';
  CSIFGWhite = ESC + '[37m';

  CSIBGBlack = ESC + '[40m';
  CSIBGRed = ESC + '[41m';
  CSIBGGreen = ESC + '[42m';
  CSIBGYellow = ESC + '[43m';
  CSIBGBlue = ESC + '[44m';
  CSIBGMagenta = ESC + '[45m';
  CSIBGCyan = ESC + '[46m';
  CSIBGWhite = ESC + '[47m';

  CSIFGBrightBlack = ESC + '[90m';
  CSIFGBrightRed = ESC + '[91m';
  CSIFGBrightGreen = ESC + '[92m';
  CSIFGBrightYellow = ESC + '[93m';
  CSIFGBrightBlue = ESC + '[94m';
  CSIFGBrightMagenta = ESC + '[95m';
  CSIFGBrightCyan = ESC + '[96m';
  CSIFGBrightWhite = ESC + '[97m';

  CSIBGBrightBlack = ESC + '[100m';
  CSIBGBrightRed = ESC + '[101m';
  CSIBGBrightGreen = ESC + '[102m';
  CSIBGBrightYellow = ESC + '[103m';
  CSIBGBrightBlue = ESC + '[104m';
  CSIBGBrightMagenta = ESC + '[105m';
  CSIBGBrightCyan = ESC + '[106m';
  CSIBGBrightWhite = ESC + '[107m';

  CSIFGRGB = ESC + '[38;2;%d;%d;%dm';        // Foreground RGB
  CSIBGRGB = ESC + '[48;2;%d;%d;%dm';        // Backg

type
  { IConsole }
  IConsole = interface(IBaseInterface)
    ['{82F1D4EE-3518-48DF-90A9-29350CD7D052}']
    procedure Print(const AMsg: string; const AArgs: array of const); overload;
    procedure PrintLn(const AMsg: string; const AArgs: array of const); overload;

    procedure Print(); overload;
    procedure PrintLn(); overload;

    procedure GetCursorPos(X, Y: PInteger);
    procedure SetCursorPos(const X, Y: Integer);
    procedure SetCursorVisible(const AVisible: Boolean);
    procedure HideCursor();
    procedure ShowCursor();
    procedure SaveCursorPos();
    procedure RestoreCursorPos();
    procedure MoveCursorUp(const ALines: Integer);
    procedure MoveCursorDown(const ALines: Integer);
    procedure MoveCursorForward(const ACols: Integer);
    procedure MoveCursorBack(const ACols: Integer);

    procedure ClearScreen();
    procedure ClearLine();
    procedure ClearLineFromCursor(const AColor: string);

    procedure SetBoldText();
    procedure ResetTextFormat();
    procedure SetForegroundColor(const AColor: string);
    procedure SetBackgroundColor(const AColor: string);
    procedure SetForegroundRGB(const ARed, AGreen, ABlue: Byte);
    procedure SetBackgroundRGB(const ARed, AGreen, ABlue: Byte);

    procedure GetSize(AWidth: PInteger; AHeight: PInteger);

    procedure SetTitle(const ATitle: string);
    function  GetTitle(): string;

    function  HasOutput: Boolean;
    function  WasRunFrom(): Boolean;
    procedure WaitForAnyKey();
    function  AnyKeyPressed(): Boolean;

    procedure ClearKeyStates();
    procedure ClearKeyboardBuffer();

    function  IsKeyPressed(AKey: Byte): Boolean;
    function  WasKeyReleased(AKey: Byte): Boolean;
    function  WasKeyPressed(AKey: Byte): Boolean;

    function  ReadKey(): WideChar;
    function  ReadLnX(const AAllowedChars: TCharSet; AMaxLength: Integer; const AColor: string=CSIFGWhite): string;

    procedure Pause(const AForcePause: Boolean=False; AColor: string=CSIFGWhite; const AMsg: string='');

    function  WrapTextEx(const ALine: string; AMaxCol: Integer; const ABreakChars: TCharSet=[' ', '-', ',', ':', #9]): string;
    procedure Teletype(const AText: string; const AColor: string=CSIFGWhite; const AMargin: Integer=10; const AMinDelay: Integer=0; const AMaxDelay: Integer=3; const ABreakKey: Byte=VK_ESC);
  end;

var
  { Console }
  Console: IConsole = nil;
{$ENDREGION}

{$REGION ' MATH '}
//=== MATH ==================================================================
const
  RADTODEG = 180.0 / PI;
  DEGTORAD = PI / 180.0;
  EPSILON  = 0.00001;
  NAN      =  0.0 / 0.0;
  KILOBYTE = 1024;                     // 1 KB = 1024 bytes
  MEGABYTE = 1024 * 1024;              // 1 MB = 1024 * 1024 bytes
  GIGABYTE = 1024 * 1024 * 1024;       // 1 GB = 1024 * 1024 * 1024 bytes

type
  { TVector }
  PVector = ^TVector;
  TVector = record
    x,y,z,w: Single;
  end;

  { TPoint }
  PPoint = ^TPoint;
  TPoint = record
    x,y: Single;
  end;

  { TSize }
  PSize = ^TSize;
  TSize = record
    w,h: Single;
  end;

  { TRect }
  PRect = ^TRect;
  TRect = record
    pos: TPoint;
    size: TSize;
  end;

  { TExtent }
  PExtent = ^TExtent;
  TExtent = record
    min: TPoint;
    max: TPoint;
  end;

  { TOBB }
  POBB = ^TOBB;
  TOBB = record
    Center: TPoint;
    Extents: TPoint;
    Rotation: Single;
  end;


  { TLineIntersection }
  TLineIntersection = (liNone, liTrue, liParallel);

  { TEaseType }
  TEaseType = (etLinearTween, etInQuad, etOutQuad, etInOutQuad, etInCubic,
    etOutCubic, etInOutCubic, etInQuart, etOutQuart, etInOutQuart, etInQuint,
    etOutQuint, etInOutQuint, etInSine, etOutSine, etInOutSine, etInExpo,
    etOutExpo, etInOutExpo, etInCircle, etOutCircle, etInOutCircle);

  IMath = interface(IBaseInterface)
    ['{D31CB56D-3FE7-4A7D-989D-E34F25335595}']

    function  Point(const X, Y: Single): TPoint;
    function  Vector(const X, Y: Single): TVector; overload;
    function  Size(const W, H: Single): TSize;
    function  Rect(const X, Y, W, H: Single): TRect;
    function  Extent(const AMinX, AMinY, AMaxX, AMaxY: Single): TExtent;

    procedure AssignVector(var A: TVector; const B: TVector); overload;
    procedure ClearVector(var A: TVector);
    procedure AddVector(var A: TVector; const B: TVector);
    procedure SubVector(var A: TVector; const B: TVector);
    procedure MulVector(var A: TVector; const B: TVector);
    procedure DivideVector(var A: TVector; const B: TVector); overload;
    procedure DivideVictor(var A: TVector; const AValue: Single); overload;
    function  VectorMagnitude(const A: TVector): Single;
    function  VectorMagnitudeTruncate(const A: TVector; const AMaxMagnitude: Single): TVector;
    function  VectorDistance(const A, B: TVector): Single;
    procedure NormalizeVector(var A: TVector);
    function  VectorAngle(const A, B: TVector): Single;
    procedure ThrustVector(var A: TVector; const AAngle, ASpeed: Single);
    function  VectorMagnitudeSquared(const A: TVector): Single;
    function  VectorDotProduct(const A, B: TVector): Single;
    procedure ScaleVectory(var A: TVector; const AValue: Single);
    function  ProjectVector(const A, B: TVector): TVector;
    procedure NegateVector(var A: TVector);

    function  UnitToScalarValue(const AValue, AMaxValue: Double): Double;

    function  AngleCos(const AAngle: Cardinal): Single;
    function  AngleSin(const AAngle: Cardinal): Single;

    function  RandomRange(const AMin, AMax: Integer): Integer;
    function  RandomRangef(const AMin, AMax: Single): Single;
    function  RandomBool(): Boolean;
    function  GetRandomSeed(): Integer;
    procedure SetRandomSeed(const AVaLue: Integer);
    function  ClipVaLuef(var AVaLue: Single; const AMin, AMax: Single; const AWrap: Boolean): Single;
    function  ClipVaLue(var AVaLue: Integer; const aMin, AMax: Integer; const AWrap: Boolean): Integer;
    function  SameSign(const AVaLue1, AVaLue2: Integer): Boolean;
    function  SameSignf(const AVaLue1, AVaLue2: Single): Boolean;
    function  SameVaLue(const AA, AB: Double; const AEpsilon: Double = 0): Boolean;
    function  SameVaLuef(const AA, AB: Single; const AEpsilon: Single = 0): Boolean;
    function  AngleDiff(const ASrcAngle, ADestAngle: Single): Single;
    procedure AngleRotatePos(const AAngle: Single; var AX, AY: Single);
    procedure SmoothMove(var AVaLue: Single; const AAmount, AMax, ADrag: Single);
    function  Lerp(const AFrom, ATo, ATime: Double): Double;
    function  PointInRectangle(APoint: TVector; ARect: TRect): Boolean;
    function  PointInCircle(APoint, ACenter: TVector; ARadius: Single): Boolean;
    function  PointInTriangle(APoint, AP1, AP2, AP3: TVector): Boolean;
    function  CirclesOverlap(ACenter1: TVector; ARadius1: Single; ACenter2: TVector; ARadius2: Single): Boolean;
    function  CircleInRectangle(ACenter: TVector; ARadius: Single; ARect: TRect): Boolean;
    function  RectanglesOverlap(ARect1: TRect; ARect2: TRect): Boolean;
    function  RectangleIntersection(ARect1, ARect2: TRect): TRect;
    function  LineIntersection(AX1, AY1, AX2, AY2, AX3, AY3, AX4, AY4: Integer; var AX: Integer; var AY: Integer): TLineIntersection;
    function  RadiusOverlap(ARadius1, AX1, AY1, ARadius2, AX2, AY2, AShrinkFactor: Single): Boolean;
    function  EaseValue(ACurrentTime: Double; AStartValue: Double; AChangeInValue: Double; ADuration: Double; AEaseType: TEaseType): Double;
    function  EasePosition(AStartPos: Double; AEndPos: Double; ACurrentPos: Double; AEaseType: TEaseType): Double;

    function OBBIntersect(const AObbA, AObbB: TOBB): Boolean;
  end;

var
  { Math }
  Math: IMath = nil;
{$ENDREGION}

{$REGION ' COLOR '}
//=== COLOR =================================================================
type
  { TColor }
  PColor = ^TColor;
  TColor = record
    r,g,b,a: Single;
  end;

  { IColor }
  IColor = interface(IBaseInterface)
    ['{88AA7EDA-04B7-40B1-B9A0-416E7C640309}']
    function  FromByte(const r, g, b, a: Byte): TColor;
    function  FromFloat(const r, g, b, a: Single): TColor;
    function  Fade(const AFrom, ATo: TColor; const APos: Single): TColor;
    function  IsEqual(const AColor1, AColor2: TColor): Boolean;
  end;

var
  Color: IColor = nil;

{$REGION 'Common Colors'}
const
  ALICEBLUE           : TColor = (r:$F0/$FF; g:$F8/$FF; b:$FF/$FF; a:$FF/$FF);
  ANTIQUEWHITE        : TColor = (r:$FA/$FF; g:$EB/$FF; b:$D7/$FF; a:$FF/$FF);
  AQUA                : TColor = (r:$00/$FF; g:$FF/$FF; b:$FF/$FF; a:$FF/$FF);
  AQUAMARINE          : TColor = (r:$7F/$FF; g:$FF/$FF; b:$D4/$FF; a:$FF/$FF);
  AZURE               : TColor = (r:$F0/$FF; g:$FF/$FF; b:$FF/$FF; a:$FF/$FF);
  BEIGE               : TColor = (r:$F5/$FF; g:$F5/$FF; b:$DC/$FF; a:$FF/$FF);
  BISQUE              : TColor = (r:$FF/$FF; g:$E4/$FF; b:$C4/$FF; a:$FF/$FF);
  BLACK               : TColor = (r:$00/$FF; g:$00/$FF; b:$00/$FF; a:$FF/$FF);
  BLANCHEDALMOND      : TColor = (r:$FF/$FF; g:$EB/$FF; b:$CD/$FF; a:$FF/$FF);
  BLUE                : TColor = (r:$00/$FF; g:$00/$FF; b:$FF/$FF; a:$FF/$FF);
  BLUEVIOLET          : TColor = (r:$8A/$FF; g:$2B/$FF; b:$E2/$FF; a:$FF/$FF);
  BROWN               : TColor = (r:$A5/$FF; g:$2A/$FF; b:$2A/$FF; a:$FF/$FF);
  BURLYWOOD           : TColor = (r:$DE/$FF; g:$B8/$FF; b:$87/$FF; a:$FF/$FF);
  CADETBLUE           : TColor = (r:$5F/$FF; g:$9E/$FF; b:$A0/$FF; a:$FF/$FF);
  CHARTREUSE          : TColor = (r:$7F/$FF; g:$FF/$FF; b:$00/$FF; a:$FF/$FF);
  CHOCOLATE           : TColor = (r:$D2/$FF; g:$69/$FF; b:$1E/$FF; a:$FF/$FF);
  CORAL               : TColor = (r:$FF/$FF; g:$7F/$FF; b:$50/$FF; a:$FF/$FF);
  CORNFLOWERBLUE      : TColor = (r:$64/$FF; g:$95/$FF; b:$ED/$FF; a:$FF/$FF);
  CORNSILK            : TColor = (r:$FF/$FF; g:$F8/$FF; b:$DC/$FF; a:$FF/$FF);
  CRIMSON             : TColor = (r:$DC/$FF; g:$14/$FF; b:$3C/$FF; a:$FF/$FF);
  CYAN                : TColor = (r:$00/$FF; g:$FF/$FF; b:$FF/$FF; a:$FF/$FF);
  DARKBLUE            : TColor = (r:$00/$FF; g:$00/$FF; b:$8B/$FF; a:$FF/$FF);
  DARKCYAN            : TColor = (r:$00/$FF; g:$8B/$FF; b:$8B/$FF; a:$FF/$FF);
  DARKGOLDENROD       : TColor = (r:$B8/$FF; g:$86/$FF; b:$0B/$FF; a:$FF/$FF);
  DARKGRAY            : TColor = (r:$A9/$FF; g:$A9/$FF; b:$A9/$FF; a:$FF/$FF);
  DARKGREEN           : TColor = (r:$00/$FF; g:$64/$FF; b:$00/$FF; a:$FF/$FF);
  DARKGREY            : TColor = (r:$A9/$FF; g:$A9/$FF; b:$A9/$FF; a:$FF/$FF);
  DARKKHAKI           : TColor = (r:$BD/$FF; g:$B7/$FF; b:$6B/$FF; a:$FF/$FF);
  DARKMAGENTA         : TColor = (r:$8B/$FF; g:$00/$FF; b:$8B/$FF; a:$FF/$FF);
  DARKOLIVEGREEN      : TColor = (r:$55/$FF; g:$6B/$FF; b:$2F/$FF; a:$FF/$FF);
  DARKORANGE          : TColor = (r:$FF/$FF; g:$8C/$FF; b:$00/$FF; a:$FF/$FF);
  DARKORCHID          : TColor = (r:$99/$FF; g:$32/$FF; b:$CC/$FF; a:$FF/$FF);
  DARKRED             : TColor = (r:$8B/$FF; g:$00/$FF; b:$00/$FF; a:$FF/$FF);
  DARKSALMON          : TColor = (r:$E9/$FF; g:$96/$FF; b:$7A/$FF; a:$FF/$FF);
  DARKSEAGREEN        : TColor = (r:$8F/$FF; g:$BC/$FF; b:$8F/$FF; a:$FF/$FF);
  DARKSLATEBLUE       : TColor = (r:$48/$FF; g:$3D/$FF; b:$8B/$FF; a:$FF/$FF);
  DARKSLATEGRAY       : TColor = (r:$2F/$FF; g:$4F/$FF; b:$4F/$FF; a:$FF/$FF);
  DARKSLATEGREY       : TColor = (r:$2F/$FF; g:$4F/$FF; b:$4F/$FF; a:$FF/$FF);
  DARKTURQUOISE       : TColor = (r:$00/$FF; g:$CE/$FF; b:$D1/$FF; a:$FF/$FF);
  DARKVIOLET          : TColor = (r:$94/$FF; g:$00/$FF; b:$D3/$FF; a:$FF/$FF);
  DEEPPINK            : TColor = (r:$FF/$FF; g:$14/$FF; b:$93/$FF; a:$FF/$FF);
  DEEPSKYBLUE         : TColor = (r:$00/$FF; g:$BF/$FF; b:$FF/$FF; a:$FF/$FF);
  DIMGRAY             : TColor = (r:$69/$FF; g:$69/$FF; b:$69/$FF; a:$FF/$FF);
  DIMGREY             : TColor = (r:$69/$FF; g:$69/$FF; b:$69/$FF; a:$FF/$FF);
  DODGERBLUE          : TColor = (r:$1E/$FF; g:$90/$FF; b:$FF/$FF; a:$FF/$FF);
  FIREBRICK           : TColor = (r:$B2/$FF; g:$22/$FF; b:$22/$FF; a:$FF/$FF);
  FLORALWHITE         : TColor = (r:$FF/$FF; g:$FA/$FF; b:$F0/$FF; a:$FF/$FF);
  FORESTGREEN         : TColor = (r:$22/$FF; g:$8B/$FF; b:$22/$FF; a:$FF/$FF);
  FUCHSIA             : TColor = (r:$FF/$FF; g:$00/$FF; b:$FF/$FF; a:$FF/$FF);
  GAINSBORO           : TColor = (r:$DC/$FF; g:$DC/$FF; b:$DC/$FF; a:$FF/$FF);
  GHOSTWHITE          : TColor = (r:$F8/$FF; g:$F8/$FF; b:$FF/$FF; a:$FF/$FF);
  GOLD                : TColor = (r:$FF/$FF; g:$D7/$FF; b:$00/$FF; a:$FF/$FF);
  GOLDENROD           : TColor = (r:$DA/$FF; g:$A5/$FF; b:$20/$FF; a:$FF/$FF);
  GRAY                : TColor = (r:$80/$FF; g:$80/$FF; b:$80/$FF; a:$FF/$FF);
  GREEN               : TColor = (r:$00/$FF; g:$80/$FF; b:$00/$FF; a:$FF/$FF);
  GREENYELLOW         : TColor = (r:$AD/$FF; g:$FF/$FF; b:$2F/$FF; a:$FF/$FF);
  GREY                : TColor = (r:$80/$FF; g:$80/$FF; b:$80/$FF; a:$FF/$FF);
  HONEYDEW            : TColor = (r:$F0/$FF; g:$FF/$FF; b:$F0/$FF; a:$FF/$FF);
  HOTPINK             : TColor = (r:$FF/$FF; g:$69/$FF; b:$B4/$FF; a:$FF/$FF);
  INDIANRED           : TColor = (r:$CD/$FF; g:$5C/$FF; b:$5C/$FF; a:$FF/$FF);
  INDIGO              : TColor = (r:$4B/$FF; g:$00/$FF; b:$82/$FF; a:$FF/$FF);
  IVORY               : TColor = (r:$FF/$FF; g:$FF/$FF; b:$F0/$FF; a:$FF/$FF);
  KHAKI               : TColor = (r:$F0/$FF; g:$E6/$FF; b:$8C/$FF; a:$FF/$FF);
  LAVENDER            : TColor = (r:$E6/$FF; g:$E6/$FF; b:$FA/$FF; a:$FF/$FF);
  LAVENDERBLUSH       : TColor = (r:$FF/$FF; g:$F0/$FF; b:$F5/$FF; a:$FF/$FF);
  LAWNGREEN           : TColor = (r:$7C/$FF; g:$FC/$FF; b:$00/$FF; a:$FF/$FF);
  LEMONCHIFFON        : TColor = (r:$FF/$FF; g:$FA/$FF; b:$CD/$FF; a:$FF/$FF);
  LIGHTBLUE           : TColor = (r:$AD/$FF; g:$D8/$FF; b:$E6/$FF; a:$FF/$FF);
  LIGHTCORAL          : TColor = (r:$F0/$FF; g:$80/$FF; b:$80/$FF; a:$FF/$FF);
  LIGHTCYAN           : TColor = (r:$E0/$FF; g:$FF/$FF; b:$FF/$FF; a:$FF/$FF);
  LIGHTGOLDENRODYELLOW: TColor = (r:$FA/$FF; g:$FA/$FF; b:$D2/$FF; a:$FF/$FF);
  LIGHTGRAY           : TColor = (r:$D3/$FF; g:$D3/$FF; b:$D3/$FF; a:$FF/$FF);
  LIGHTGREEN          : TColor = (r:$90/$FF; g:$EE/$FF; b:$90/$FF; a:$FF/$FF);
  LIGHTGREY           : TColor = (r:$D3/$FF; g:$D3/$FF; b:$D3/$FF; a:$FF/$FF);
  LIGHTPINK           : TColor = (r:$FF/$FF; g:$B6/$FF; b:$C1/$FF; a:$FF/$FF);
  LIGHTSALMON         : TColor = (r:$FF/$FF; g:$A0/$FF; b:$7A/$FF; a:$FF/$FF);
  LIGHTSEAGREEN       : TColor = (r:$20/$FF; g:$B2/$FF; b:$AA/$FF; a:$FF/$FF);
  LIGHTSKYBLUE        : TColor = (r:$87/$FF; g:$CE/$FF; b:$FA/$FF; a:$FF/$FF);
  LIGHTSLATEGRAY      : TColor = (r:$77/$FF; g:$88/$FF; b:$99/$FF; a:$FF/$FF);
  LIGHTSLATEGREY      : TColor = (r:$77/$FF; g:$88/$FF; b:$99/$FF; a:$FF/$FF);
  LIGHTSTEELBLUE      : TColor = (r:$B0/$FF; g:$C4/$FF; b:$DE/$FF; a:$FF/$FF);
  LIGHTYELLOW         : TColor = (r:$FF/$FF; g:$FF/$FF; b:$E0/$FF; a:$FF/$FF);
  LIME                : TColor = (r:$00/$FF; g:$FF/$FF; b:$00/$FF; a:$FF/$FF);
  LIMEGREEN           : TColor = (r:$32/$FF; g:$CD/$FF; b:$32/$FF; a:$FF/$FF);
  LINEN               : TColor = (r:$FA/$FF; g:$F0/$FF; b:$E6/$FF; a:$FF/$FF);
  MAGENTA             : TColor = (r:$FF/$FF; g:$00/$FF; b:$FF/$FF; a:$FF/$FF);
  MAROON              : TColor = (r:$80/$FF; g:$00/$FF; b:$00/$FF; a:$FF/$FF);
  MEDIUMAQUAMARINE    : TColor = (r:$66/$FF; g:$CD/$FF; b:$AA/$FF; a:$FF/$FF);
  MEDIUMBLUE          : TColor = (r:$00/$FF; g:$00/$FF; b:$CD/$FF; a:$FF/$FF);
  MEDIUMORCHID        : TColor = (r:$BA/$FF; g:$55/$FF; b:$D3/$FF; a:$FF/$FF);
  MEDIUMPURPLE        : TColor = (r:$93/$FF; g:$70/$FF; b:$DB/$FF; a:$FF/$FF);
  MEDIUMSEAGREEN      : TColor = (r:$3C/$FF; g:$B3/$FF; b:$71/$FF; a:$FF/$FF);
  MEDIUMSLATEBLUE     : TColor = (r:$7B/$FF; g:$68/$FF; b:$EE/$FF; a:$FF/$FF);
  MEDIUMSPRINGGREEN   : TColor = (r:$00/$FF; g:$FA/$FF; b:$9A/$FF; a:$FF/$FF);
  MEDIUMTURQUOISE     : TColor = (r:$48/$FF; g:$D1/$FF; b:$CC/$FF; a:$FF/$FF);
  MEDIUMVIOLETRED     : TColor = (r:$C7/$FF; g:$15/$FF; b:$85/$FF; a:$FF/$FF);
  MIDNIGHTBLUE        : TColor = (r:$19/$FF; g:$19/$FF; b:$70/$FF; a:$FF/$FF);
  MINTCREAM           : TColor = (r:$F5/$FF; g:$FF/$FF; b:$FA/$FF; a:$FF/$FF);
  MISTYROSE           : TColor = (r:$FF/$FF; g:$E4/$FF; b:$E1/$FF; a:$FF/$FF);
  MOCCASIN            : TColor = (r:$FF/$FF; g:$E4/$FF; b:$B5/$FF; a:$FF/$FF);
  NAVAJOWHITE         : TColor = (r:$FF/$FF; g:$DE/$FF; b:$AD/$FF; a:$FF/$FF);
  NAVY                : TColor = (r:$00/$FF; g:$00/$FF; b:$80/$FF; a:$FF/$FF);
  OLDLACE             : TColor = (r:$FD/$FF; g:$F5/$FF; b:$E6/$FF; a:$FF/$FF);
  OLIVE               : TColor = (r:$80/$FF; g:$80/$FF; b:$00/$FF; a:$FF/$FF);
  OLIVEDRAB           : TColor = (r:$6B/$FF; g:$8E/$FF; b:$23/$FF; a:$FF/$FF);
  ORANGE              : TColor = (r:$FF/$FF; g:$A5/$FF; b:$00/$FF; a:$FF/$FF);
  ORANGERED           : TColor = (r:$FF/$FF; g:$45/$FF; b:$00/$FF; a:$FF/$FF);
  ORCHID              : TColor = (r:$DA/$FF; g:$70/$FF; b:$D6/$FF; a:$FF/$FF);
  PALEGOLDENROD       : TColor = (r:$EE/$FF; g:$E8/$FF; b:$AA/$FF; a:$FF/$FF);
  PALEGREEN           : TColor = (r:$98/$FF; g:$FB/$FF; b:$98/$FF; a:$FF/$FF);
  PALETURQUOISE       : TColor = (r:$AF/$FF; g:$EE/$FF; b:$EE/$FF; a:$FF/$FF);
  PALEVIOLETRED       : TColor = (r:$DB/$FF; g:$70/$FF; b:$93/$FF; a:$FF/$FF);
  PAPAYAWHIP          : TColor = (r:$FF/$FF; g:$EF/$FF; b:$D5/$FF; a:$FF/$FF);
  PEACHPUFF           : TColor = (r:$FF/$FF; g:$DA/$FF; b:$B9/$FF; a:$FF/$FF);
  PERU                : TColor = (r:$CD/$FF; g:$85/$FF; b:$3F/$FF; a:$FF/$FF);
  PINK                : TColor = (r:$FF/$FF; g:$C0/$FF; b:$CB/$FF; a:$FF/$FF);
  PLUM                : TColor = (r:$DD/$FF; g:$A0/$FF; b:$DD/$FF; a:$FF/$FF);
  POWDERBLUE          : TColor = (r:$B0/$FF; g:$E0/$FF; b:$E6/$FF; a:$FF/$FF);
  PURPLE              : TColor = (r:$80/$FF; g:$00/$FF; b:$80/$FF; a:$FF/$FF);
  REBECCAPURPLE       : TColor = (r:$66/$FF; g:$33/$FF; b:$99/$FF; a:$FF/$FF);
  RED                 : TColor = (r:$FF/$FF; g:$00/$FF; b:$00/$FF; a:$FF/$FF);
  ROSYBROWN           : TColor = (r:$BC/$FF; g:$8F/$FF; b:$8F/$FF; a:$FF/$FF);
  ROYALBLUE           : TColor = (r:$41/$FF; g:$69/$FF; b:$E1/$FF; a:$FF/$FF);
  SADDLEBROWN         : TColor = (r:$8B/$FF; g:$45/$FF; b:$13/$FF; a:$FF/$FF);
  SALMON              : TColor = (r:$FA/$FF; g:$80/$FF; b:$72/$FF; a:$FF/$FF);
  SANDYBROWN          : TColor = (r:$F4/$FF; g:$A4/$FF; b:$60/$FF; a:$FF/$FF);
  SEAGREEN            : TColor = (r:$2E/$FF; g:$8B/$FF; b:$57/$FF; a:$FF/$FF);
  SEASHELL            : TColor = (r:$FF/$FF; g:$F5/$FF; b:$EE/$FF; a:$FF/$FF);
  SIENNA              : TColor = (r:$A0/$FF; g:$52/$FF; b:$2D/$FF; a:$FF/$FF);
  SILVER              : TColor = (r:$C0/$FF; g:$C0/$FF; b:$C0/$FF; a:$FF/$FF);
  SKYBLUE             : TColor = (r:$87/$FF; g:$CE/$FF; b:$EB/$FF; a:$FF/$FF);
  SLATEBLUE           : TColor = (r:$6A/$FF; g:$5A/$FF; b:$CD/$FF; a:$FF/$FF);
  SLATEGRAY           : TColor = (r:$70/$FF; g:$80/$FF; b:$90/$FF; a:$FF/$FF);
  SLATEGREY           : TColor = (r:$70/$FF; g:$80/$FF; b:$90/$FF; a:$FF/$FF);
  SNOW                : TColor = (r:$FF/$FF; g:$FA/$FF; b:$FA/$FF; a:$FF/$FF);
  SPRINGGREEN         : TColor = (r:$00/$FF; g:$FF/$FF; b:$7F/$FF; a:$FF/$FF);
  STEELBLUE           : TColor = (r:$46/$FF; g:$82/$FF; b:$B4/$FF; a:$FF/$FF);
  TAN                 : TColor = (r:$D2/$FF; g:$B4/$FF; b:$8C/$FF; a:$FF/$FF);
  TEAL                : TColor = (r:$00/$FF; g:$80/$FF; b:$80/$FF; a:$FF/$FF);
  THISTLE             : TColor = (r:$D8/$FF; g:$BF/$FF; b:$D8/$FF; a:$FF/$FF);
  TOMATO              : TColor = (r:$FF/$FF; g:$63/$FF; b:$47/$FF; a:$FF/$FF);
  TURQUOISE           : TColor = (r:$40/$FF; g:$E0/$FF; b:$D0/$FF; a:$FF/$FF);
  VIOLET              : TColor = (r:$EE/$FF; g:$82/$FF; b:$EE/$FF; a:$FF/$FF);
  WHEAT               : TColor = (r:$F5/$FF; g:$DE/$FF; b:$B3/$FF; a:$FF/$FF);
  WHITE               : TColor = (r:$FF/$FF; g:$FF/$FF; b:$FF/$FF; a:$FF/$FF);
  WHITESMOKE          : TColor = (r:$F5/$FF; g:$F5/$FF; b:$F5/$FF; a:$FF/$FF);
  YELLOW              : TColor = (r:$FF/$FF; g:$FF/$FF; b:$00/$FF; a:$FF/$FF);
  YELLOWGREEN         : TColor = (r:$9A/$FF; g:$CD/$FF; b:$32/$FF; a:$FF/$FF);
  BLANK               : TColor = (r:$00;     g:$00;     b:$00;     a:$00);
  WHITE2              : TColor = (r:$F5/$FF; g:$F5/$FF; b:$F5/$FF; a:$FF/$FF);
  RED22               : TColor = (r:$7E/$FF; g:$32/$FF; b:$3F/$FF; a:255/$FF);
  COLORKEY            : TColor = (r:$FF/$FF; g:$00;     b:$FF/$FF; a:$FF/$FF);
  OVERLAY1            : TColor = (r:$00/$FF; g:$20/$FF; b:$29/$FF; a:$B4/$FF);
  OVERLAY2            : TColor = (r:$01/$FF; g:$1B/$FF; b:$01/$FF; a:255/$FF);
  DIMWHITE            : TColor = (r:$10/$FF; g:$10/$FF; b:$10/$FF; a:$10/$FF);
  DARKSLATEBROWN      : TColor = (r:30/255; g:31/255; b:30/255; a:1/255);
{$ENDREGION}

{$ENDREGION}

{$REGION ' IO '}
//=== IO ====================================================================
type
  { TIOSeek }
  TIOSeek = (iosStart, iosCurrent, iosEnd);

  { IIO }
  IIO = interface(IBaseInterface)
    ['{E3C9B68F-3906-4775-A098-0388E7568C76}']
    function  IsOpen(): Boolean;
    procedure Close();
    function  Size(): Int64;
    function  Seek(const AOffset: Int64; const ASeek: TIOSeek): Int64;
    function  Read(const AData: Pointer; const ASize: Int64): Int64;
    function  Write(const AData: Pointer; const ASize: Int64): Int64;
    function  Pos(): Int64;
    function  Eos(): Boolean;
  end;

//=== MEMORYIO ==============================================================
type
  { IMemoryIO }
  IMemoryIO = interface(IIO)
    ['{3FD5D440-FFC9-4643-B328-1008A562BE5D}']
    function Open(const AData: Pointer; ASize: Int64): Boolean;
  end;

//=== FILEIO ================================================================
type
  { TIOMode }
  TIOMode = (iomRead, iomWrite);

  { IFileIO }
  IFileIO = interface(IIO)
    ['{A9DCF880-C7A3-4B28-A554-2872140F5F7D}']
    function Open(const AFilename: string; const AMode: TIOMode): Boolean;
  end;

//=== ZIPFILEIO =============================================================
const
  { CDefaultZipFilePassword }
  CDefaultZipFilePassword = 'N^TpjE5/*czG,<ns>$}w;?x_uBm9[JSr{(+FRv7ZW@C-gd3D!PRUgWE4P2/wpm9-dt^Y?e)Az+xsMb@jH"!X`B3ar(yq=nZ_~85<';

type
  { TZipFileIOBuildProgressEvent }
  TZipFileIOBuildProgressEvent = procedure(const ASender: Pointer; const AFilename: string; const AProgress: Integer; const ANewFile: Boolean);

  { IZipFileIO }
  IZipFileIO = interface(IIO)
    ['{E2B74E59-35A1-48F9-964A-0B4F3B136DA4}']
    function Build(const AZipFilename, ADirectoryName: string; const ASender: Pointer=nil; const AHandler: TZipFileIOBuildProgressEvent=nil; const APassword: string=CDefaultZipFilePassword): Boolean;
    function Open(const AZipFilename, AFilename: string; const APassword: string=CDefaultZipFilePassword): Boolean;
  end;
{$ENDREGION}

{$REGION ' WINDOW '}
//=== WINDOW ================================================================
{$REGION ' Key Codes '}
const
  KEY_UNKNOWN = -1;
  KEY_SPACE = 32;
  KEY_APOSTROPHE = 39;
  KEY_COMMA = 44;
  KEY_MINUS = 45;
  KEY_PERIOD = 46;
  KEY_SLASH = 47;
  KEY_0 = 48;
  KEY_1 = 49;
  KEY_2 = 50;
  KEY_3 = 51;
  KEY_4 = 52;
  KEY_5 = 53;
  KEY_6 = 54;
  KEY_7 = 55;
  KEY_8 = 56;
  KEY_9 = 57;
  KEY_SEMICOLON = 59;
  KEY_EQUAL = 61;
  KEY_A = 65;
  KEY_B = 66;
  KEY_C = 67;
  KEY_D = 68;
  KEY_E = 69;
  KEY_F = 70;
  KEY_G = 71;
  KEY_H = 72;
  KEY_I = 73;
  KEY_J = 74;
  KEY_K = 75;
  KEY_L = 76;
  KEY_M = 77;
  KEY_N = 78;
  KEY_O = 79;
  KEY_P = 80;
  KEY_Q = 81;
  KEY_R = 82;
  KEY_S = 83;
  KEY_T = 84;
  KEY_U = 85;
  KEY_V = 86;
  KEY_W = 87;
  KEY_X = 88;
  KEY_Y = 89;
  KEY_Z = 90;
  KEY_LEFT_BRACKET = 91;
  KEY_BACKSLASH = 92;
  KEY_RIGHT_BRACKET = 93;
  KEY_GRAVE_ACCENT = 96;
  KEY_WORLD_1 = 161;
  KEY_WORLD_2 = 162;
  KEY_ESCAPE = 256;
  KEY_ENTER = 257;
  KEY_TAB = 258;
  KEY_BACKSPACE = 259;
  KEY_INSERT = 260;
  KEY_DELETE = 261;
  KEY_RIGHT = 262;
  KEY_LEFT = 263;
  KEY_DOWN = 264;
  KEY_UP = 265;
  KEY_PAGE_UP = 266;
  KEY_PAGE_DOWN = 267;
  KEY_HOME = 268;
  KEY_END = 269;
  KEY_CAPS_LOCK = 280;
  KEY_SCROLL_LOCK = 281;
  KEY_NUM_LOCK = 282;
  KEY_PRINT_SCREEN = 283;
  KEY_PAUSE = 284;
  KEY_F1 = 290;
  KEY_F2 = 291;
  KEY_F3 = 292;
  KEY_F4 = 293;
  KEY_F5 = 294;
  KEY_F6 = 295;
  KEY_F7 = 296;
  KEY_F8 = 297;
  KEY_F9 = 298;
  KEY_F10 = 299;
  KEY_F11 = 300;
  KEY_F12 = 301;
  KEY_F13 = 302;
  KEY_F14 = 303;
  KEY_F15 = 304;
  KEY_F16 = 305;
  KEY_F17 = 306;
  KEY_F18 = 307;
  KEY_F19 = 308;
  KEY_F20 = 309;
  KEY_F21 = 310;
  KEY_F22 = 311;
  KEY_F23 = 312;
  KEY_F24 = 313;
  KEY_F25 = 314;
  KEY_KP_0 = 320;
  KEY_KP_1 = 321;
  KEY_KP_2 = 322;
  KEY_KP_3 = 323;
  KEY_KP_4 = 324;
  KEY_KP_5 = 325;
  KEY_KP_6 = 326;
  KEY_KP_7 = 327;
  KEY_KP_8 = 328;
  KEY_KP_9 = 329;
  KEY_KP_DECIMAL = 330;
  KEY_KP_DIVIDE = 331;
  KEY_KP_MULTIPLY = 332;
  KEY_KP_SUBTRACT = 333;
  KEY_KP_ADD = 334;
  KEY_KP_ENTER = 335;
  KEY_KP_EQUAL = 336;
  KEY_LEFT_SHIFT = 340;
  KEY_LEFT_CONTROL = 341;
  KEY_LEFT_ALT = 342;
  KEY_LEFT_SUPER = 343;
  KEY_RIGHT_SHIFT = 344;
  KEY_RIGHT_CONTROL = 345;
  KEY_RIGHT_ALT = 346;
  KEY_RIGHT_SUPER = 347;
  KEY_MENU = 348;
  KEY_LAST = KEY_MENU;
{$ENDREGION}

{$REGION ' Mouse Buttons '}
const
  MOUSE_BUTTON_1 = 0;
  MOUSE_BUTTON_2 = 1;
  MOUSE_BUTTON_3 = 2;
  MOUSE_BUTTON_4 = 3;
  MOUSE_BUTTON_5 = 4;
  MOUSE_BUTTON_6 = 5;
  MOUSE_BUTTON_7 = 6;
  MOUSE_BUTTON_8 = 7;
  MOUSE_BUTTON_LAST = 7;
  MOUSE_BUTTON_LEFT = 0;
  MOUSE_BUTTON_RIGHT = 1;
  MOUSE_BUTTON_MIDDLE = 2;
{$ENDREGION}

{$REGION ' Gamepads '}
const
  GAMEPAD_1 = 0;
  GAMEPAD_2 = 1;
  GAMEPAD_3 = 2;
  GAMEPAD_4 = 3;
  GAMEPAD_5 = 4;
  GAMEPAD_6 = 5;
  GAMEPAD_7 = 6;
  GAMEPAD_8 = 7;
  GAMEPAD_9 = 8;
  GAMEPAD_10 = 9;
  GAMEPAD_11 = 10;
  GAMEPAD_12 = 11;
  GAMEPAD_13 = 12;
  GAMEPAD_14 = 13;
  GAMEPAD_15 = 14;
  GAMEPAD_16 = 15;
  GAMEPAD_LAST = GAMEPAD_16;
{$ENDREGION}

{$REGION ' Gamepad Buttons '}
const
  GAMEPAD_BUTTON_A = 0;
  GAMEPAD_BUTTON_B = 1;
  GAMEPAD_BUTTON_X = 2;
  GAMEPAD_BUTTON_Y = 3;
  GAMEPAD_BUTTON_LEFT_BUMPER = 4;
  GAMEPAD_BUTTON_RIGHT_BUMPER = 5;
  GAMEPAD_BUTTON_BACK = 6;
  GAMEPAD_BUTTON_START = 7;
  GAMEPAD_BUTTON_GUIDE = 8;
  GAMEPAD_BUTTON_LEFT_THUMB = 9;
  GAMEPAD_BUTTON_RIGHT_THUMB = 10;
  GAMEPAD_BUTTON_DPAD_UP = 11;
  GAMEPAD_BUTTON_DPAD_RIGHT = 12;
  GAMEPAD_BUTTON_DPAD_DOWN = 13;
  GAMEPAD_BUTTON_DPAD_LEFT = 14;
  GAMEPAD_BUTTON_LAST = GAMEPAD_BUTTON_DPAD_LEFT;
  GAMEPAD_BUTTON_CROSS = GAMEPAD_BUTTON_A;
  GAMEPAD_BUTTON_CIRCLE = GAMEPAD_BUTTON_B;
  GAMEPAD_BUTTON_SQUARE = GAMEPAD_BUTTON_X;
  GAMEPAD_BUTTON_TRIANGLE = GAMEPAD_BUTTON_Y;
{$ENDREGION}

{$REGiON ' Gamepad Axis '}
const
  GAMEPAD_AXIS_LEFT_X = 0;
  GAMEPAD_AXIS_LEFT_Y = 1;
  GAMEPAD_AXIS_RIGHT_X = 2;
  GAMEPAD_AXIS_RIGHT_Y = 3;
  GAMEPAD_AXIS_LEFT_TRIGGER = 4;
  GAMEPAD_AXIS_RIGHT_TRIGGER = 5;
  GAMEPAD_AXIS_LAST = GAMEPAD_AXIS_RIGHT_TRIGGER;
{$ENDREGiON}

const
  CDefaultWindowWidth  = 1920 div 2;
  CDefaultWindowHeight = 1080 div 2;

  CDefaultFPS = 60;

type
  { TInputState }
  TInputState = (isPressed, isWasPressed, isWasReleased);

  { IWindow }
  IWindow = interface(IBaseInterface)
    ['{1991F1A6-342B-4798-BD63-92491FFF2F35}']
    function  Open(const ATitle: string; const AVirtualWidth: Cardinal=CDefaultWindowWidth; const AVirtualHeight: Cardinal=CDefaultWindowHeight; const AParent: NativeUInt=0): Boolean;
    procedure Close();

    function  GetTitle(): string;
    procedure SetTitle(const ATitle: string);

    procedure Resize(const AWidth, AHeight: Cardinal);
    procedure ToggleFullscreen();
    function  IsFullscreen(): Boolean;

    function  HasFocus(): Boolean;

    function  GetVirtualSize(): TSize;
    function  GetSize(): TSize;
    function  GetScale(): TSize;
    function  GetMaxTextureSize(): Integer;

    function  GetViewport(): TRect;

    procedure Center();

    function  ShouldClose(): Boolean;
    procedure SetShouldClose(const AClose: Boolean);

    procedure StartFrame();
    procedure EndFrame();

    procedure StartDrawing();
    procedure ResetDrawing();
    procedure EndDrawing();

    procedure Clear(const AColor: TColor);

    procedure DrawLine(const X1, Y1, X2, Y2: Single; const AColor: TColor; const AThickness: Single);
    procedure DrawRect(const X, Y, AWidth, AHeight, AThickness: Single; const AColor: TColor; const AAngle: Single);
    procedure DrawFilledRect(const X, Y, AWidth, AHeight: Single; const AColor: TColor; const AAngle: Single);
    procedure DrawCircle(const X, Y, ARadius, AThickness: Single; const AColor: TColor);
    procedure DrawFilledCircle(const X, Y, ARadius: Single; const AColor: TColor);
    procedure DrawTriangle(const X1, Y1, X2, Y2, X3, Y3, AThickness: Single; const AColor: TColor);
    procedure DrawFilledTriangle(const X1, Y1, X2, Y2, X3, Y3: Single; const AColor: TColor);
    procedure DrawPolygon(const APoints: array of TPoint; const AThickness: Single; const AColor: TColor);
    procedure DrawFilledPolygon(const APoints: array of TPoint; const AColor: TColor);
    procedure DrawPolyline(const APoints: array of TPoint; const AThickness: Single; const AColor: TColor);

    procedure ClearInput();
    function  GetKey(const AKey: Integer; const AState: TInputState): Boolean;
    function  GetMouseButton(const AButton: Byte; const AState: TInputState): Boolean;
    procedure GetMousePos(const X, Y: System.PSingle); overload;
    function  GetMousePos(): TPoint; overload;
    procedure SetMousePos(const X, Y: Single);
    function  GetMouseWheel(): TVector;
    procedure ResetMouseWheel;

    function  GamepadPresent(const AGamepad: Byte): Boolean;
    function  GetGamepadName(const AGamepad: Byte): string;
    function  GetGamepadButton(const AGamepad, AButton: Byte; const AState: TInputState): Boolean;
    function  GetGamepadAxisValue(const AGamepad, AAxis: Byte): Single;

    function  VirtualToScreen(const X, Y: Single): TPoint;
    function  ScreenToVirtual(const X, Y: Single): TPoint;

    procedure SetTargetFrameRate(const ATargetFrameRate: UInt32=CDefaultFPS);
    function  GetTargetFrameRate(): UInt32;
    function  GetTargetTime(): Double;
    procedure ResetTiming();
    function  GetFrameRate(): UInt32;
  end;
{$ENDREGION}

{$REGION ' TEXTURE '}
//=== TEXTURE ===============================================================
type
  { TTextureBlend }
  TTextureBlend = (tbNone, tbAlpha, tbAdditiveAlpha);

  { ITexture }
  ITexture = interface(IBaseInterface)
    ['{0C2E0C6B-EE22-4080-9C2C-D10C7A556A24}']
    function  Alloc(const AWidth, AHeight: Integer): Boolean;
    procedure Fill(const AColor: TColor);
    function  Load(const ARGBData: Pointer; const AWidth, AHeight: Integer): Boolean; overload;
    function  Load(const AIO: IIO; const AOwnIO: Boolean=True; const AColorKey: PColor=nil): Boolean; overload;
    function  LoadFromFile(const AFilename: string; const AColorKey: PColor=nil): Boolean;
    function  LoadFromZipFile(const AZipFilename, AFilename: string; const AColorKey: PColor=nil; const APassword: string=CDefaultZipFilePassword): Boolean;
    function  IsLoaded(): Boolean;
    procedure Unload();
    function  GetChannels(): Integer;
    function  GetSize(): TSize;
    function  GetPivot(): TPoint;
    procedure SetPivot( const APoint: TPoint); overload;
    procedure SetPivot(const X, Y: Single); overload;
    function  Anchor(): TPoint;
    procedure SetAnchor(const APoint: TPoint); overload;
    procedure SetAnchor(const X, Y: Single); overload;
    function  GetBlend(): TTextureBlend;
    procedure SetBlend(const AValue: TTextureBlend);
    function  GetPos(): TPoint;
    procedure SetPos(const APos: TPoint); overload;
    procedure SetPos(const X, Y: Single); overload;
    function  GetScale(): Single;
    procedure SetScale(const AScale: Single);
    function  GetColor(): TColor;
    procedure SetColor(const AColor: TColor); overload;
    procedure SetColor(const ARed, AGreen, ABlue, AAlpha: Single); overload;
    function  GetAngle(): Single;
    procedure SetAngle(const AAngle: Single);
    function  GetHFlip(): Boolean;
    procedure SetHFlip(const AFlip: Boolean);
    function  GetVFlip(): Boolean;
    procedure SetVFlip(const AFlip: Boolean);
    function  GetRegion(): TRect;
    procedure SetRegion(const ARegion: TRect); overload;
    procedure SetRegion(const X, Y, AWidth, AHeight: Single); overload;
    procedure ResetRegion();
    procedure Draw(const AWindow: IWindow);
    procedure DrawTiled(const AWindow: IWindow; const ADeltaX, ADeltaY: Single);
    function  Save(const AFilename: string): Boolean;
    function  Lock(): Boolean;
    procedure Unlock();
    function  GetPixel(const X, Y: Single): TColor;
    procedure SetPixel(const X, Y: Single; const AColor: TColor); overload;
    procedure SetPixel(const X, Y: Single; const ARed, AGreen, ABlue, AAlpha: Byte); overload;
    function  CollideAABB(const ATexture: ITexture): Boolean;
    function  CollideOBB(const ATexture: ITexture): Boolean;
  end;
{$ENDREGION}

{$REGION ' FONT '}
//=== FONT ==================================================================
type
  { IFont }
  IFont = interface(IBaseInterface)
    ['{5B4C223B-E3FF-46A5-ABED-CDBFA9B95EAA}']
    function  Load(const AWindow: IWindow; const ASize: Cardinal; const AGlyphs: string=''): Boolean; overload;
    function  Load(const AWindow: IWindow; const AIO: IIO; const ASize: Cardinal; const AGlyphs: string=''; const AOwnIO: Boolean=True): Boolean; overload;
    function  LoadFromFile(const AWindow: IWindow; const AFilename: string; const ASize: Cardinal; const AGlyphs: string=''): Boolean;
    function  LoadFromZipFile(const AWindow: IWindow; const AZipFilename, AFilename: string; const ASize: Cardinal; const AGlyphs: string=''; const APassword: string=CDefaultZipFilePassword): Boolean;
    procedure Unload();
    procedure DrawText(const AWindow: IWindow; const X, Y: Single; const AColor: TColor; AHAlign: THAlign; const AText: string; const AArgs: array of const); overload;
    procedure DrawText(const AWindow: IWindow; const X: Single; var Y: Single; const aLineSpace: Single; const aColor: TColor; AHAlign: THAlign; const AText: string; const AArgs: array of const); overload;
    function  TextLength(const AText: string; const AArgs: array of const): Single;
    function  TextHeight(): Single;
    function  SaveTexture(const AFilename: string): Boolean;
  end;
{$ENDREGION}

{$REGION ' VIDEO '}
//=== VIDEO =================================================================
type
  { TVideoStatus }
  TVideoStatus = (vsStopped, vsPlaying);

  { TVideoStatusEvent }
  TVideoStatusEvent = procedure(const ASender: Pointer; const AStatus: TVideoStatus; const AFilename: string);

  { IVideo }
  IVideo = interface(IBaseInterface)
    ['{B447EECB-D050-4E2B-8F32-DD9516D75BAD}']
    function  GetStatusEvent(): TVideoStatusEvent;
    procedure SetStatusEvent(const ASender: Pointer; const AHandler: TVideoStatusEvent);
    function  Play(const AIO: IIO;  const AFilename: string; const AVolume: Single; const ALoop: Boolean): Boolean;
    function  PlayFromZipFile(const AZipFilename, AFilename: string; const AVolume: Single; const ALoop: Boolean; const APassword: string=CDefaultZipFilePassword): Boolean;
    procedure Stop();
    function  Update(const AWindow: IWindow): Boolean;
    procedure Draw(const AWindow: IWindow; const X, Y, AScale: Single);
    function  Status(): TVideoStatus;
    function  Volume(): Single;
    procedure SetVolume(const AVolume: Single);
    function  IsLooping(): Boolean;
    procedure SetLooping(const ALoop: Boolean);
  end;

var
  { Video }
  Video: IVideo = nil;
{$ENDREGION}

{$REGION ' AUDIO ' }
//=== AUDIO =================================================================
const
  ERROR           = -1;
  MUSIC_COUNT     = 256;
  SOUND_COUNT     = 256;
  CHANNEL_COUNT   = 16;
  CHANNEL_DYNAMIC = -2;

type
  { IAudio }
  IAudio = interface(IBaseInterface)
    ['{B589AE44-0A62-4934-B1F5-AAC062CBAC98}']
    procedure Update();
    function  Open(): Boolean;
    function  IsOpen(): Boolean;
    procedure Close();
    function  IsPaused(): Boolean;
    procedure SetPause(const APause: Boolean);
    function  PlayMusic(const AIO: IIO; const AFilename: string; const AVolume: Single; const ALoop: Boolean; const APan: Single=0.0): Boolean;
    function  PlayMusicFromFile(const AFilename: string; const AVolume: Single; const ALoop: Boolean; const APan: Single=0.0): Boolean;
    function  PlayMusicFromZipFile(const AZipFilename, AFilename: string; const AVolume: Single; const ALoop: Boolean; const APan: Single=0.0; const APassword: string=CDefaultZipFilePassword): Boolean;
    procedure UnloadMusic();
    function  IsMusicLooping(): Boolean;
    procedure SetMusicLooping(const ALoop: Boolean);
    function  MusicVolume(): Single;
    procedure SetMusicVolume(const AVolume: Single);
    function  MusicPan(): Single;
    procedure SetMusicPan(const APan: Single);
    function  LoadSound(const AIO: IIO; const AFilename: string): Integer;
    function  LoadSoundFromFile(const AFilename: string): Integer;
    function  LoadSoundFromZipFile(const AZipFilename, AFilename: string; const APassword: string=CDefaultZipFilePassword): Integer;
    procedure UnloadSound(var ASound: Integer);
    procedure UnloadAllSounds();
    function  PlaySound(const ASound, AChannel: Integer; const AVolume: Single; const ALoop: Boolean): Integer;
    procedure ReserveChannel(const AChannel: Integer; const aReserve: Boolean);
    procedure StopChannel(const AChannel: Integer);
    procedure SetChannelVolume(const AChannel: Integer; const AVolume: Single);
    function  GetChannelVolume(const AChannel: Integer): Single;
    procedure SetChannelPosition(const AChannel: Integer; const X, Y: Single);
    procedure SetChannelLoop(const AChannel: Integer; const ALoop: Boolean);
    function  GetchannelLoop(const AChannel: Integer): Boolean;
    function  GetChannelPlaying(const AChannel: Integer): Boolean;
  end;

var
  Audio: IAudio = nil;
{$ENDREGION}

implementation

{$REGION ' USES '}
  uses
    WinApi.Windows,
    WinApi.Messages,
    System.Types,
    System.Generics.Collections,
    System.SysUtils,
    System.IOUtils,
    System.Classes,
    System.SyncObjs,
    System.Math,
    System.ZLib,
    Mamba.Deps,
    Mamba.OGL;
{$ENDREGION}

{$REGION ' COMMON '}

//=== COMMON ================================================================
const
  { CTempStaticBufferSize }
  CTempStaticBufferSize = 1024*4;

type
  { TCallback }
  TCallback<T> = record
    Handler: T;
    UserData: Pointer;
  end;

var
  FMarshaller: TMarshaller;
  FTempStaticBuffer: array[0..CTempStaticBufferSize-1] of Byte;
  CriticalSection: TCriticalSection;

function GetTempStaticBufferSize(): UInt64;
begin
  Result := CTempStaticBufferSize;
end;

function GetTempStaticBuffer(): Pointer;
begin
  Result := @FTempStaticBuffer[0]
end;

function  AsUTF8(const AText: System.string): System.Pointer; overload;
begin
  Result := FMarshaller.AsUtf8(AText).ToPointer;
end;

function  AsUTF8(const AText: System.PWideChar): System.Pointer; overload;
begin
  Result := FMarshaller.AsUtf8(AText).ToPointer;
end;

function  ResourceExist(const AInstance: HINST; const AResName: WideString): Boolean;
begin
  Result := Boolean((FindResource(HInstance, PChar(AResName), RT_RCDATA) <> 0));
end;

function RemoveDuplicates(const aText: string): string;
var
  i, l: integer;
begin
  Result := '';
  l := Length(aText);
  for i := 1 to l do
  begin
    if (Pos(aText[i], result) = 0) then
    begin
      result := result + aText[i];
    end;
  end;
end;

procedure ProcessMessages();
var
  LMsg: TMsg;
begin
  while Integer(PeekMessage(LMsg, 0, 0, 0, PM_REMOVE)) <> 0 do
  begin
    TranslateMessage(LMsg);
    DispatchMessage(LMsg);
  end;
end;

procedure Wait(const AMilliseconds: Double);
var
  LFrequency, LStartCount, LCurrentCount: Int64;
  LElapsedTime: Double;
begin
  // Get the high-precision frequency of the system's performance counter
  QueryPerformanceFrequency(LFrequency);

  // Get the starting value of the performance counter
  QueryPerformanceCounter(LStartCount);

  // Convert milliseconds to seconds for precision timing
  repeat
    QueryPerformanceCounter(LCurrentCount);
    LElapsedTime := (LCurrentCount - LStartCount) / LFrequency * 1000.0; // Convert to milliseconds
  until LElapsedTime >= AMilliseconds;
end;

type
  { TVirtualBuffer }
  TVirtualBuffer = class(TCustomMemoryStream)
  protected
    FHandle: THandle;
    FName: string;
    procedure Clear();
  public
    constructor Create(aSize: Cardinal);
    destructor Destroy(); override;
    function Write(const aBuffer; aCount: Longint): Longint; override;
    function Write(const aBuffer: TBytes; aOffset, aCount: Longint): Longint; override;
    procedure SaveToFile(aFilename: string);
    property Name: string read FName;
    function  Eob(): Boolean;
    function  ReadString(): string;
    class function LoadFromFile(const aFilename: string): TVirtualBuffer;
  end;

  { TRingBuffer }
  TRingBuffer<T> = class
  private type
    PType = ^T;
  private
    FBuffer: array of T;
    FReadIndex, FWriteIndex, FCapacity: Integer;
  public
    constructor Create(ACapacity: Integer);
    function Write(const AData: array of T; ACount: Integer): Integer;
    function Read(var AData: array of T; ACount: Integer): Integer;
    function DirectReadPointer(ACount: Integer): Pointer;
    function AvailableBytes(): Integer;
    procedure Clear();
  end;

  { TVirtualRingBuffer }
  TVirtualRingBuffer<T> = class
  private type
    PType = ^T;
  private
    FBuffer: TVirtualBuffer;
    FReadIndex, FWriteIndex, FCapacity: Integer;
    function GetArrayValue(AIndex: Integer): T;
    procedure SetArrayValue(AIndex: Integer; AValue: T);
  public
    constructor Create(ACapacity: Integer);
    destructor Destroy; override;
    function Write(const AData: array of T; ACount: Integer): Integer;
    function Read(var AData: array of T; ACount: Integer): Integer;
    function DirectReadPointer(ACount: Integer): Pointer;
    function AvailableBytes(): Integer;
    procedure Clear();
  end;

{ TVirtualBuffer }
procedure TVirtualBuffer.Clear();
begin
  if (Memory <> nil) then
  begin
    if not UnmapViewOfFile(Memory) then
      raise Exception.Create('Error deallocating mapped memory');
  end;

  if (FHandle <> 0) then
  begin
    if not CloseHandle(FHandle) then
      raise Exception.Create('Error freeing memory mapping handle');
  end;
end;

constructor TVirtualBuffer.Create(aSize: Cardinal);
var
  P: Pointer;
begin
  inherited Create;
  FName := TPath.GetGUIDFileName;
  FHandle := CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, aSize, PChar(FName));
  if FHandle = 0 then
    begin
      Clear;
      raise Exception.Create('Error creating memory mapping');
      FHandle := 0;
    end
  else
    begin
      P := MapViewOfFile(FHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);
      if P = nil then
        begin
          Clear;
          raise Exception.Create('Error creating memory mapping');
        end
      else
        begin
          Self.SetPointer(P, aSize);
          Position := 0;
        end;
    end;
end;

destructor TVirtualBuffer.Destroy();
begin
  Clear;
  inherited;
end;

function TVirtualBuffer.Write(const aBuffer; aCount: Longint): Longint;
var
  LPos: Int64;
begin
  if (Position >= 0) and (aCount >= 0) then
  begin
    LPos := Position + aCount;
    if LPos > 0 then
    begin
      if LPos > Size then
      begin
        Result := 0;
        Exit;
      end;
      System.Move(aBuffer, (PByte(Memory) + Position)^, aCount);
      Position := LPos;
      Result := aCount;
      Exit;
    end;
  end;
  Result := 0;
end;

function TVirtualBuffer.Write(const aBuffer: TBytes; aOffset, aCount: Longint): Longint;
var
  LPos: Int64;
begin
  if (Position >= 0) and (aCount >= 0) then
  begin
    LPos := Position + aCount;
    if LPos > 0 then
    begin
      if LPos > Size then
      begin
        Result := 0;
        Exit;
      end;
      System.Move(aBuffer[aOffset], (PByte(Memory) + Position)^, aCount);
      Position := LPos;
      Result := aCount;
      Exit;
    end;
  end;
  Result := 0;
end;

procedure TVirtualBuffer.SaveToFile(aFilename: string);
var
  LStream: TFileStream;
begin
  LStream := TFile.Create(aFilename);
  try
    LStream.Write(Memory^, Size);
  finally
    LStream.Free;
  end;
end;

class function TVirtualBuffer.LoadFromFile(const aFilename: string): TVirtualBuffer;
var
  LStream: TStream;
  LBuffer: TVirtualBuffer;
begin
  Result := nil;
  if aFilename.IsEmpty then Exit;
  if not TFile.Exists(aFilename) then Exit;
  LStream := TFile.OpenRead(aFilename);
  try
    LBuffer := TVirtualBuffer.Create(LStream.Size);
    if LBuffer <> nil then
    begin
      LBuffer.CopyFrom(LStream);
    end;
  finally
    FreeAndNil(LStream);
  end;
  Result := LBuffer;
end;

function  TVirtualBuffer.Eob(): Boolean;
begin
  Result := Boolean(Position >= Size);
end;

function  TVirtualBuffer.ReadString(): string;
var
  LLength: LongInt;
begin
  Read(LLength, SizeOf(LLength));
  SetLength(Result, LLength);
  if LLength > 0 then Read(Result[1], LLength * SizeOf(Char));
end;

{ TRingBuffer }
constructor TRingBuffer<T>.Create(ACapacity: Integer);
begin
  SetLength(FBuffer, ACapacity);
  FReadIndex := 0;
  FWriteIndex := 0;
  FCapacity := ACapacity;
  Clear;
end;

function TRingBuffer<T>.Write(const AData: array of T; ACount: Integer): Integer;
var
  i, WritePos: Integer;
begin
  CriticalSection.Enter();
  try
    for i := 0 to ACount - 1 do
    begin
      WritePos := (FWriteIndex + i) mod FCapacity;
      FBuffer[WritePos] := AData[i];
    end;
    FWriteIndex := (FWriteIndex + ACount) mod FCapacity;
    Result := ACount;
  finally
    CriticalSection.Leave();
  end;
end;

function TRingBuffer<T>.Read(var AData: array of T; ACount: Integer): Integer;
var
  i, ReadPos: Integer;
begin
  for i := 0 to ACount - 1 do
  begin
    ReadPos := (FReadIndex + i) mod FCapacity;
    AData[i] := FBuffer[ReadPos];
  end;
  FReadIndex := (FReadIndex + ACount) mod FCapacity;
  Result := ACount;
end;

function TRingBuffer<T>.DirectReadPointer(ACount: Integer): Pointer;
begin
  Result := @FBuffer[FReadIndex mod FCapacity];
  FReadIndex := (FReadIndex + ACount) mod FCapacity;
end;

function TRingBuffer<T>.AvailableBytes(): Integer;
begin
  Result := (FCapacity + FWriteIndex - FReadIndex) mod FCapacity;
end;

procedure TRingBuffer<T>.Clear();
var
  I: Integer;
begin

  CriticalSection.Enter();
  try
    for I := Low(FBuffer) to High(FBuffer) do
    begin
     FBuffer[i] := Default(T);
    end;

    FReadIndex := 0;
    FWriteIndex := 0;
  finally
    CriticalSection.Leave();
  end;
end;

{ TVirtualRingBuffer }
function TVirtualRingBuffer<T>.GetArrayValue(AIndex: Integer): T;
begin
  Result := PType(PByte(FBuffer.Memory) + AIndex * SizeOf(T))^;
end;

procedure TVirtualRingBuffer<T>.SetArrayValue(AIndex: Integer; AValue: T);
begin
  PType(PByte(FBuffer.Memory) + AIndex * SizeOf(T))^ := AValue;
end;

constructor TVirtualRingBuffer<T>.Create(ACapacity: Integer);
begin
  FBuffer := TVirtualBuffer.Create(ACapacity*SizeOf(T));
  FReadIndex := 0;
  FWriteIndex := 0;
  FCapacity := ACapacity;
  Clear;
end;

destructor TVirtualRingBuffer<T>.Destroy;
begin
  FBuffer.Free;
  inherited;
end;

function TVirtualRingBuffer<T>.Write(const AData: array of T; ACount: Integer): Integer;
var
  i, WritePos: Integer;
begin
  CriticalSection.Enter();
  try
    for i := 0 to ACount - 1 do
    begin
      WritePos := (FWriteIndex + i) mod FCapacity;
      SetArrayValue(WritePos, AData[i]);
    end;
    FWriteIndex := (FWriteIndex + ACount) mod FCapacity;
    Result := ACount;
  finally
    CriticalSection.Leave();
  end;
end;

function TVirtualRingBuffer<T>.Read(var AData: array of T; ACount: Integer): Integer;
var
  i, ReadPos: Integer;
begin
  for i := 0 to ACount - 1 do
  begin
    ReadPos := (FReadIndex + i) mod FCapacity;
    AData[i] := GetArrayValue(ReadPos);
  end;
  FReadIndex := (FReadIndex + ACount) mod FCapacity;
  Result := ACount;
end;

function TVirtualRingBuffer<T>.DirectReadPointer(ACount: Integer): Pointer;
begin
  Result := PType(PByte(FBuffer.Memory) + (FReadIndex mod FCapacity) * SizeOf(T));
  FReadIndex := (FReadIndex + ACount) mod FCapacity;
end;

function TVirtualRingBuffer<T>.AvailableBytes(): Integer;
begin
  Result := (FCapacity + FWriteIndex - FReadIndex) mod FCapacity;
end;

procedure TVirtualRingBuffer<T>.Clear();
var
  I: Integer;
begin

  CriticalSection.Enter();
  try
    for I := 0 to FCapacity-1 do
    begin
     SetArrayValue(I, Default(T));
    end;

    FReadIndex := 0;
    FWriteIndex := 0;
  finally
    CriticalSection.Leave();
  end;
end;
{$ENDREGION}

{$REGION ' BASE '}
//=== INTERFACEFACTORY ======================================================
type
  { TInterfaceFactory }
  TInterfaceFactory = class(TBaseObject)
  protected
    FList: TDictionary<TGUID, TBaseInterfaceClass>;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    function RegisterInterface(const AGUID: TGUID; const AClass: TBaseInterfaceClass): Boolean;
    function GetInterface(const AGUID: TGUID; const [ref] AInterface: IBaseInterface): Boolean;
    function ReleaseInterface(const [ref] aInterface: IBaseInterface): Boolean;
    function Count(): NativeInt;
  end;

{ TInterfaceFactory }
constructor TInterfaceFactory.Create;
begin
  FList := TDictionary<TGUID, TBaseInterfaceClass>.Create;
end;

destructor TInterfaceFactory.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TInterfaceFactory.RegisterInterface(const AGUID: TGUID; const AClass: TBaseInterfaceClass): Boolean;
begin
  if Supports(AClass, AGUID) then
    Result := FList.TryAdd(AGUID, AClass)
  else
    Result := False;
end;

function TInterfaceFactory.GetInterface(const AGUID: TGUID; const [ref] AInterface: IBaseInterface): Boolean;
var
  LClass: TBaseInterfaceClass;
begin
  Result := False;
  if FList.TryGetValue(AGUID, LClass) then
    Result := Supports(LClass.Create, AGUID, IBaseInterface(Pointer(@AInterface)^));

  if not Result then
    IBaseInterface(Pointer(@AInterface)^) := nil;
end;

function TInterfaceFactory.ReleaseInterface(const [ref] aInterface: IBaseInterface): Boolean;
var
  LTemp: TBaseInterface;
begin
  Result := False;
  if aInterface = nil then Exit;

  LTemp := TBaseInterface(aInterface);
  IBaseInterface(Pointer(@aInterface)^) := nil;
  LTemp.Free;
  Result := True;
end;

function TInterfaceFactory.Count(): NativeInt;
begin
  Result := FList.Count;
end;

var
  InterfaceFactory: TInterfaceFactory = nil;

function IRegister(const AGUID: TGUID; const AClass: TBaseInterfaceClass): Boolean;
begin
  Result := InterfaceFactory.RegisterInterface(AGUID, AClass);
end;

function IGet(const AGUID: TGUID; const [ref] AInterface: IBaseInterface): Boolean;
begin
  Result := InterfaceFactory.GetInterface(AGUID, AInterface);
end;

function IRelease(const [ref] AInterface: IBaseInterface): Boolean;
begin
  Result := InterfaceFactory.ReleaseInterface(AInterface);
end;

function ICount(): NativeInt;
begin
  Result := InterfaceFactory.Count();
end;

//=== BASEINTERFACE =========================================================
{ TBaseInterface }
constructor TBaseInterface.Create;
begin
  inherited;
end;

destructor TBaseInterface.Destroy;
begin
  inherited;
end;

function  TBaseInterface.GetTag(): string;
begin
  Result := FTag;
end;

procedure TBaseInterface.SetTag(const ATag: string);
begin
  FTag := ATag;
end;

//=== BASEOBJECT ==========================================================
{ TBaseObject }
constructor TBaseObject.Create();
begin
  inherited;
end;

destructor TBaseObject.Destroy();
begin
  inherited;
end;
{$ENDREGION}

{$REGION ' CONSOLE '}
//=== CONSOLE ===============================================================
type
  { IConsole }
  TConsole = class(TBaseInterface, IConsole)
  private
    FInputCodePage: Cardinal;
    FOutputCodePage: Cardinal;
    FTeletypeDelay: Integer;
    FKeyState: array [0..1, 0..255] of Boolean;
    function EnableVirtualTerminalProcessing(): DWORD;
    function WasStartedFromDelphiIDE: Boolean;
  public
    constructor Create(); override;
    destructor Destroy(); override;

    procedure Print(const AMsg: string; const AArgs: array of const); overload;
    procedure PrintLn(const AMsg: string; const AArgs: array of const); overload;

    procedure Print(); overload;
    procedure PrintLn(); overload;

    procedure GetCursorPos(X, Y: PInteger);
    procedure SetCursorPos(const X, Y: Integer);
    procedure SetCursorVisible(const AVisible: Boolean);
    procedure HideCursor();
    procedure ShowCursor();
    procedure SaveCursorPos();
    procedure RestoreCursorPos();
    procedure MoveCursorUp(const ALines: Integer);
    procedure MoveCursorDown(const ALines: Integer);
    procedure MoveCursorForward(const ACols: Integer);
    procedure MoveCursorBack(const ACols: Integer);

    procedure ClearScreen();
    procedure ClearLine();
    procedure ClearLineFromCursor(const AColor: string);

    procedure SetBoldText();
    procedure ResetTextFormat();
    procedure SetForegroundColor(const AColor: string);
    procedure SetBackgroundColor(const AColor: string);
    procedure SetForegroundRGB(const ARed, AGreen, ABlue: Byte);
    procedure SetBackgroundRGB(const ARed, AGreen, ABlue: Byte);

    procedure GetSize(AWidth: PInteger; AHeight: PInteger);

    procedure SetTitle(const ATitle: string);
    function  GetTitle(): string;

    function  HasOutput: Boolean;
    function  WasRunFrom(): Boolean;
    procedure WaitForAnyKey();
    function  AnyKeyPressed(): Boolean;

    procedure ClearKeyStates();
    procedure ClearKeyboardBuffer();

    function  IsKeyPressed(AKey: Byte): Boolean;
    function  WasKeyReleased(AKey: Byte): Boolean;
    function  WasKeyPressed(AKey: Byte): Boolean;

    function  ReadKey(): WideChar;
    function  ReadLnX(const AAllowedChars: TCharSet; AMaxLength: Integer; const AColor: string=CSIFGWhite): string;

    procedure Pause(const AForcePause: Boolean=False; AColor: string=CSIFGWhite; const AMsg: string='');

    function  WrapTextEx(const ALine: string; AMaxCol: Integer; const ABreakChars: TCharSet=[' ', '-', ',', ':', #9]): string;
    procedure Teletype(const AText: string; const AColor: string=CSIFGWhite; const AMargin: Integer=10; const AMinDelay: Integer=0; const AMaxDelay: Integer=3; const ABreakKey: Byte=VK_ESCAPE);
  end;

{ TConsole }
function TConsole.EnableVirtualTerminalProcessing(): DWORD;
var
  HOut: THandle;
  LMode: DWORD;
begin
  HOut := GetStdHandle(STD_OUTPUT_HANDLE);
  if HOut = INVALID_HANDLE_VALUE then
  begin
    Result := GetLastError;
    Exit;
  end;

  if not GetConsoleMode(HOut, LMode) then
  begin
    Result := GetLastError;
    Exit;
  end;

  LMode := LMode or ENABLE_VIRTUAL_TERMINAL_PROCESSING;
  if not SetConsoleMode(HOut, LMode) then
  begin
    Result := GetLastError;
    Exit;
  end;

  Result := 0;  // Success
end;

function TConsole.WasStartedFromDelphiIDE: Boolean;
begin
  // Check if the IDE environment variable is present
  Result := (GetEnvironmentVariable('BDS') <> '');
end;

constructor TConsole.Create();
begin
  inherited;

  FTeletypeDelay := 0;

  // save current console codepage
  FInputCodePage := GetConsoleCP();
  FOutputCodePage := GetConsoleOutputCP();

  // set code page to UTF8
  SetConsoleCP(CP_UTF8);
  SetConsoleOutputCP(CP_UTF8);

  EnableVirtualTerminalProcessing();
end;

destructor TConsole.Destroy();
begin
  // restore code page
  SetConsoleCP(FInputCodePage);
  SetConsoleOutputCP(FOutputCodePage);

  inherited;
end;

procedure TConsole.Print(const AMsg: string; const AArgs: array of const);
begin
  if not HasOutput() then Exit;
  Write(Format(AMsg, AArgs)+CSIResetFormat);
end;

procedure TConsole.PrintLn(const AMsg: string; const AArgs: array of const);
begin
  if not HasOutput() then Exit;
  WriteLn(Format(AMsg, AArgs)+CSIResetFormat);
end;

procedure TConsole.Print();
begin
  if not HasOutput() then Exit;
  Write(CSIResetFormat);
end;

procedure TConsole.PrintLn();
begin
  if not HasOutput() then Exit;
  WriteLn(CSIResetFormat);
end;

procedure TConsole.GetCursorPos(X, Y: PInteger);
var
  hConsole: THandle;
  BufferInfo: TConsoleScreenBufferInfo;
begin
  hConsole := GetStdHandle(STD_OUTPUT_HANDLE);
  if hConsole = INVALID_HANDLE_VALUE then
    Exit;

  if not GetConsoleScreenBufferInfo(hConsole, BufferInfo) then
    Exit;

  if Assigned(X) then
    X^ := BufferInfo.dwCursorPosition.X;
  if Assigned(Y) then
    Y^ := BufferInfo.dwCursorPosition.Y;
end;

procedure TConsole.SetCursorPos(const X, Y: Integer);
begin
  if not HasOutput() then Exit;
  Write(Format(CSICursorPos, [Y, X]));
end;

procedure TConsole.SetCursorVisible(const AVisible: Boolean);
var
  ConsoleInfo: TConsoleCursorInfo;
  ConsoleHandle: THandle;
begin
  ConsoleHandle := GetStdHandle(STD_OUTPUT_HANDLE);
  ConsoleInfo.dwSize := 25; // You can adjust cursor size if needed
  ConsoleInfo.bVisible := AVisible;
  SetConsoleCursorInfo(ConsoleHandle, ConsoleInfo);
end;

procedure TConsole.HideCursor();
begin
  if not HasOutput() then Exit;
  Write(CSIHideCursor);
end;


procedure TConsole.ShowCursor();
begin
  if not HasOutput() then Exit;
  Write(CSIShowCursor);
end;

procedure TConsole.SaveCursorPos();
begin
  if not HasOutput() then Exit;
  Write(CSISaveCursorPos);
end;

procedure TConsole.RestoreCursorPos();
begin
  if not HasOutput() then Exit;
  Write(CSIRestoreCursorPos);
end;

procedure TConsole.MoveCursorUp(const ALines: Integer);
begin
  if not HasOutput() then Exit;
  Write(Format(CSICursorUp, [ALines]));
end;

procedure TConsole.MoveCursorDown(const ALines: Integer);
begin
  if not HasOutput() then Exit;
  Write(Format(CSICursorDown, [ALines]));
end;

procedure TConsole.MoveCursorForward(const ACols: Integer);
begin
  if not HasOutput() then Exit;
  Write(Format(CSICursorForward, [ACols]));
end;

procedure TConsole.MoveCursorBack(const ACols: Integer);
begin
  if not HasOutput() then Exit;
  Write(Format(CSICursorBack, [ACols]));
end;

procedure TConsole.ClearScreen();
begin
  if not HasOutput() then Exit;
  Write(CSIClearScreen);
  SetCursorPos(0, 0);
end;

procedure TConsole.ClearLine();
begin
  if not HasOutput() then Exit;
  Write(CSIClearLine);
end;

procedure TConsole.ClearLineFromCursor(const AColor: string);
var
  LConsoleOutput: THandle;
  LConsoleInfo: TConsoleScreenBufferInfo;
  LNumCharsWritten: DWORD;
  LCoord: TCoord;
begin
  LConsoleOutput := GetStdHandle(STD_OUTPUT_HANDLE);

  if GetConsoleScreenBufferInfo(LConsoleOutput, LConsoleInfo) then
  begin
    LCoord.X := 0;
    LCoord.Y := LConsoleInfo.dwCursorPosition.Y;

    Print(AColor, []);
    FillConsoleOutputCharacter(LConsoleOutput, ' ', LConsoleInfo.dwSize.X
      - LConsoleInfo.dwCursorPosition.X, LCoord, LNumCharsWritten);
    SetConsoleCursorPosition(LConsoleOutput, LCoord);
  end;
end;

procedure TConsole.SetBoldText();
begin
  if not HasOutput() then Exit;
  Write(CSIBold);
end;

procedure TConsole.ResetTextFormat();
begin
  if not HasOutput() then Exit;
  Write(CSIResetFormat);
end;

procedure TConsole.SetForegroundColor(const AColor: string);
begin
  if not HasOutput() then Exit;
  Write(AColor);
end;

procedure TConsole.SetBackgroundColor(const AColor: string);
begin
  if not HasOutput() then Exit;
  Write(AColor);
end;

procedure TConsole.SetForegroundRGB(const ARed, AGreen, ABlue: Byte);
begin
  if not HasOutput() then Exit;
  Write(Format(CSIFGRGB, [ARed, AGreen, ABlue]));
end;

procedure TConsole.SetBackgroundRGB(const ARed, AGreen, ABlue: Byte);
begin
  if not HasOutput() then Exit;
  Write(Format(CSIBGRGB, [ARed, AGreen, ABlue]));
end;

procedure TConsole.GetSize(AWidth: PInteger; AHeight: PInteger);
var
  LConsoleInfo: TConsoleScreenBufferInfo;
begin
  GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), LConsoleInfo);
  if Assigned(AWidth) then
    AWidth^ := LConsoleInfo.dwSize.X;

  if Assigned(AHeight) then
  AHeight^ := LConsoleInfo.dwSize.Y;
end;

procedure TConsole.SetTitle(const ATitle: string);
begin
  WinApi.Windows.SetConsoleTitle(PChar(ATitle));
end;

function  TConsole.GetTitle(): string;
const
  MAX_TITLE_LENGTH = 1024;
var
  LTitle: array[0..MAX_TITLE_LENGTH] of WideChar;
  LTitleLength: DWORD;
begin
  // Get the console title and store it in LTitle
  LTitleLength := GetConsoleTitleW(LTitle, MAX_TITLE_LENGTH);

  // If the title is retrieved, assign it to the result
  if LTitleLength > 0 then
    Result := string(LTitle)
  else
    Result := '';
end;

function  TConsole.HasOutput(): Boolean;
var
  LStdHandle: THandle;
begin
  LStdHandle := GetStdHandle(STD_OUTPUT_HANDLE);
  Result := (LStdHandle <> INVALID_HANDLE_VALUE) and
            (GetFileType(LStdHandle) = FILE_TYPE_CHAR);
end;

function  TConsole.WasRunFrom(): Boolean;
var
  LStartupInfo: TStartupInfo;
begin
  LStartupInfo.cb := SizeOf(TStartupInfo);
  GetStartupInfo(LStartupInfo);
  Result := ((LStartupInfo.dwFlags and STARTF_USESHOWWINDOW) = 0);
end;

procedure TConsole.WaitForAnyKey();
var
  LInputRec: TInputRecord;
  LNumRead: Cardinal;
  LOldMode: DWORD;
  LStdIn: THandle;
begin
  LStdIn := GetStdHandle(STD_INPUT_HANDLE);
  GetConsoleMode(LStdIn, LOldMode);
  SetConsoleMode(LStdIn, 0);
  repeat
    ReadConsoleInput(LStdIn, LInputRec, 1, LNumRead);
  until (LInputRec.EventType and KEY_EVENT <> 0) and
    LInputRec.Event.KeyEvent.bKeyDown;
  SetConsoleMode(LStdIn, LOldMode);
end;

function  TConsole.AnyKeyPressed(): Boolean;
var
  LNumberOfEvents     : DWORD;
  LBuffer             : TInputRecord;
  LNumberOfEventsRead : DWORD;
  LStdHandle           : THandle;
begin
  Result:=false;
  //get the console handle
  LStdHandle := GetStdHandle(STD_INPUT_HANDLE);
  LNumberOfEvents:=0;
  //get the number of events
  GetNumberOfConsoleInputEvents(LStdHandle,LNumberOfEvents);
  if LNumberOfEvents<> 0 then
  begin
    //retrieve the event
    PeekConsoleInput(LStdHandle,LBuffer,1,LNumberOfEventsRead);
    if LNumberOfEventsRead <> 0 then
    begin
      if LBuffer.EventType = KEY_EVENT then //is a Keyboard event?
      begin
        if LBuffer.Event.KeyEvent.bKeyDown then //the key was pressed?
          Result:=true
        else
          FlushConsoleInputBuffer(LStdHandle); //flush the buffer
      end
      else
      FlushConsoleInputBuffer(LStdHandle);//flush the buffer
    end;
  end;
end;

procedure TConsole.ClearKeyStates();
begin
  FillChar(FKeyState, SizeOf(FKeyState), 0);
  ClearKeyboardBuffer();
end;

procedure TConsole.ClearKeyboardBuffer();
var
  LInputRecord: TInputRecord;
  LEventsRead: DWORD;
  LMsg: TMsg;
begin
  while PeekConsoleInput(GetStdHandle(STD_INPUT_HANDLE), LInputRecord, 1, LEventsRead) and (LEventsRead > 0) do
  begin
    ReadConsoleInput(GetStdHandle(STD_INPUT_HANDLE), LInputRecord, 1, LEventsRead);
  end;

  while PeekMessage(LMsg, 0, WM_KEYFIRST, WM_KEYLAST, PM_REMOVE) do
  begin
    // No operation; just removing messages from the queue
  end;
end;

function  TConsole.IsKeyPressed(AKey: Byte): Boolean;
begin
  Result := (GetAsyncKeyState(AKey) and $8000) <> 0;
end;

function  TConsole.WasKeyReleased(AKey: Byte): Boolean;
begin
  Result := False;
  if IsKeyPressed(AKey) and (not FKeyState[1, AKey]) then
  begin
    FKeyState[1, AKey] := True;
    Result := True;
  end
  else if (not IsKeyPressed(AKey)) and (FKeyState[1, AKey]) then
  begin
    FKeyState[1, AKey] := False;
    Result := False;
  end;
end;

function  TConsole.WasKeyPressed(AKey: Byte): Boolean;
begin
  Result := False;
  if IsKeyPressed(AKey) and (not FKeyState[1, AKey]) then
  begin
    FKeyState[1, AKey] := True;
    Result := False;
  end
  else if (not IsKeyPressed(AKey)) and (FKeyState[1, AKey]) then
  begin
    FKeyState[1, AKey] := False;
    Result := True;
  end;
end;

function  TConsole.ReadKey(): WideChar;
var
  LInputRecord: TInputRecord;
  LEventsRead: DWORD;
begin
  repeat
    ReadConsoleInput(GetStdHandle(STD_INPUT_HANDLE), LInputRecord, 1, LEventsRead);
  until (LInputRecord.EventType = KEY_EVENT) and LInputRecord.Event.KeyEvent.bKeyDown;
  Result := LInputRecord.Event.KeyEvent.UnicodeChar;
end;

function  TConsole.ReadLnX(const AAllowedChars: TCharSet; AMaxLength: Integer; const AColor: string): string;
var
  LInputChar: Char;
begin
  Result := '';

  repeat
    LInputChar := ReadKey;

    if CharInSet(LInputChar, AAllowedChars) then
    begin
      if Length(Result) < AMaxLength then
      begin
        if not CharInSet(LInputChar, [#10, #0, #13, #8])  then
        begin
          //Print(LInputChar, AColor);
          Print('%s%s', [AColor, LInputChar]);
          Result := Result + LInputChar;
        end;
      end;
    end;
    if LInputChar = #8 then
    begin
      if Length(Result) > 0 then
      begin
        //Print(#8 + ' ' + #8);
        Print(#8 + ' ' + #8, []);
        Delete(Result, Length(Result), 1);
      end;
    end;
  until (LInputChar = #13);

  PrintLn();
end;

procedure TConsole.Pause(const AForcePause: Boolean; AColor: string; const AMsg: string);
var
  LDoPause: Boolean;
begin
  if not HasOutput then Exit;

  ClearKeyboardBuffer();

  if not AForcePause then
  begin
    LDoPause := True;
    if WasRunFrom() then LDoPause := False;
    if WasStartedFromDelphiIDE() then LDoPause := True;
    if not LDoPause then Exit;
  end;

  WriteLn;
  if AMsg = '' then
    Print('%sPress any key to continue... ', [aColor])
  else
    Print('%s%s', [aColor, AMsg]);

  WaitForAnyKey();
  WriteLn;
end;

function  TConsole.WrapTextEx(const ALine: string; AMaxCol: Integer; const ABreakChars: TCharSet): string;
var
  LText: string;
  LPos: integer;
  LChar: Char;
  LLen: Integer;
  I: Integer;
begin
  LText := ALine.Trim;

  LPos := 0;
  LLen := 0;

  while LPos < LText.Length do
  begin
    Inc(LPos);

    LChar := LText[LPos];

    if LChar = #10 then
    begin
      LLen := 0;
      continue;
    end;

    Inc(LLen);

    if LLen >= AMaxCol then
    begin
      for I := LPos downto 1 do
      begin
        LChar := LText[I];

        if CharInSet(LChar, ABreakChars) then
        begin
          LText.Insert(I, #10);
          Break;
        end;
      end;

      LLen := 0;
    end;
  end;

  Result := LText;
end;

procedure TConsole.Teletype(const AText: string; const AColor: string; const AMargin: Integer; const AMinDelay: Integer; const AMaxDelay: Integer; const ABreakKey: Byte);
var
  LText: string;
  LMaxCol: Integer;
  LChar: Char;
  LWidth: Integer;
begin
  GetSize(@LWidth, nil);
  LMaxCol := LWidth - AMargin;

  LText := WrapTextEx(AText, LMaxCol);

  for LChar in LText do
  begin
    ProcessMessages();
    Print('%s%s', [AColor, LChar]);
    if not Math.RandomBool() then
      FTeletypeDelay := Math.RandomRange(AMinDelay, AMaxDelay);
    Wait(FTeletypeDelay);
    if IsKeyPressed(ABreakKey) then
    begin
      ClearKeyboardBuffer;
      Break;
    end;
  end;
end;
{$ENDREGION}

{$REGION ' MATH '}
//=== MATH ==================================================================
type
  TMath = class(TBaseInterface, IMath)
  private
    FCosTable: array [0..360] of Single;
    FSinTable: array [0..360] of Single;
  public
    constructor Create(); override;

    function Point(const X, Y: Single): TPoint;
    function Vector(const X, Y: Single): TVector;
    function Size(const W, H: Single): TSize;
    function Rect(const X, Y, W, H: Single): TRect;
    function Extent(const AMinX, AMinY, AMaxX, AMaxY: Single): TExtent;

    procedure AssignVector(var A: TVector; const B: TVector); overload;
    procedure ClearVector(var A: TVector);
    procedure AddVector(var A: TVector; const B: TVector);
    procedure SubVector(var A: TVector; const B: TVector);
    procedure MulVector(var A: TVector; const B: TVector);
    procedure DivideVector(var A: TVector; const B: TVector); overload;
    procedure DivideVictor(var A: TVector; const AValue: Single); overload;
    function  VectorMagnitude(const A: TVector): Single;
    function  VectorMagnitudeTruncate(const A: TVector; const AMaxMagnitude: Single): TVector;
    function  VectorDistance(const A, B: TVector): Single;
    procedure NormalizeVector(var A: TVector);
    function  VectorAngle(const A, B: TVector): Single;
    procedure ThrustVector(var A: TVector; const AAngle, ASpeed: Single);
    function  VectorMagnitudeSquared(const A: TVector): Single;
    function  VectorDotProduct(const A, B: TVector): Single;
    procedure ScaleVectory(var A: TVector; const AValue: Single);
    function  ProjectVector(const A, B: TVector): TVector;
    procedure NegateVector(var A: TVector);

    function  UnitToScalarValue(const AValue, AMaxValue: Double): Double;

    function AngleCos(const AAngle: Cardinal): Single;
    function AngleSin(const AAngle: Cardinal): Single;

    function  RandomRange(const AMin, AMax: Integer): Integer;
    function  RandomRangef(const AMin, AMax: Single): Single;
    function  RandomBool(): Boolean;
    function  GetRandomSeed(): Integer;
    procedure SetRandomSeed(const AVaLue: Integer);
    function  ClipVaLuef(var AVaLue: Single; const AMin, AMax: Single; const AWrap: Boolean): Single;
    function  ClipVaLue(var AVaLue: Integer; const aMin, AMax: Integer; const AWrap: Boolean): Integer;
    function  SameSign(const AVaLue1, AVaLue2: Integer): Boolean;
    function  SameSignf(const AVaLue1, AVaLue2: Single): Boolean;
    function  SameVaLue(const AA, AB: Double; const AEpsilon: Double = 0): Boolean;
    function  SameVaLuef(const AA, AB: Single; const AEpsilon: Single = 0): Boolean;
    function  AngleDiff(const ASrcAngle, ADestAngle: Single): Single;
    procedure AngleRotatePos(const AAngle: Single; var AX, AY: Single);
    procedure SmoothMove(var AVaLue: Single; const AAmount, AMax, ADrag: Single);
    function  Lerp(const AFrom, ATo, ATime: Double): Double;
    function  PointInRectangle(APoint: TVector; ARect: TRect): Boolean;
    function  PointInCircle(APoint, ACenter: TVector; ARadius: Single): Boolean;
    function  PointInTriangle(APoint, AP1, AP2, AP3: TVector): Boolean;
    function  CirclesOverlap(ACenter1: TVector; ARadius1: Single; ACenter2: TVector; ARadius2: Single): Boolean;
    function  CircleInRectangle(ACenter: TVector; ARadius: Single; ARect: TRect): Boolean;
    function  RectanglesOverlap(ARect1: TRect; ARect2: TRect): Boolean;
    function  RectangleIntersection(ARect1, ARect2: TRect): TRect;
    function  LineIntersection(AX1, AY1, AX2, AY2, AX3, AY3, AX4, AY4: Integer; var AX: Integer; var AY: Integer): TLineIntersection;
    function  RadiusOverlap(ARadius1, AX1, AY1, ARadius2, AX2, AY2, AShrinkFactor: Single): Boolean;
    function  EaseValue(ACurrentTime: Double; AStartValue: Double; AChangeInValue: Double; ADuration: Double; AEaseType: TEaseType): Double;
    function  EasePosition(AStartPos: Double; AEndPos: Double; ACurrentPos: Double; AEaseType: TEaseType): Double;

    function OBBIntersect(const AObbA, AObbB: TOBB): Boolean;
  end;

{ TMath }
constructor TMath.Create();
var
  I: Integer;
begin
  inherited;

  // init sin/cos tables
  for I := 0 to 360 do
  begin
    FCosTable[I] := cos((I * PI / 180.0));
    FSinTable[I] := sin((I * PI / 180.0));
  end;
end;

function TMath.Point(const X, Y: Single): TPoint;
begin
  Result.x := X;
  Result.y := Y;
end;

function TMath.Vector(const X, Y: Single): TVector;
begin
  Result.x := X;
  Result.y := Y;
  Result.z := 0;
  Result.w := 0;
end;

function TMath.Size(const W, H: Single): TSize;
begin
  Result.w := W;
  Result.h := H;
end;

function TMath.Rect(const X, Y, W, H: Single): TRect;
begin
  Result.pos.x := X;
  Result.pos.y := Y;
  Result.size.w := W;
  Result.size.h := H;
end;

function TMath.Extent(const AMinX, AMinY, AMaxX, AMaxY: Single): TExtent;
begin
  Result.min.x := AMinX;
  Result.min.y := AMinY;

  Result.max.x := AMaxX;
  Result.max.y := AMaxY;
end;

procedure TMath.AssignVector(var A: TVector; const B: TVector);
begin
  A := B;
end;

procedure TMath.ClearVector(var A: TVector);
begin
  A := Default(TVector);
end;

procedure TMath.AddVector(var A: TVector; const B: TVector);
begin
  A.x := A.x + B.x;
  A.y := A.y + B.y;
end;

procedure TMath.SubVector(var A: TVector; const B: TVector);
begin
  A.x := A.x - B.x;
  A.y := A.y - B.y;
end;

procedure TMath.MulVector(var A: TVector; const B: TVector);
begin
  A.x := A.x * B.x;
  A.y := A.y * B.y;
end;

procedure TMath.DivideVector(var A: TVector; const B: TVector);
begin
  A.x := A.x / B.x;
  A.y := A.y / B.y;
end;

procedure TMath.DivideVictor(var A: TVector; const AValue: Single);
begin
begin
  A.x := A.x / AValue;
  A.y := A.y / AValue;
end;
end;

function  TMath.VectorMagnitude(const A: TVector): Single;
begin
  Result := Sqrt((A.x * A.x) + (A.y * A.y));
end;

function  TMath.VectorMagnitudeTruncate(const A: TVector; const AMaxMagnitude: Single): TVector;
var
  LMaxMagSqrd: Single;
  LVecMagSqrd: Single;
  LTruc: Single;
begin
  Result := Default(TVector);
  Result.x := A.x;
  Result.y := A.y;

  LMaxMagSqrd := AMaxMagnitude * AMaxMagnitude;
  LVecMagSqrd := VectorMagnitude(Result);
  if LVecMagSqrd > LMaxMagSqrd then
  begin
    LTruc := (AMaxMagnitude / Sqrt(LVecMagSqrd));
    Result.x := Result.x * LTruc;
    Result.y := Result.y * LTruc;
  end;
end;

function  TMath.VectorDistance(const A, B: TVector): Single;
var
  LDirVec: TVector;
begin
  LDirVec.x := A.x - B.x;
  LDirVec.y := A.y - B.y;
  Result := VectorMagnitude(LDirVec);
end;

procedure TMath.NormalizeVector(var A: TVector);
var
  LLen, LOOL: Single;
begin
  LLen := VectorMagnitude(A);
  if LLen <> 0 then
  begin
    LOOL := 1.0 / LLen;
    A.x := A.x * LOOL;
    A.y := A.y * LOOL;
  end;
end;

function  TMath.VectorAngle(const A, B: TVector): Single;
var
  LXOY: Single;
  LR: TVector;
begin
  AssignVector(LR, A);
  SubVector(LR, B);
  NormalizeVector(LR);

  if LR.y = 0 then
  begin
    LR.y := 0.001;
  end;

  LXOY := LR.x / LR.y;

  Result := ArcTan(LXOY) * RADTODEG;
  if LR.y < 0 then
    Result := Result + 180.0;
end;


procedure TMath.ThrustVector(var A: TVector; const AAngle, ASpeed: Single);
var
  LA: Single;
begin
  LA := AAngle + 90.0;
  ClipValuef(LA, 0, 360, True);

  A.x := A.x + AngleCos(Round(LA)) * -(aSpeed);
  A.y := A.y + AngleSin(Round(LA)) * -(aSpeed);
end;

function  TMath.VectorMagnitudeSquared(const A: TVector): Single;
begin
  Result := (A.x * A.x) + (A.y * A.y);
end;

function  TMath.VectorDotProduct(const A, B: TVector): Single;
begin
  Result := (A.x * B.x) + (A.y * B.y);
end;

procedure TMath.ScaleVectory(var A: TVector; const AValue: Single);
begin
  A.x := A.x * AValue;
  A.y := A.y * AValue;
end;

function  TMath.ProjectVector(const A, B: TVector): TVector;
var
  LDP: Single;
begin
  LDP :=  VectorDotProduct(A, B);
  Result.x := (LDP / (B.x * B.x + B.y * B.y)) * B.x;
  Result.y := (LDP / (B.x * B.x + B.y * B.y)) * B.y;
end;

procedure TMath.NegateVector(var A: TVector);
begin
  A.x := -A.x;
  A.y := -A.y;
end;

function  TMath.UnitToScalarValue(const AValue, AMaxValue: Double): Double;
var
  LGain: Double;
  LFactor: Double;
  LVolume: Double;
begin
  LGain := (EnsureRange(AValue, 0.0, 1.0) * 50) - 50;
  LFactor := Power(10, LGain * 0.05);
  LVolume := EnsureRange(AMaxValue * LFactor, 0, AMaxValue);
  Result := LVolume;
end;

function TMath.AngleCos(const AAngle: Cardinal): Single;
var
  LAngle: Cardinal;
begin
  LAngle := EnsureRange(AAngle, 0, 360);
  Result := FCosTable[LAngle];
end;

function TMath.AngleSin(const AAngle: Cardinal): Single;
var
  LAngle: Cardinal;
begin
  LAngle := EnsureRange(AAngle, 0, 360);
  Result := FSinTable[LAngle];
end;

function _RandomRange(const aFrom, aTo: Integer): Integer;
var
  LFrom: Integer;
  LTo: Integer;
begin
  LFrom := aFrom;
  LTo := aTo;

  if AFrom > ATo then
    Result := Random(LFrom - LTo) + ATo
  else
    Result := Random(LTo - LFrom) + AFrom;
end;

function  TMath.RandomRange(const AMin, AMax: Integer): Integer;
begin
  Result := _RandomRange(AMin, AMax + 1);
end;

function  TMath.RandomRangef(const AMin, AMax: Single): Single;
var
  LNum: Single;
begin
  LNum := _RandomRange(0, MaxInt) / MaxInt;
  Result := AMin + (LNum * (AMax - AMin));
end;

function  TMath.RandomBool(): Boolean;
begin
  Result := Boolean(_RandomRange(0, 2) = 1);
end;

function  TMath.GetRandomSeed(): Integer;
begin
  Result := System.RandSeed;
end;

procedure TMath.SetRandomSeed(const AVaLue: Integer);
begin
  System.RandSeed := AVaLue;
end;

function  TMath.ClipVaLuef(var AVaLue: Single; const AMin, AMax: Single; const AWrap: Boolean): Single;
begin
  if AWrap then
    begin
      if (AVaLue > AMax) then
      begin
        AVaLue := AMin + Abs(AVaLue - AMax);
        if AVaLue > AMax then
          AVaLue := AMax;
      end
      else if (AVaLue < AMin) then
      begin
        AVaLue := AMax - Abs(AVaLue - AMin);
        if AVaLue < AMin then
          AVaLue := AMin;
      end
    end
  else
    begin
      if AVaLue < AMin then
        AVaLue := AMin
      else if AVaLue > AMax then
        AVaLue := AMax;
    end;

  Result := AVaLue;
end;

function  TMath.ClipVaLue(var AVaLue: Integer; const aMin, AMax: Integer; const AWrap: Boolean): Integer;
begin
  if AWrap then
    begin
      if (AVaLue > AMax) then
      begin
        AVaLue := aMin + Abs(AVaLue - AMax);
        if AVaLue > AMax then
          AVaLue := AMax;
      end
      else if (AVaLue < aMin) then
      begin
        AVaLue := AMax - Abs(AVaLue - aMin);
        if AVaLue < aMin then
          AVaLue := aMin;
      end
    end
  else
    begin
      if AVaLue < aMin then
        AVaLue := aMin
      else if AVaLue > AMax then
        AVaLue := AMax;
    end;

  Result := AVaLue;
end;

function  TMath.SameSign(const AVaLue1, AVaLue2: Integer): Boolean;
begin
  if Sign(AVaLue1) = Sign(AVaLue2) then
    Result := True
  else
    Result := False;
end;

function  TMath.SameSignf(const AVaLue1, AVaLue2: Single): Boolean;
begin
  if System.Math.Sign(AVaLue1) = System.Math.Sign(AVaLue2) then
    Result := True
  else
    Result := False;
end;

function  TMath.SameValue(const AA, AB: Double; const AEpsilon: Double = 0): Boolean;
begin
  Result := System.Math.SameVaLue(AA, AB, AEpsilon);
end;

function  TMath.SameVaLuef(const AA, AB: Single; const AEpsilon: Single = 0): Boolean;
begin
  Result := System.Math.SameVaLue(AA, AB, AEpsilon);
end;

function  TMath.AngleDiff(const ASrcAngle, ADestAngle: Single): Single;
var
  LAngleDiff: Single;
begin
  LAngleDiff := ADestAngle-ASrcAngle-(Floor((ADestAngle-ASrcAngle)/360.0)*360.0);

  if LAngleDiff >= (360.0 / 2) then
  begin
    LAngleDiff := LAngleDiff - 360.0;
  end;
  Result := LAngleDiff;
end;

procedure TMath.AngleRotatePos(const AAngle: Single; var AX, AY: Single);
var
  LNX,LNY: Single;
  LIA: Integer;
  LAngle: Single;
begin
  LAngle := EnsureRange(AAngle, 0, 360);

  LIA := Round(LAngle);

  LNX := AX*FCosTable[LIA] - AY*FSinTable[LIA];
  LNY := AY*FCosTable[LIA] + AX*FSinTable[LIA];

  AX := LNX;
  AY := LNY;
end;

procedure TMath.SmoothMove(var AVaLue: Single; const AAmount, AMax, ADrag: Single);
var
  LAmt: Single;
begin
  LAmt := AAmount;

  if LAmt > 0 then
  begin
    AVaLue := AVaLue + LAmt;
    if AVaLue > AMax then
      AVaLue := AMax;
  end else if LAmt < 0 then
  begin
    AVaLue := AVaLue + LAmt;
    if AVaLue < -AMax then
      AVaLue := -AMax;
  end else
  begin
    if AVaLue > 0 then
    begin
      AVaLue := AVaLue - ADrag;
      if AVaLue < 0 then
        AVaLue := 0;
    end else if AVaLue < 0 then
    begin
      AVaLue := AVaLue + ADrag;
      if AVaLue > 0 then
        AVaLue := 0;
    end;
  end;
end;

function  TMath.Lerp(const AFrom, ATo, ATime: Double): Double;
begin
  if ATime <= 0.5 then
    Result := AFrom + (ATo - AFrom) * ATime
  else
    Result := ATo - (ATo - AFrom) * (1.0 - ATime);
end;

function  TMath.PointInRectangle(APoint: TVector; ARect: TRect): Boolean;
begin
  if ((APoint.x >= ARect.pos.x) and (APoint.x <= (ARect.pos.x + ARect.size.w)) and
    (APoint.y >= ARect.pos.y) and (APoint.y <= (ARect.pos.y + ARect.size.h))) then
    Result := True
  else
    Result := False;
end;

function  TMath.PointInCircle(APoint, ACenter: TVector; ARadius: Single): Boolean;
begin
  Result := CirclesOverlap(APoint, 0, ACenter, ARadius);
end;

function  TMath.PointInTriangle(APoint, AP1, AP2, AP3: TVector): Boolean;
var
  LAlpha, LBeta, LGamma: Single;
begin
  LAlpha := ((AP2.y - AP3.y) * (APoint.x - AP3.x) + (AP3.x - AP2.x) *
    (APoint.y - AP3.y)) / ((AP2.y - AP3.y) * (AP1.x - AP3.x) + (AP3.x - AP2.x) *
    (AP1.y - AP3.y));

  LBeta := ((AP3.y - AP1.y) * (APoint.x - AP3.x) + (AP1.x - AP3.x) *
    (APoint.y - AP3.y)) / ((AP2.y - AP3.y) * (AP1.x - AP3.x) + (AP3.x - AP2.x) *
    (AP1.y - AP3.y));

  LGamma := 1.0 - LAlpha - LBeta;

  if ((LAlpha > 0) and (LBeta > 0) and (LGamma > 0)) then
    Result := True
  else
    Result := False;
end;

function  TMath.CirclesOverlap(ACenter1: TVector; ARadius1: Single; ACenter2: TVector; ARadius2: Single): Boolean;
var
  LDX, LDY, LDistance: Single;
begin
  LDX := ACenter2.x - ACenter1.x; // X distance between centers
  LDY := ACenter2.y - ACenter1.y; // Y distance between centers

  LDistance := sqrt(LDX * LDX + LDY * LDY); // Distance between centers

  if (LDistance <= (ARadius1 + ARadius2)) then
    Result := True
  else
    Result := False;
end;

function  TMath.CircleInRectangle(ACenter: TVector; ARadius: Single; ARect: TRect): Boolean;
var
  LDX, LDY: Single;
  LCornerDistanceSq: Single;
  LRecCenterX: Integer;
  LRecCenterY: Integer;
begin
  LRecCenterX := Round(ARect.pos.x + ARect.size.w / 2);
  LRecCenterY := Round(ARect.pos.y + ARect.size.h / 2);

  LDX := abs(ACenter.x - LRecCenterX);
  LDY := abs(ACenter.y - LRecCenterY);

  if (LDX > (ARect.size.w / 2.0 + ARadius)) then
  begin
    Result := False;
    Exit;
  end;

  if (LDY > (ARect.size.h / 2.0 + ARadius)) then
  begin
    Result := False;
    Exit;
  end;

  if (LDX <= (ARect.size.w / 2.0)) then
  begin
    Result := True;
    Exit;
  end;
  if (LDY <= (ARect.size.h / 2.0)) then
  begin
    Result := True;
    Exit;
  end;

  LCornerDistanceSq := (LDX - ARect.size.w / 2.0) * (LDX - ARect.size.w / 2.0) +
    (LDY - ARect.size.h / 2.0) * (LDY - ARect.size.h / 2.0);

  Result := Boolean(LCornerDistanceSq <= (ARadius * ARadius));
end;

function  TMath.RectanglesOverlap(ARect1: TRect; ARect2: TRect): Boolean;
var
  LDX, LDY: Single;
begin
  LDX := abs((ARect1.pos.x + ARect1.size.w / 2) - (ARect2.pos.x + ARect2.size.w / 2));
  LDY := abs((ARect1.pos.y + ARect1.size.h / 2) - (ARect2.pos.y + ARect2.size.h / 2));

  if ((LDX <= (ARect1.size.w / 2 + ARect2.size.w / 2)) and
    ((LDY <= (ARect1.size.h / 2 + ARect2.size.h / 2)))) then
    Result := True
  else
    Result := False;
end;

function  TMath.RectangleIntersection(ARect1, ARect2: TRect): TRect;
var
  LDXX, LDYY: Single;
begin
  Result := Rect(0, 0, 0, 0);

  if RectanglesOverlap(ARect1, ARect2) then
  begin
    LDXX := abs(ARect1.pos.x - ARect2.pos.x);
    LDYY := abs(ARect1.pos.y - ARect2.pos.y);

    if (ARect1.pos.x <= ARect2.pos.x) then
    begin
      if (ARect1.pos.y <= ARect2.pos.y) then
      begin
        Result.pos.x := ARect2.pos.x;
        Result.pos.y := ARect2.pos.y;
        Result.size.w := ARect1.size.w - LDXX;
        Result.size.h := ARect1.size.h - LDYY;
      end
      else
      begin
        Result.pos.x := ARect2.pos.x;
        Result.pos.y := ARect1.pos.y;
        Result.size.w := ARect1.size.w - LDXX;
        Result.size.h := ARect2.size.h - LDYY;
      end
    end
    else
    begin
      if (ARect1.pos.y <= ARect2.pos.y) then
      begin
        Result.pos.x := ARect1.pos.x;
        Result.pos.y := ARect2.pos.y;
        Result.size.w := ARect2.size.w - LDXX;
        Result.size.h := ARect1.size.h - LDYY;
      end
      else
      begin
        Result.pos.x := ARect1.pos.x;
        Result.pos.y := ARect1.pos.y;
        Result.size.w := ARect2.size.w - LDXX;
        Result.size.h := ARect2.size.h - LDYY;
      end
    end;

    if (ARect1.size.w > ARect2.size.w) then
    begin
      if (Result.size.w >= ARect2.size.w) then
        Result.size.w := ARect2.size.w;
    end
    else
    begin
      if (Result.size.w >= ARect1.size.w) then
        Result.size.w := ARect1.size.w;
    end;

    if (ARect1.size.h > ARect2.size.h) then
    begin
      if (Result.size.h >= ARect2.size.h) then
        Result.size.h := ARect2.size.h;
    end
    else
    begin
      if (Result.size.h >= ARect1.size.h) then
        Result.size.h := ARect1.size.h;
    end
  end;
end;

function  TMath.LineIntersection(AX1, AY1, AX2, AY2, AX3, AY3, AX4, AY4: Integer; var AX: Integer; var AY: Integer): TLineIntersection;
var
  LAX, LBX, LCX, LAY, LBY, LCY, LD, LE, LF, LNum: Integer;
  LOffset: Integer;
  LX1Lo, LX1Hi, LY1Lo, LY1Hi: Integer;
begin
  Result := liNone;

  LAX := AX2 - AX1;
  LBX := AX3 - AX4;

  if (LAX < 0) then // X bound box test
  begin
    LX1Lo := AX2;
    LX1Hi := AX1;
  end
  else
  begin
    LX1Hi := AX2;
    LX1Lo := AX1;
  end;

  if (LBX > 0) then
  begin
    if (LX1Hi < AX4) or (AX3 < LX1Lo) then
      Exit;
  end
  else
  begin
    if (LX1Hi < AX3) or (AX4 < LX1Lo) then
      Exit;
  end;

  LAY := AY2 - AY1;
  LBY := AY3 - AY4;

  if (LAY < 0) then // Y bound box test
  begin
    LY1Lo := AY2;
    LY1Hi := AY1;
  end
  else
  begin
    LY1Hi := AY2;
    LY1Lo := AY1;
  end;

  if (LBY > 0) then
  begin
    if (LY1Hi < AY4) or (AY3 < LY1Lo) then
      Exit;
  end
  else
  begin
    if (LY1Hi < AY3) or (AY4 < LY1Lo) then
      Exit;
  end;

  LCX := AX1 - AX3;
  LCY := AY1 - AY3;
  LD := LBY * LCX - LBX * LCY; // alpha numerator
  LF := LAY * LBX - LAX * LBY; // both denominator

  if (LF > 0) then // alpha tests
  begin
    if (LD < 0) or (LD > LF) then
      Exit;
  end
  else
  begin
    if (LD > 0) or (LD < LF) then
      Exit
  end;

  LE := LAX * LCY - LAY * LCX; // beta numerator
  if (LF > 0) then // beta tests
  begin
    if (LE < 0) or (LE > LF) then
      Exit;
  end
  else
  begin
    if (LE > 0) or (LE < LF) then
      Exit;
  end;

  // compute intersection coordinates
  if (LF = 0) then
  begin
    Result := liParallel;
    Exit;
  end;

  LNum := LD * LAX; // numerator
  // if SameSigni(num, f) then
  if Sign(LNum) = Sign(LF) then

    LOffset := LF div 2
  else
    LOffset := -LF div 2;
  AX := AX1 + (LNum + LOffset) div LF; // intersection x

  LNum := LD * LAY;
  // if SameSigni(num, f) then
  if Sign(LNum) = Sign(LF) then
    LOffset := LF div 2
  else
    LOffset := -LF div 2;

  AY := AY1 + (LNum + LOffset) div LF; // intersection y

  Result := liTrue;
end;

function  TMath.RadiusOverlap(ARadius1, AX1, AY1, ARadius2, AX2, AY2, AShrinkFactor: Single): Boolean;
var
  LDist: Single;
  LR1, LR2: Single;
  LV1, LV2: TVector;
begin
  LR1 := ARadius1 * AShrinkFactor;
  LR2 := ARadius2 * AShrinkFactor;

  LV1.x := AX1;
  LV1.y := AY1;
  LV2.x := AX2;
  LV2.y := AY2;

  //LDist := LV1.distance(LV2);
  LDist := VectorDistance(LV1, LV2);

  if (LDist < LR1) or (LDist < LR2) then
    Result := True
  else
    Result := False;
end;

function  TMath.EaseValue(ACurrentTime: Double; AStartValue: Double; AChangeInValue: Double; ADuration: Double; AEaseType: TEaseType): Double;
begin
  Result := 0;
  case AEaseType of
    etLinearTween:
      begin
        Result := AChangeInValue * ACurrentTime / ADuration + AStartValue;
      end;

    etInQuad:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := AChangeInValue * ACurrentTime * ACurrentTime + AStartValue;
      end;

    etOutQuad:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := -AChangeInValue * ACurrentTime * (ACurrentTime-2) + AStartValue;
      end;

    etInOutQuad:
      begin
        ACurrentTime := ACurrentTime / (ADuration / 2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * ACurrentTime * ACurrentTime + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 1;
          Result := -AChangeInValue / 2 * (ACurrentTime * (ACurrentTime - 2) - 1) + AStartValue;
        end;
      end;

    etInCubic:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := AChangeInValue * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue;
      end;

    etOutCubic:
      begin
        ACurrentTime := (ACurrentTime / ADuration) - 1;
        Result := AChangeInValue * ( ACurrentTime * ACurrentTime * ACurrentTime + 1) + AStartValue;
      end;

    etInOutCubic:
      begin
        ACurrentTime := ACurrentTime / (ADuration/2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 2;
          Result := AChangeInValue / 2 * (ACurrentTime * ACurrentTime * ACurrentTime + 2) + AStartValue;
        end;
      end;

    etInQuart:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := AChangeInValue * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue;
      end;

    etOutQuart:
      begin
        ACurrentTime := (ACurrentTime / ADuration) - 1;
        Result := -AChangeInValue * (ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime - 1) + AStartValue;
      end;

    etInOutQuart:
      begin
        ACurrentTime := ACurrentTime / (ADuration / 2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 2;
          Result := -AChangeInValue / 2 * (ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime - 2) + AStartValue;
        end;
      end;

    etInQuint:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := AChangeInValue * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue;
      end;

    etOutQuint:
      begin
        ACurrentTime := (ACurrentTime / ADuration) - 1;
        Result := AChangeInValue * (ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + 1) + AStartValue;
      end;

    etInOutQuint:
      begin
        ACurrentTime := ACurrentTime / (ADuration / 2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 2;
          Result := AChangeInValue / 2 * (ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + 2) + AStartValue;
        end;
      end;

    etInSine:
      begin
        Result := -AChangeInValue * Cos(ACurrentTime / ADuration * (PI / 2)) + AChangeInValue + AStartValue;
      end;

    etOutSine:
      begin
        Result := AChangeInValue * Sin(ACurrentTime / ADuration * (PI / 2)) + AStartValue;
      end;

    etInOutSine:
      begin
        Result := -AChangeInValue / 2 * (Cos(PI * ACurrentTime / ADuration) - 1) + AStartValue;
      end;

    etInExpo:
      begin
        Result := AChangeInValue * Power(2, 10 * (ACurrentTime/ADuration - 1) ) + AStartValue;
      end;

    etOutExpo:
      begin
        Result := AChangeInValue * (-Power(2, -10 * ACurrentTime / ADuration ) + 1 ) + AStartValue;
      end;

    etInOutExpo:
      begin
        ACurrentTime := ACurrentTime / (ADuration/2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * Power(2, 10 * (ACurrentTime - 1) ) + AStartValue
        else
         begin
           ACurrentTime := ACurrentTime - 1;
           Result := AChangeInValue / 2 * (-Power(2, -10 * ACurrentTime) + 2 ) + AStartValue;
         end;
      end;

    etInCircle:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := -AChangeInValue * (Sqrt(1 - ACurrentTime * ACurrentTime) - 1) + AStartValue;
      end;

    etOutCircle:
      begin
        ACurrentTime := (ACurrentTime / ADuration) - 1;
        Result := AChangeInValue * Sqrt(1 - ACurrentTime * ACurrentTime) + AStartValue;
      end;

    etInOutCircle:
      begin
        ACurrentTime := ACurrentTime / (ADuration / 2);
        if ACurrentTime < 1 then
          Result := -AChangeInValue / 2 * (Sqrt(1 - ACurrentTime * ACurrentTime) - 1) + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 2;
          Result := AChangeInValue / 2 * (Sqrt(1 - ACurrentTime * ACurrentTime) + 1) + AStartValue;
        end;
      end;
  end;
end;

function  TMath.EasePosition(AStartPos: Double; AEndPos: Double; ACurrentPos: Double; AEaseType: TEaseType): Double;
var
  LT, LB, LC, LD: Double;
begin
  LC := AEndPos - AStartPos;
  LD := 100;
  LT := ACurrentPos;
  LB := AStartPos;
  Result := EaseValue(LT, LB, LC, LD, AEaseType);
  if Result > 100 then
    Result := 100;
end;

function  TMath.OBBIntersect(const AObbA, AObbB: TOBB): Boolean;
var
  LAxes: array[0..3] of TPoint;
  I: Integer;
  LProjA, LProjB: TPoint;

  function Dot(const A, B: TPoint): Single;
  begin
    Result := A.x * B.x + A.y * B.y;
  end;

  function Rotate(const V: TPoint; AAngle: Single): TPoint;
  var
    s, c: Single;
    LAngle: Cardinal;
  begin
    LAngle := Abs(Round(AAngle));
    s := Math.AngleSin(LAngle);
    c := Math.AngleCos(LAngle);
    Result.x := V.x * c - V.y * s;
    Result.y := V.x * s + V.y * c;
  end;

  function Project(const AObb: TOBB; const AAxis: TPoint): TPoint;
  var
    LCorners: array[0..3] of TPoint;
    I: Integer;
    LDot: Single;
  begin
    LCorners[0] := Rotate(Math.Point(AObb.Extents.x, AObb.Extents.y), AObb.Rotation);
    LCorners[1] := Rotate(Math.Point(-AObb.Extents.x, AObb.Extents.y), AObb.Rotation);
    LCorners[2] := Rotate(Math.Point(AObb.Extents.x, -AObb.Extents.y), AObb.Rotation);
    LCorners[3] := Rotate(Math.Point(-AObb.Extents.x, -AObb.Extents.y), AObb.Rotation);

    Result.x := Dot(AAxis, Math.Point(AObb.Center.x + LCorners[0].x, AObb.Center.y + LCorners[0].y));
    Result.y := Result.x;

    for I := 1 to 3 do
    begin
      LDot := Dot(AAxis, Math.Point(AObb.Center.x + LCorners[I].x, AObb.Center.y + LCorners[I].y));
      if LDot < Result.x then Result.x := LDot;
      if LDot > Result.y then Result.y := LDot;
    end;
  end;

begin
  LAxes[0] := Rotate(Math.Point(1, 0), AObbA.Rotation);
  LAxes[1] := Rotate(Math.Point(0, 1), AObbA.Rotation);
  LAxes[2] := Rotate(Math.Point(1, 0), AObbB.Rotation);
  LAxes[3] := Rotate(Math.Point(0, 1), AObbB.Rotation);

  for I := 0 to 3 do
  begin
    LProjA := Project(AObbA, LAxes[I]);
    LProjB := Project(AObbB, LAxes[I]);
    if (LProjA.y < LProjB.x) or (LProjB.y < LProjA.x) then Exit(False);
  end;

  Result := True;
end;
{$ENDREGION}

{$REGION ' COLOR '}
//=== COLOR =================================================================
type
  { TIColor }
  TIColor = class(TBaseInterface, IColor)
    function  FromByte(const r, g, b, a: Byte): TColor;
    function  FromFloat(const r, g, b, a: Single): TColor;
    function  Fade(const AFrom, ATo: TColor; const APos: Single): TColor;
    function  IsEqual(const AColor1, AColor2: TColor): Boolean;
  end;

{ TIColor }
function  TIColor.FromByte(const r, g, b, a: Byte): TColor;
begin
  Result.r := EnsureRange(r, 0, 255) / $FF;
  Result.g := EnsureRange(g, 0, 255) / $FF;
  Result.b := EnsureRange(b, 0, 255) / $FF;
  Result.a := EnsureRange(a, 0, 255) / $FF;
end;

function  TIColor.FromFloat(const r, g, b, a: Single): TColor;
begin
  Result.r := EnsureRange(r, 0, 1);
  Result.g := EnsureRange(g, 0, 1);
  Result.b := EnsureRange(b, 0, 1);
  Result.a := EnsureRange(a, 0, 1);
end;

function  TIColor.Fade(const AFrom, ATo: TColor; const APos: Single): TColor;
var
  LPos: Single;
begin
  LPos := EnsureRange(APos, 0, 1);
  Result.r := AFrom.r + ((ATo.r - AFrom.r) * LPos);
  Result.g := AFrom.g + ((ATo.g - AFrom.g) * LPos);
  Result.b := AFrom.b + ((ATo.b - AFrom.b) * LPos);
  Result.a := AFrom.a + ((ATo.a - AFrom.a) * LPos);
end;

function  TIColor.IsEqual(const AColor1, AColor2: TColor): Boolean;
begin
  Result := (AColor1.r = AColor2.r) and
            (AColor1.g = AColor2.g) and
            (AColor1.b = AColor2.b) and
            (AColor1.a = AColor2.a);
end;

{$ENDREGION}

{$REGION ' IO '}
//=== IO ====================================================================
type
  { TIO }
  TIO = class(TBaseInterface, IIO)
  public
    constructor Create(); override;
    destructor Destroy(); override;
    function  IsOpen(): Boolean; virtual;
    procedure Close(); virtual;
    function  Size(): Int64; virtual;
    function  Seek(const AOffset: Int64; const ASeek: TIOSeek): Int64; virtual;
    function  Read(const AData: Pointer; const ASize: Int64): Int64; virtual;
    function  Write(const AData: Pointer; const ASize: Int64): Int64; virtual;
    function  Pos(): Int64; virtual;
    function  Eos(): Boolean; virtual;
  end;

{ TIO }
constructor TIO.Create();
begin
  inherited;
end;

destructor TIO.Destroy();
begin
  Close();
  inherited;
end;

function  TIO.IsOpen(): Boolean;
begin
  Result := False;
end;

procedure TIO.Close();
begin
end;

function  TIO.Size(): Int64;
begin
  Result := -1;
end;

function  TIO.Seek(const AOffset: Int64; const ASeek: TIOSeek): Int64;
begin
  Result := -1;
end;

function  TIO.Read(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := -1;
end;

function  TIO.Write(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := -1;
end;

function  TIO.Pos(): Int64;
begin
  Result := -1;
end;

function  TIO.Eos(): Boolean;
begin
  Result := False;
end;

//=== MEMORYIO ==============================================================
type
  { TMemoryIO }
  TMemoryIO = class(TIO, IMemoryIO)
  protected
    FHandle: TMemoryStream;
  public
    function  IsOpen(): Boolean; override;
    procedure Close(); override;
    function  Size(): Int64; override;
    function  Seek(const AOffset: Int64; const ASeek: TIOSeek): Int64; override;
    function  Read(const AData: Pointer; const ASize: Int64): Int64; override;
    function  Write(const AData: Pointer; const ASize: Int64): Int64; override;
    function  Pos(): Int64; override;
    function  Eos(): Boolean; override;
    function  Open(const AData: Pointer; ASize: Int64): Boolean;
  end;

function  TMemoryIO.IsOpen(): Boolean;
begin
  Result := Assigned(FHandle);
end;

procedure TMemoryIO.Close();
begin
  if Assigned(FHandle) then
  begin
    FHandle.Free();
    FHandle := nil;
  end;
end;

function  TMemoryIO.Size(): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;

  Result := FHandle.Size;
end;

function  TMemoryIO.Seek(const AOffset: Int64; const ASeek: TIOSeek): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;

  Result := FHandle.Seek(AOffset, Ord(ASeek));
end;

function  TMemoryIO.Read(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;

 Result := FHandle.Read(AData^, ASize);
end;

function  TMemoryIO.Write(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;

  Result := FHandle.Write(AData^, ASize);
end;

function  TMemoryIO.Pos(): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;

  Result := FHandle.Position;
end;

function  TMemoryIO.Eos(): Boolean;
begin
  Result := False;
  if not Assigned(FHandle) then Exit;

  Result := Boolean(Pos() >= Size());
end;

function  TMemoryIO.Open(const AData: Pointer; ASize: Int64): Boolean;
begin
  Result := False;
  if Assigned(FHandle) then Exit;

  FHandle := TMemoryStream.Create;
  FHandle.Write(AData^, ASize);
  FHandle.Position := 0;
end;

//=== FILEIO ================================================================
type
  { TFileIO }
  TFileIO = class(TIO, IFileIO)
  protected
    FHandle: TFileStream;
    FMode: TIOMode;
  public
    function  IsOpen(): Boolean; override;
    procedure Close(); override;
    function  Size(): Int64; override;
    function  Seek(const AOffset: Int64; const ASeek: TIOSeek): Int64; override;
    function  Read(const AData: Pointer; const ASize: Int64): Int64; override;
    function  Write(const AData: Pointer; const ASize: Int64): Int64; override;
    function  Pos(): Int64; override;
    function  Eos(): Boolean; override;
    function  Open(const AFilename: string; const AMode: TIOMode): Boolean;
  end;

function  TFileIO.IsOpen(): Boolean;
begin
  Result := Assigned(FHandle);
end;

procedure TFileIO.Close();
begin
  if Assigned(FHandle) then
  begin
    FHandle.Free();
    FHandle := nil;
  end;
end;

function  TFileIO.Size(): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;

  Result := FHandle.Size;
end;

function  TFileIO.Seek(const AOffset: Int64; const ASeek: TIOSeek): Int64;
begin
  Result := FHandle.Seek(AOffset, Ord(ASeek));
end;

function  TFileIO.Read(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;

 Result := FHandle.Read(AData^, ASize);
end;

function  TFileIO.Write(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;

  Result := FHandle.Write(AData^, ASize);
end;

function  TFileIO.Pos(): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;

  Result := FHandle.Position;
end;

function  TFileIO.Eos(): Boolean;
begin
  Result := False;
  if not Assigned(FHandle) then Exit;

  Result := Boolean(Pos() >= Size());
end;

function TFileIO.Open(const AFilename: string; const AMode: TIOMode): Boolean;
var
  LHandle: TFileStream;
  LMode: TIOMode;
begin
  Result := False;
  LHandle := nil;

  if AFilename.IsEmpty then Exit;

  if not TFile.Exists(AFilename) then
  begin
    Exit;
  end;

  LMode := AMode;

  try
    case AMode of
      iomRead:
      begin
        LHandle := TFile.OpenRead(AFilename);
      end;

      iomWrite:
      begin
        LHandle := TFile.OpenWrite(AFilename);
      end;
    end;
  except
    LHandle := nil;
  end;

  if not Assigned(LHandle) then
  begin
    Exit;
  end;

  FHandle := LHandle;
  FMode := LMode;

  Result := True;
end;

//=== ZIPFILEIO =============================================================
type
  { TZipFileIO }
  TZipFileIO = class(TIO, IZipFileIO)
  protected
    FHandle: unzFile;
    FPassword: AnsiString;
    FFilename: AnsiString;
  public
    function  IsOpen(): Boolean; override;
    procedure Close(); override;
    function  Size(): Int64; override;
    function  Seek(const AOffset: Int64; const ASeek: TIOSeek): Int64; override;
    function  Read(const AData: Pointer; const ASize: Int64): Int64; override;
    function  Write(const AData: Pointer; const ASize: Int64): Int64; override;
    function  Pos(): Int64; override;
    function  Eos(): Boolean; override;
    function Build(const AZipFilename, ADirectoryName: string; const ASender: Pointer=nil; const AHandler: TZipFileIOBuildProgressEvent=nil; const APassword: string=CDefaultZipFilePassword): Boolean;
    function Open(const AZipFilename, AFilename: string; const APassword: string=CDefaultZipFilePassword): Boolean;
  end;

function  TZipFileIO.IsOpen(): Boolean;
begin
  Result := Assigned(FHandle);
end;

procedure TZipFileIO.Close();
begin
  if not Assigned(FHandle) then Exit;

  Assert(unzCloseCurrentFile(FHandle) = UNZ_OK);
  Assert(unzClose(FHandle) = UNZ_OK);
  FHandle := nil;
end;

function  TZipFileIO.Size(): Int64;
var
  LInfo: unz_file_info64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;

  unzGetCurrentFileInfo64(FHandle, @LInfo, nil, 0, nil, 0, nil, 0);
  Result := LInfo.uncompressed_size;
end;

function  TZipFileIO.Seek(const AOffset: Int64; const ASeek: TIOSeek): Int64;
var
  LFileInfo: unz_file_info64;
  LCurrentOffset, LBytesToRead: UInt64;
  LOffset: Int64;

  procedure SeekToLoc;
  begin
    LBytesToRead := UInt64(LOffset) - unztell64(FHandle);
    while LBytesToRead > 0 do
    begin
      if LBytesToRead > GetTempStaticBufferSize() then
        unzReadCurrentFile(FHandle, GetTempStaticBuffer(), GetTempStaticBufferSize())
      else
        unzReadCurrentFile(FHandle, GetTempStaticBuffer(), LBytesToRead);

      LBytesToRead := UInt64(LOffset) - unztell64(FHandle);
    end;
  end;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;

  if (FHandle = nil) or (unzGetCurrentFileInfo64(FHandle, @LFileInfo, nil, 0, nil, 0, nil, 0) <> UNZ_OK) then
  begin
    Exit;
  end;

  LOffset := AOffset;

  LCurrentOffset := unztell64(FHandle);
  if LCurrentOffset = -1 then Exit;

  case ASeek of
    // offset is already relative to the start of the file
    iosStart: ;

    // offset is relative to current position
    iosCurrent: Inc(LOffset, LCurrentOffset);

    // offset is relative to end of the file
    iosEnd: Inc(LOffset, LFileInfo.uncompressed_size);
  else
    Exit;
  end;

  if LOffset < 0 then Exit

  else if AOffset > LCurrentOffset then
    begin
      SeekToLoc();
    end
  else // offset < current_offset
    begin
      unzCloseCurrentFile(FHandle);
      unzLocateFile(FHandle, PAnsiChar(FFilename), 0);
      unzOpenCurrentFilePassword(FHandle, PAnsiChar(FPassword));
      SeekToLoc();
    end;

  Result := unztell64(FHandle);
end;

function  TZipFileIO.Read(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;

  Result := unzReadCurrentFile(FHandle, AData, ASize);
end;

function  TZipFileIO.Write(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;
end;

function  TZipFileIO.Pos(): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;

  Result := unztell64(FHandle);
end;

function  TZipFileIO.Eos(): Boolean;
begin
  Result := False;
  if not Assigned(FHandle) then Exit;

  Result := Boolean(Pos() >= Size());
end;

procedure TZipFileIO_BuildProgress(const ASender: Pointer; const AFilename: string; const AProgress: Integer; const ANewFile: Boolean);
begin
  if aNewFile then Console.PrintLn('', []);
  Console.Print(CR+'Adding %s(%d%s)...', [ExtractFileName(string(aFilename)), aProgress, '%']);
end;

function TZipFileIO.Build(const AZipFilename, ADirectoryName: string; const ASender: Pointer; const AHandler: TZipFileIOBuildProgressEvent; const APassword: string): Boolean;
var
  LFileList: TStringDynArray;
  LArchive: PAnsiChar;
  LFilename: string;
  LFilename2: PAnsiChar;
  LPassword: PAnsiChar;
  LZipFile: zipFile;
  LZipFileInfo: zip_fileinfo;
  LFile: System.Classes.TStream;
  LCrc: Cardinal;
  LBytesRead: Integer;
  LFileSize: Int64;
  LProgress: Single;
  LNewFile: Boolean;
  LHandler: TZipFileIOBuildProgressEvent;
  LSender: Pointer;

  function GetCRC32(aStream: System.Classes.TStream): uLong;
  var
    LBytesRead: Integer;
    LBuffer: array of Byte;
  begin
    Result := System.ZLib.crc32(0, nil, 0);
    repeat
      LBytesRead := AStream.Read(GetTempStaticBuffer()^, GetTempStaticBufferSize());
      Result := System.ZLib.crc32(Result, PByte(GetTempStaticBuffer()), LBytesRead);
    until LBytesRead = 0;

    LBuffer := nil;
  end;
begin
  Result := False;

  // check if directory exists
  if not TDirectory.Exists(ADirectoryName) then Exit;

  // init variabls
  FillChar(LZipFileInfo, SizeOf(LZipFileInfo), 0);

  // scan folder and build file list
  LFileList := TDirectory.GetFiles(ADirectoryName, '*',
    TSearchOption.soAllDirectories);

  LArchive := PAnsiChar(AnsiString(AZipFilename));
  LPassword := PAnsiChar(AnsiString(APassword));

  // create a zip file
  LZipFile := zipOpen64(LArchive, APPEND_STATUS_CREATE);

  // init handler
  LHandler := AHandler;
  LSender := ASender;

  if not Assigned(LHandler) then
    LHandler := TZipFileIO_BuildProgress;

  // process zip file
  if LZipFile <> nil then
  begin
    // loop through all files in list
    for LFilename in LFileList do
    begin
      // open file
      LFile := TFile.OpenRead(LFilename);

      // get file size
      LFileSize := LFile.Size;

      // get file crc
      LCrc := GetCRC32(LFile);

      // open new file in zip
      LFilename2 := PAnsiChar(AnsiString(LFilename));
      if ZipOpenNewFileInZip3_64(LZipFile, LFilename2, @LZipFileInfo, nil, 0,
        nil, 0, '',  Z_DEFLATED, 9, 0, 15, 9, Z_DEFAULT_STRATEGY,
        LPassword, LCrc, 1) = Z_OK then
      begin
        // make sure we start at star of stream
        LFile.Position := 0;

        LNewFile := True;

        // read through file
        repeat
          // read in a buffer length of file
          LBytesRead := LFile.Read(GetTempStaticBuffer()^, GetTempStaticBufferSize());

          // write buffer out to zip file
          zipWriteInFileInZip(LZipFile, GetTempStaticBuffer(), LBytesRead);

          // calc file progress percentage
          LProgress := 100.0 * (LFile.Position / LFileSize);

          // show progress
          if Assigned(LHandler) then
          begin
            LHandler(LSender, LFilename, Round(LProgress), LNewFile);
          end;

          LNewFile := False;

        until LBytesRead = 0;

        // close file in zip
        zipCloseFileInZip(LZipFile);

        // free file stream
        LFile.Free;
      end;
    end;

    // close zip file
    zipClose(LZipFile, '');
  end;

  // return true if new zip file exits
  Result := TFile.Exists(LFilename);
end;

function TZipFileIO.Open(const AZipFilename, AFilename: string; const APassword: string): Boolean;
var
  LPassword: PAnsiChar;
  LZipFilename: PAnsiChar;
  LFilename: PAnsiChar;
  LFile: unzFile;
begin
  Result := False;

  LPassword := PAnsiChar(AnsiString(APassword));
  LZipFilename := PAnsiChar(AnsiString(StringReplace(string(AZipFilename), '/', '\', [rfReplaceAll])));
  LFilename := PAnsiChar(AnsiString(StringReplace(string(AFilename), '/', '\', [rfReplaceAll])));

  LFile := unzOpen64(LZipFilename);
  if not Assigned(LFile) then Exit;

  if unzLocateFile(LFile, LFilename, 0) <> UNZ_OK then
  begin
    unzClose(LFile);
    Exit;
  end;

  if unzOpenCurrentFilePassword(LFile, LPassword) <> UNZ_OK then
  begin
    unzClose(LFile);
    Exit;
  end;

  FHandle := LFile;
  FPassword := LPassword;
  FFilename := LFilename;

  Result := True;
end;
{$ENDREGION}

{$REGION ' WINDOW '}
//=== WINDOW ================================================================
type
  { TWindow }
  TWindow = class(TBaseInterface, IWindow)
  protected type
    TTiming = record
      LastTime: Double;
      TargetTime: Double;
      CurrentTime: Double;
      ElapsedTime: Double;
      RemainingTime: Double;
      LastFPSTime: Double;
      Endtime: double;
      FrameCount: Cardinal;
      Framerate: Cardinal;
      TargetFrameRate: Cardinal;
    end;
  protected
    FParent: HWND;
    FHandle: PGLFWwindow;
    FVirtualSize: TSize;
    FMaxTextureSize: Integer;
    FIsFullscreen: Boolean;
    FWindowedPosX, FWindowedPosY: Integer;
    FWindowedWidth, FWindowedHeight: Integer;
    FViewport: TRect;
    FKeyState: array [0..0, KEY_SPACE..KEY_LAST] of Boolean;
    FMouseButtonState: array [0..0, MOUSE_BUTTON_1..MOUSE_BUTTON_MIDDLE] of Boolean;
    FGamepadButtonState: array[0..0, GAMEPAD_BUTTON_A..GAMEPAD_BUTTON_LAST] of Boolean;
    FTiming: TTiming;
    FMouseWheel: TVector;
    procedure SetDefaultIcon();
    procedure StartTiming();
    procedure StopTiming();
  public
    constructor Create(); override;
    destructor Destroy(); override;

    function  Open(const ATitle: string; const AVirtualWidth: Cardinal=CDefaultWindowWidth; const AVirtualHeight: Cardinal=CDefaultWindowHeight; const AParent: NativeUInt=0): Boolean;
    procedure Close();

    function  GetTitle(): string;
    procedure SetTitle(const ATitle: string);

    procedure Resize(const AWidth, AHeight: Cardinal);
    procedure ToggleFullscreen();
    function  IsFullscreen(): Boolean;

    function  HasFocus(): Boolean;

    function  GetVirtualSize(): TSize;
    function  GetSize(): TSize;
    function  GetScale(): TSize;
    function  GetMaxTextureSize: Integer;

    function  GetViewport(): TRect;

    procedure Center();

    function  ShouldClose(): Boolean;
    procedure SetShouldClose(const AClose: Boolean);

    procedure StartFrame();
    procedure EndFrame();

    procedure StartDrawing();
    procedure ResetDrawing();
    procedure EndDrawing();

    procedure Clear(const AColor: TColor);

    procedure DrawLine(const X1, Y1, X2, Y2: Single; const AColor: TColor; const AThickness: Single);
    procedure DrawRect(const X, Y, AWidth, AHeight, AThickness: Single; const AColor: TColor; const AAngle: Single);
    procedure DrawFilledRect(const X, Y, AWidth, AHeight: Single; const AColor: TColor; const AAngle: Single);
    procedure DrawCircle(const X, Y, ARadius, AThickness: Single; const AColor: TColor);
    procedure DrawFilledCircle(const X, Y, ARadius: Single; const AColor: TColor);
    procedure DrawTriangle(const X1, Y1, X2, Y2, X3, Y3, AThickness: Single; const AColor: TColor);
    procedure DrawFilledTriangle(const X1, Y1, X2, Y2, X3, Y3: Single; const AColor: TColor);
    procedure DrawPolygon(const APoints: array of TPoint; const AThickness: Single; const AColor: TColor);
    procedure DrawFilledPolygon(const APoints: array of TPoint; const AColor: TColor);
    procedure DrawPolyline(const APoints: array of TPoint; const AThickness: Single; const AColor: TColor);

    procedure ClearInput();
    function  GetKey(const AKey: Integer; const AState: TInputState): Boolean;
    function  GetMouseButton(const AButton: Byte; const AState: TInputState): Boolean;
    procedure GetMousePos(const X, Y: System.PSingle); overload;
    function  GetMousePos(): TPoint; overload;
    procedure SetMousePos(const X, Y: Single);
    function  GetMouseWheel(): TVector;
    procedure ResetMouseWheel;

    function  GamepadPresent(const AGamepad: Byte): Boolean;
    function  GetGamepadName(const AGamepad: Byte): string;
    function  GetGamepadButton(const AGamepad, AButton: Byte; const AState: TInputState): Boolean;
    function  GetGamepadAxisValue(const AGamepad, AAxis: Byte): Single;

    function  VirtualToScreen(const X, Y: Single): TPoint;
    function  ScreenToVirtual(const X, Y: Single): TPoint;

    procedure SetTargetFrameRate(const ATargetFrameRate: UInt32=CDefaultFPS);
    function  GetTargetFrameRate(): UInt32;
    function  GetTargetTime(): Double;
    procedure ResetTiming();
    function  GetFrameRate(): UInt32;
  end;

{ TWindow }
procedure Window_ResizeCallback(AWindow: PGLFWwindow; AWidth, AHeight: Integer); cdecl;
var
  LWindow: TWindow;
  LAspectRatio: Single;
  LNewWidth, LNewHeight: Integer;
  LXOffset, LYOffset: Integer;
  LWidth, LHeight: Integer;
begin
  LWindow := glfwGetWindowUserPointer(AWindow);
  if not Assigned(LWindow) then Exit;

  LWidth :=  Round(LWindow.GetVirtualSize().w);
  LHeight := Round(LWindow.GetVirtualSize().h);

  // Calculate aspect ratio based on the initial window size
  LAspectRatio := LWidth / LHeight;

  // Adjust the viewport based on the new window size
  if AWidth / LAspectRatio <= AHeight then
  begin
    LNewWidth := AWidth;
    LNewHeight := Round(AWidth / LAspectRatio);
    LXOffset := 0;
    LYOffset := (AHeight - LNewHeight) div 2;
  end
  else
  begin
    LNewWidth := Round(AHeight * LAspectRatio);
    LNewHeight := AHeight;
    LXOffset := (AWidth - LNewWidth) div 2;
    LYOffset := 0;
  end;

  // Set the viewport to maintain the aspect ratio and leave black bars
  glViewport(LXOffset, LYOffset, LNewWidth, LNewHeight);

  // Set the scissor box to match the virtual resolution area
  glScissor(LXOffset, LYOffset, LNewWidth, LNewHeight);

  // Set up the orthographic projection
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glOrtho(0, LWidth, LHeight, 0, -1, 1);  // Always map to the virtual coordinates

  // Back to modelview mode
  glMatrixMode(GL_MODELVIEW);

  LWindow.FViewport.pos.x := LXOffset;
  LWindow.FViewport.pos.y := LYOffset;
  LWindow.FViewport.size.w := LNewWidth;
  LWindow.FViewport.size.h := LNewHeight;
end;

procedure TWindow_ScrollCallback(AWindow: PGLFWwindow; AOffsetX, AOffsetY: Double); cdecl;
var
  LWindow: TWindow;
begin
  LWindow := glfwGetWindowUserPointer(AWindow);
  if not Assigned(LWindow) then Exit;

  // Save the scroll offsets
  LWindow.FMouseWheel := Math.Vector(AOffsetX, AOffsetY);
end;

procedure TWindow.SetDefaultIcon();
var
  IconHandle: HICON;
begin
  if not Assigned(FHandle) then Exit;

  IconHandle := LoadIcon(GetModuleHandle(nil), 'MAINICON');
  if IconHandle <> 0 then
  begin
    SendMessage(glfwGetWin32Window(FHandle), WM_SETICON, ICON_BIG, IconHandle);
  end;
end;

constructor TWindow.Create();
begin
  inherited;
end;

destructor TWindow.Destroy();
begin
  Close();
  inherited;
end;

function  TWindow.Open(const ATitle: string; const AVirtualWidth: Cardinal; const AVirtualHeight: Cardinal; const AParent: NativeUInt): Boolean;
var
  LWindow: PGLFWwindow;
  LWidth: Integer;
  LHeight: Integer;
  LHWNative: HWND;
  LStyle: NativeInt;
begin
  Result := False;

  if Assigned(FHandle) then Exit;

  LWidth := AVirtualWidth;
  LHeight := AVirtualHeight;

  glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 2);
  glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 1);

  // set hints if child or standalone window
  if AParent <> 0 then
    begin
      glfwWindowHint(GLFW_DECORATED, GLFW_FALSE);
      //glfwWindowHint(GLFW_VISIBLE, GLFW_FALSE);
    end
  else
    begin
      glfwWindowHint(GLFW_SCALE_TO_MONITOR, GLFW_TRUE);
    end;

  glfwWindowHint(GLFW_SAMPLES, 4);

  // Create a windowed mode window and its OpenGL context
  LWindow := glfwCreateWindow(LWidth, LHeight, AsUTF8(ATitle), nil, nil);
  if LWindow = nil then Exit;

  // set hints if child or standalone window
  if AParent <> 0 then
  begin
    LHWNative := glfwGetWin32Window(LWindow);
    WinApi.Windows.SetParent(LHWNative, AParent);
    LStyle := GetWindowLong(LHWNative, GWL_STYLE);
    LStyle := LStyle and not WS_POPUP; // remove popup style
    LStyle := LStyle or WS_CHILDWINDOW; // add childwindow style
    SetWindowLong(LHWNative, GWL_STYLE, LStyle);
  end;

  // Make the window's context current
  glfwMakeContextCurrent(LWindow);

  if not LoadOpenGL() then
  begin
    glfwMakeContextCurrent(nil);
    glfwDestroyWindow(LWindow);
    Exit;
  end;

  // Set the resize callback
  glfwSetFramebufferSizeCallback(LWindow, Window_ResizeCallback);

  // Set the mouse scroll callback
  glfwSetScrollCallback(LWindow, TWindow_ScrollCallback);

  // Enable the scissor test
  glEnable(GL_SCISSOR_TEST);

  // Enable Line Smoothing
  glEnable(GL_LINE_SMOOTH);
  glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);

  // Enable Polygon Smoothing
  glEnable(GL_POLYGON_SMOOTH);
  glHint(GL_POLYGON_SMOOTH_HINT, GL_NICEST);

  // Enable Point Smoothing
  glEnable(GL_POINT_SMOOTH);
  glHint(GL_POINT_SMOOTH_HINT, GL_NICEST);

  // Enable Multisampling for anti-aliasing (if supported)
  glEnable(GL_MULTISAMPLE);

  FHandle := LWindow;

  glfwGetWindowPos(FHandle, @FWindowedPosX, @FWindowedPosY);
  glfwGetWindowSize(FHandle, @FWindowedWidth, @FWindowedHeight);

  FVirtualSize.w := LWidth;
  FVirtualSize.h := LHeight;
  FParent := AParent;

  glGetIntegerv(GL_MAX_TEXTURE_SIZE, @FMaxTextureSize);
  glfwSetInputMode(FHandle, GLFW_STICKY_KEYS, GLFW_TRUE);
  glfwSetInputMode(FHandle, GLFW_STICKY_MOUSE_BUTTONS, GLFW_TRUE);

  glfwSwapInterval(0);

  glfwSetWindowUserPointer(FHandle, Self);

  if FParent = 0 then
    Center();

  glfwGetWindowSize(FHandle, @LWidth, @LHeight);

  FViewport.pos.x := 0;
  FViewport.pos.x := 0;
  FViewport.size.w := LWidth;
  FViewport.size.h := LHeight;

  SetDefaultIcon();

  SetTargetFrameRate(CDefaultFPS);

  Result := True;
end;

procedure TWindow.Close();
begin
  if not Assigned(FHandle) then Exit;
  glfwMakeContextCurrent(nil);
  glfwDestroyWindow(FHandle);
  FHandle := nil;
end;

function  TWindow.GetTitle(): string;
var
  LHwnd: HWND;
  LLen: Integer;
  LTitle: PChar;
begin
  Result := '';
  if not Assigned(FHandle) then Exit;

  LHwnd := glfwGetWin32Window(FHandle);
  LLen := GetWindowTextLength(LHwnd);
  GetMem(LTitle, LLen + 1);
  try
    GetWindowText(LHwnd, LTitle, LLen + 1);
    Result := string(LTitle);
  finally
    FreeMem(LTitle);
  end;
end;

procedure TWindow.SetTitle(const ATitle: string);
begin
  if not Assigned(FHandle) then Exit;

  SetWindowText(glfwGetWin32Window(FHandle), ATitle);
end;

procedure TWindow.Resize(const AWidth, AHeight: Cardinal);
begin
  glfwSetWindowSize(FHandle, AWidth, AHeight);
end;

procedure TWindow.ToggleFullscreen();
var
  LMonitor: PGLFWmonitor;
  LMode: PGLFWvidmode;
begin
  if not Assigned(FHandle) then Exit;

  if FIsFullscreen then
    begin
      // Switch to windowed mode using the saved window position and size
      glfwSetWindowMonitor(FHandle, nil, FWindowedPosX, FWindowedPosY, FWindowedWidth, FWindowedHeight, 0);
      FIsFullscreen := False;
    end
  else
    begin
      // Get the primary monitor and its video mode
      LMonitor := glfwGetPrimaryMonitor();
      LMode := glfwGetVideoMode(LMonitor);

      // Save the windowed mode position and size
      glfwGetWindowPos(FHandle, @FWindowedPosX, @FWindowedPosY);
      glfwGetWindowSize(FHandle, @FWindowedWidth, @FWindowedHeight);

      // Switch to fullscreen mode at the desktop resolution
      glfwSetWindowMonitor(FHandle, LMonitor, 0, 0, LMode.Width, LMode.Height, LMode.RefreshRate);
      FIsFullscreen := True;
    end;
end;

function  TWindow.IsFullscreen(): Boolean;
begin
  Result := False;
  if not Assigned(FHandle) then Exit;
  Result := FIsFullscreen;
end;

function  TWindow.GetVirtualSize(): TSize;
begin
  Result.w := 0;
  Result.h := 0;
  if not Assigned(FHandle) then Exit;
  Result := FVirtualSize;
end;

function  TWindow.HasFocus(): Boolean;
begin
  Result := False;
  if not Assigned(FHandle) then Exit;
  Result := Boolean(glfwGetWindowAttrib(FHandle, GLFW_FOCUSED) = GLFW_TRUE);
end;

function  TWindow.GetSize(): TSize;
var
  LWindowWidth, LWindowHeight: Double;
begin
  Result.w := 0;
  Result.h := 0;
  if not Assigned(FHandle) then Exit;

  glfwGetWindowSize(FHandle, @LWindowWidth, @LWindowHeight);
  Result.w := LWindowWidth;
  Result.h := LWindowHeight;
end;

function  TWindow.GetScale(): TSize;
begin
  Result.w := 0;
  Result.h := 0;
  if not Assigned(FHandle) then Exit;

  glfwGetWindowContentScale(FHandle, @Result.w, @Result.h);
end;

function  TWindow.GetMaxTextureSize(): Integer;
begin
  Result := FMaxTextureSize;
end;


function  TWindow.GetViewport(): TRect;
begin
  Result.pos.x := 0;
  Result.pos.y := 0;
  Result.size.w := 0;
  Result.size.h := 0;
  if not Assigned(FHandle) then Exit;
  Result := FViewport;
end;

procedure TWindow.Center();
var
  LMonitor: PGLFWmonitor;
  LVideoMode: PGLFWvidmode;
  LScreenWidth, LScreenHeight: Integer;
  LWindowWidth, LWindowHeight: Integer;
  LPosX, LPosY: Integer;
begin
  if not Assigned(FHandle) then Exit;

  if FIsFullscreen then Exit;

  // Get the primary monitor
  LMonitor := glfwGetPrimaryMonitor;

  // Get the video mode of the monitor (i.e., resolution)
  LVideoMode := glfwGetVideoMode(LMonitor);

  // Get the screen width and height
  LScreenWidth := LVideoMode.width;
  LScreenHeight := LVideoMode.height;

  // Get the window width and height
  glfwGetWindowSize(FHandle, @LWindowWidth, @LWindowHeight);

  // Calculate the position to center the window
  LPosX := (LScreenWidth - LWindowWidth) div 2;
  LPosY := (LScreenHeight - LWindowHeight) div 2;

  // Set the window position
  glfwSetWindowPos(FHandle, LPosX, LPosY);
end;

function  TWindow.ShouldClose(): Boolean;
begin
  Result := True;
  if not Assigned(FHandle) then Exit;
  Result := Boolean(glfwWindowShouldClose(FHandle) = GLFW_TRUE);
end;

procedure TWindow.SetShouldClose(const AClose: Boolean);
begin
  if not Assigned(FHandle) then Exit;
  glfwSetWindowShouldClose(FHandle, Ord(AClose))
end;

procedure TWindow.StartFrame();
begin
  if not Assigned(FHandle) then Exit;

  StartTiming();
  Video.Update(Self);
  Audio.Update();
  glfwPollEvents();
end;

procedure TWindow.EndFrame();
begin
  if not Assigned(FHandle) then Exit;

  StopTiming();
end;

procedure TWindow.StartDrawing();
begin
  if not Assigned(FHandle) then Exit;

  // Clear the entire screen to black (this will create the black bars)
  glClearColor(0, 0, 0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  ResetDrawing();
end;

procedure TWindow.ResetDrawing();
begin
  if not Assigned(FHandle) then Exit;

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glOrtho(0, FVirtualSize.w, FVirtualSize.h, 0, -1, 1);  // Set orthographic projection
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
end;

procedure TWindow.EndDrawing();
begin
  if not Assigned(FHandle) then Exit;
  glfwSwapBuffers(FHandle);
end;

procedure TWindow.Clear(const AColor: TColor);
begin
  if not Assigned(FHandle) then Exit;
  glClearColor(AColor.r, AColor.g, AColor.b, AColor.a);
  glClear(GL_COLOR_BUFFER_BIT); // Only the viewport area is affected
end;

procedure TWindow.DrawLine(const X1, Y1, X2, Y2: Single; const AColor: TColor; const AThickness: Single);
begin
  if not Assigned(FHandle) then Exit;

  glLineWidth(AThickness);
  glColor4f(AColor.r, AColor.g, AColor.b, AColor.a);
  glBegin(GL_LINES);
    glVertex2f(X1, Y1);
    glVertex2f(X2, Y2);
  glEnd;
end;

procedure TWindow.DrawRect(const X, Y, AWidth, AHeight, AThickness: Single; const AColor: TColor; const AAngle: Single);
var
  LHalfWidth, LHalfHeight: Single;
begin
  if not Assigned(FHandle) then Exit;

  LHalfWidth := AWidth / 2;
  LHalfHeight := AHeight / 2;

  glLineWidth(AThickness);
  glColor4f(AColor.r, AColor.g, AColor.b, AColor.a);

  glPushMatrix;  // Save the current matrix

  // Translate to the center point
  glTranslatef(X, Y, 0);

  // Rotate around the center
  glRotatef(AAngle, 0, 0, 1);

  glBegin(GL_LINE_LOOP);
    glVertex2f(-LHalfWidth, -LHalfHeight);      // Bottom-left corner
    glVertex2f(LHalfWidth, -LHalfHeight);       // Bottom-right corner
    glVertex2f(LHalfWidth, LHalfHeight);        // Top-right corner
    glVertex2f(-LHalfWidth, LHalfHeight);       // Top-left corner
  glEnd;

  glPopMatrix;  // Restore the original matrix
end;

procedure TWindow.DrawFilledRect(const X, Y, AWidth, AHeight: Single; const AColor: TColor; const AAngle: Single);
var
  LHalfWidth, LHalfHeight: Single;
begin
  if not Assigned(FHandle) then Exit;

  LHalfWidth := AWidth / 2;
  LHalfHeight := AHeight / 2;

  glColor4f(AColor.r, AColor.g, AColor.b, AColor.a);

  glPushMatrix;  // Save the current matrix

  // Translate to the center point
  glTranslatef(X, Y, 0);

  // Rotate around the center
  glRotatef(AAngle, 0, 0, 1);

  glBegin(GL_QUADS);
    glVertex2f(-LHalfWidth, -LHalfHeight);      // Bottom-left corner
    glVertex2f(LHalfWidth, -LHalfHeight);       // Bottom-right corner
    glVertex2f(LHalfWidth, LHalfHeight);        // Top-right corner
    glVertex2f(-LHalfWidth, LHalfHeight);       // Top-left corner
  glEnd;

  glPopMatrix;  // Restore the original matrix
end;

procedure TWindow.DrawCircle(const X, Y, ARadius, AThickness: Single; const AColor: TColor);
var
  I: Integer;
  LX, LY: Single;
begin
  if not Assigned(FHandle) then Exit;

  glLineWidth(AThickness);
  glColor4f(AColor.r, AColor.g, AColor.b, AColor.a);
  glBegin(GL_LINE_LOOP);
    LX := X;
    LY := Y;
    for I := 0 to 360 do
    begin
      glVertex2f(LX + ARadius * Math.AngleCos(I), LY - ARadius * Math.AngleSin(I));
    end;
  glEnd();
end;

procedure TWindow.DrawFilledCircle(const X, Y, ARadius: Single; const AColor: TColor);
var
  I: Integer;
  LX, LY: Single;
begin
  if not Assigned(FHandle) then Exit;

  glColor4f(AColor.r, AColor.g, AColor.b, AColor.a);
  glBegin(GL_TRIANGLE_FAN);
    LX := X;
    LY := Y;
    glVertex2f(LX, LY);
    for i := 0 to 360 do
    begin
      glVertex2f(LX + ARadius * Math.AngleCos(i), LY + ARadius * Math.AngleSin(i));
    end;
  glEnd();
end;

procedure TWindow.DrawTriangle(const X1, Y1, X2, Y2, X3, Y3, AThickness: Single; const AColor: TColor);
begin
  if not Assigned(FHandle) then Exit;

  glLineWidth(AThickness);
  glColor4f(AColor.r, AColor.g, AColor.b, AColor.a);
  glBegin(GL_LINE_LOOP);
    glVertex2f(X1, Y1);
    glVertex2f(X2, Y2);
    glVertex2f(X3, Y3);
  glEnd();
end;

procedure TWindow.DrawFilledTriangle(const X1, Y1, X2, Y2, X3, Y3: Single; const AColor: TColor);
begin
  if not Assigned(FHandle) then Exit;

  glColor4f(AColor.r, AColor.g, AColor.b, AColor.a);
  glBegin(GL_TRIANGLES);
    glVertex2f(X1, Y1);
    glVertex2f(X2, Y2);
    glVertex2f(X3, Y3);
  glEnd();
end;

procedure TWindow.DrawPolygon(const APoints: array of TPoint; const AThickness: Single; const AColor: TColor);
var
  I: Integer;
begin
  if not Assigned(FHandle) then Exit;

  glLineWidth(AThickness);
  glColor4f(AColor.r, AColor.g, AColor.b, AColor.a);
  glBegin(GL_LINE_LOOP);
    for i := Low(APoints) to High(APoints) do
    begin
      glVertex2f(APoints[i].X, APoints[i].Y);
    end;
  glEnd();
end;

procedure TWindow.DrawFilledPolygon(const APoints: array of TPoint; const AColor: TColor);
var
  I: Integer;
begin
  if not Assigned(FHandle) then Exit;

  glColor4f(AColor.r, AColor.g, AColor.b, AColor.a);
  glBegin(GL_POLYGON);
  for I := Low(APoints) to High(APoints) do
    begin
      glVertex2f(APoints[i].X, APoints[i].Y);
    end;
  glEnd();
end;

procedure TWindow.DrawPolyline(const APoints: array of TPoint; const AThickness: Single; const AColor: TColor);
var
  I: Integer;
begin
  if not Assigned(FHandle) then Exit;

  glLineWidth(AThickness);
  glColor4f(AColor.r, AColor.g, AColor.b, AColor.a);
  glBegin(GL_LINE_STRIP);
    for I := Low(APoints) to High(APoints) do
    begin
      glVertex2f(APoints[i].X, APoints[i].Y);
    end;
  glEnd();
end;

procedure TWindow.ClearInput();
begin
  if not Assigned(FHandle) then Exit;
  FillChar(FKeyState, SizeOf(FKeyState), 0);
  FillChar(FMouseButtonState, SizeOf(FMouseButtonState), 0);
  FillChar(FGamepadButtonState, SizeOf(FGamepadButtonState), 0);
end;

function  TWindow.GetKey(const AKey: Integer; const AState: TInputState): Boolean;

  function IsKeyPressed(const AKey: Integer): Boolean;
  begin
    Result :=  Boolean(glfwGetKey(FHandle, AKey) = GLFW_PRESS);
  end;

begin
  Result := False;

  if not Assigned(FHandle) then Exit;

  if not InRange(AKey,  KEY_SPACE, KEY_LAST) then Exit;

  case AState of
    isPressed:
    begin
      Result :=  IsKeyPressed(AKey);
    end;

    isWasPressed:
    begin
      if IsKeyPressed(AKey) and (not FKeyState[0, AKey]) then
      begin
        FKeyState[0, AKey] := True;
        Result := True;
      end
      else if (not IsKeyPressed(AKey)) and (FKeyState[0, AKey]) then
      begin
        FKeyState[0, AKey] := False;
        Result := False;
      end;
    end;

    isWasReleased:
    begin
      if IsKeyPressed(AKey) and (not FKeyState[0, AKey]) then
      begin
        FKeyState[0, AKey] := True;
        Result := False;
      end
      else if (not IsKeyPressed(AKey)) and (FKeyState[0, AKey]) then
      begin
        FKeyState[0, AKey] := False;
        Result := True;
      end;
    end;
  end;
end;

function  TWindow.GetMouseButton(const AButton: Byte; const AState: TInputState): Boolean;

  function IsButtonPressed(const AKey: Integer): Boolean;
  begin
    Result :=  Boolean(glfwGetMouseButton(FHandle, AButton) = GLFW_PRESS);
  end;

begin
  Result := False;

  if not Assigned(FHandle) then Exit;
  if not InRange(AButton,  MOUSE_BUTTON_1, MOUSE_BUTTON_MIDDLE) then Exit;

  case AState of
    isPRESSED:
    begin
      Result :=  IsButtonPressed(AButton);
    end;

    isWASPRESSED:
    begin
      if IsButtonPressed(AButton) and (not FMouseButtonState[0, AButton]) then
      begin
        FMouseButtonState[0, AButton] := True;
        Result := True;
      end
      else if (not IsButtonPressed(AButton)) and (FMouseButtonState[0, AButton]) then
      begin
        FMouseButtonState[0, AButton] := False;
        Result := False;
      end;
    end;

    isWASRELEASED:
    begin
      if IsButtonPressed(AButton) and (not FMouseButtonState[0, AButton]) then
      begin
        FMouseButtonState[0, AButton] := True;
        Result := False;
      end
      else if (not IsButtonPressed(AButton)) and (FMouseButtonState[0, AButton]) then
      begin
        FMouseButtonState[0, AButton] := False;
        Result := True;
      end;
    end;
  end;
end;

procedure TWindow.GetMousePos(const X, Y: System.PSingle);
var
  LPos: TPoint;
begin
  if not Assigned(FHandle) then Exit;

  LPos := GetMousePos();

  if Assigned(X) then
    X^ := LPos.x;

  if Assigned(Y) then
    Y^ := LPos.y;
end;

function TWindow.GetMousePos(): TPoint;
var
  LMouseX, LMouseY: Double;
begin
  if not Assigned(FHandle) then Exit;

  glfwGetCursorPos(FHandle, @LMouseX, @LMouseY);
  Result := VirtualToScreen(LMouseX, LMouseY);
end;

procedure TWindow.SetMousePos(const X, Y: Single);
var
  LPos: TPoint;
begin
  if not Assigned(FHandle) then Exit;

  LPos := ScreenToVirtual(X, Y);
  glfwSetCursorPos(FHandle, LPos.X, LPos.y);
end;

function  TWindow.GetMouseWheel(): TVector;
begin
  Result := Math.Vector(0,0);
  if not Assigned(FHandle) then Exit;
  Result := FMouseWheel;
end;

procedure TWindow.ResetMouseWheel;
begin
  FMouseWheel := Math.Vector(0,0);
end;

function  TWindow.GamepadPresent(const AGamepad: Byte): Boolean;
begin
  Result := False;
  if not Assigned(FHandle) then Exit;

  Result := Boolean(glfwJoystickIsGamepad(EnsureRange(AGamepad, GAMEPAD_1, GAMEPAD_LAST)));
end;

function  TWindow.GetGamepadName(const AGamepad: Byte): string;
begin
  Result := 'Not present';

  if not Assigned(FHandle) then Exit;
  if not GamepadPresent(AGamepad) then Exit;

  Result := string(glfwGetGamepadName(AGamepad));
end;

function  TWindow.GetGamepadButton(const AGamepad, AButton: Byte; const AState: TInputState): Boolean;
var
  LState: GLFWgamepadstate;

  function IsButtonPressed(const AButton: Byte): Boolean;
  begin
    Result :=  Boolean(LState.buttons[AButton]);
  end;

begin
  Result := False;
  if not Assigned(FHandle) then Exit;

  if not Boolean(glfwGetGamepadState(EnsureRange(AGamepad, GAMEPAD_1, GAMEPAD_LAST), @LState)) then Exit;

  case AState of
    ISPRESSED:
    begin
      Result :=  IsButtonPressed(AButton);
    end;

    ISWASPRESSED:
    begin
      if IsButtonPressed(AButton) and (not FGamepadButtonState[0, AButton]) then
      begin
        FGamepadButtonState[0, AButton] := True;
        Result := True;
      end
      else if (not IsButtonPressed(AButton)) and (FGamepadButtonState[0, AButton]) then
      begin
        FGamepadButtonState[0, AButton] := False;
        Result := False;
      end;
    end;

    ISWASRELEASED:
    begin
      if IsButtonPressed(AButton) and (not FGamepadButtonState[0, AButton]) then
      begin
        FGamepadButtonState[0, AButton] := True;
        Result := False;
      end
      else if (not IsButtonPressed(AButton)) and (FGamepadButtonState[0, AButton]) then
      begin
        FGamepadButtonState[0, AButton] := False;
        Result := True;
      end;
    end;
  end;
end;

function  TWindow.GetGamepadAxisValue(const AGamepad, AAxis: Byte): Single;
var
  LState: GLFWgamepadstate;
begin
  Result := 0;
  if not Assigned(FHandle) then Exit;

  if not Boolean(glfwGetGamepadState(EnsureRange(AGamepad, GAMEPAD_1, GAMEPAD_LAST), @LState)) then Exit;
  Result := LState.axes[EnsureRange(AAxis, GAMEPAD_AXIS_LEFT_X, GLFW_GAMEPAD_AXIS_LAST)];
end;

function  TWindow.VirtualToScreen(const X, Y: Single): TPoint;
var
  LWindowWidth, LWindowHeight: Integer;
  LScreenX, LScreenY: Double;
  LVirtualScreenX, LVirtualScreenY: Double;
  LScaleX, LScaleY, LDpiScaleX, LDpiScaleY: Single;
  LViewportOffsetX, LViewportOffsetY: Double;
begin
  Result.x := 0;
  Result.y := 0;
  if not Assigned(FHandle) then Exit;

  // Get the actual window size
  glfwGetWindowSize(FHandle, @LWindowWidth, @LWindowHeight);

  // Get the DPI scaling factors (from glfwGetWindowContentScale)
  glfwGetWindowContentScale(FHandle, @LDpiScaleX, @LDpiScaleY);

  // Safety check to avoid invalid DPI scale values
  if (LDpiScaleX = 0) or (LDpiScaleY = 0) then
  begin
    LDpiScaleX := 1.0; // Default to 1.0 if invalid DPI scale is retrieved
    LDpiScaleY := 1.0;
  end;

  // Adjust window size by DPI scaling
  LWindowWidth := Trunc(LWindowWidth / LDpiScaleX);
  LWindowHeight := Trunc(LWindowHeight / LDpiScaleY);

  // Calculate the scaling factors for X and Y axes
  LScaleX := FVirtualSize.w / FViewport.size.w;  // Scale based on viewport width
  LScaleY := FVirtualSize.h / FViewport.size.h;  // Scale based on viewport height

  // Get the screen position
  LScreenX := X;
  LScreenY := Y;

  // Calculate the viewport offset
  LViewportOffsetX := FViewport.pos.x;
  LViewportOffsetY := FViewport.pos.y;

  // Adjust the mouse position by subtracting the viewport offset
  LScreenX := LScreenX - LViewportOffsetX;
  LScreenY := LScreenY - LViewportOffsetY;

  // Convert the adjusted mouse position to virtual coordinates
  LVirtualScreenX := LScreenX * LScaleX;
  LVirtualScreenY := LScreenY * LScaleY;

  // Clamp the virtual mouse position within the virtual resolution
  Result.x := EnsureRange(LVirtualScreenX, 0, FVirtualSize.w - 1);
  Result.y := EnsureRange(LVirtualScreenY, 0, FVirtualSize.h - 1);
end;

function  TWindow.ScreenToVirtual(const X, Y: Single): TPoint;
var
  LScreenX, LScreenY: Double;
  LScaleX, LScaleY: Single;
  LViewportOffsetX, LViewportOffsetY: Double;
begin
  Result.x := 0;
  Result.y := 0;
  if not Assigned(FHandle) then Exit;

  // Calculate the scaling factors (consistent with GetMousePos)
  LScaleX := FVirtualSize.w / FViewport.size.w;
  LScaleY := FVirtualSize.h / FViewport.size.h;

  // Calculate the viewport offsets
  LViewportOffsetX := FViewport.pos.x;
  LViewportOffsetY := FViewport.pos.y;

  // Convert virtual coordinates to adjusted screen position
  LScreenX := (X / LScaleX) + LViewportOffsetX;
  LScreenY := (Y / LScaleY) + LViewportOffsetY;

  // Return the virtual screen position
  Result.x := LScreenX;
  Result.y := LScreenY;
end;

procedure TWindow.StartTiming();
begin
  FTiming.CurrentTime := glfwGetTime();
  FTiming.ElapsedTime := FTiming.CurrentTime - FTiming.LastTime;
end;

procedure TWindow.StopTiming();
begin
  Inc(FTiming.FrameCount);
  if (FTiming.CurrentTime - FTiming.LastFPSTime >= 1.0) then
  begin
    FTiming.Framerate := FTiming.FrameCount;
    FTiming.LastFPSTime := FTiming.CurrentTime;
    FTiming.FrameCount := 0;
  end;
  FTiming.LastTime := FTiming.CurrentTime;
  FTiming.RemainingTime := FTiming.TargetTime - (FTiming.CurrentTime - FTiming.LastTime);
  if (FTiming.RemainingTime > 0) then
   begin
      FTiming.Endtime := FTiming.CurrentTime + FTiming.RemainingTime;
      while glfwGetTime() < FTiming.Endtime do
      begin
        // Busy-wait for the remaining time
        Sleep(0); // allow other background tasks to run
      end;
    end;
end;

procedure TWindow.SetTargetFrameRate(const ATargetFrameRate: UInt32);
begin
  FTiming.LastTime := glfwGetTime();
  FTiming.LastFPSTime := FTiming.LastTime;
  FTiming.TargetFrameRate := ATargetFrameRate;
  FTiming.TargetTime := 1.0 / FTiming.TargetFrameRate;
  FTiming.FrameCount := 0;
  FTiming.Framerate :=0;
  FTiming.Endtime := 0;
end;

function  TWindow.GetTargetFrameRate(): UInt32;
begin
  Result := FTiming.TargetFrameRate;
end;

function  TWindow.GetTargetTime(): Double;
begin
  Result := FTiming.TargetTime;
end;

procedure TWindow.ResetTiming();
begin
  FTiming.LastTime := glfwGetTime();
  FTiming.LastFPSTime := FTiming.LastTime;
  FTiming.TargetTime := 1.0 / FTiming.TargetFrameRate;
  FTiming.FrameCount := 0;
  FTiming.Framerate :=0;
  FTiming.Endtime := 0;
end;

function  TWindow.GetFrameRate(): UInt32;
begin
  Result := FTiming.Framerate;
end;
{$ENDREGION}

{$REGION ' TEXTURE '}
//=== TEXTURE ===============================================================
type
  { TTexture }
  TTexture = class(TBaseInterface, ITexture)
  private type
    PRGBA = ^TRGBA;
    TRGBA = packed record
      R, G, B, A: Byte;
    end;
  private
    FHandle: Cardinal;
    FChannels: Integer;
    FSize: TSize;
    FPivot: TPoint;
    FAnchor: TPoint;
    FBlend: TTextureBlend;
    FPos: TPoint;
    FScale: Single;
    FColor: TColor;
    FAngle: Single;
    FHFlip: Boolean;
    FVFlip: Boolean;
    FRegion: TRect;
    FLock: PByte;
    procedure ConvertMaskToAlpha(Data: Pointer; Width, Height: Integer; MaskColor: TColor);
  public
    constructor Create(); override;
    destructor Destroy(); override;
    function  Alloc(const AWidth, AHeight: Integer): Boolean;
    procedure Fill(const AColor: TColor);
    function  Load(const ARGBData: Pointer; const AWidth, AHeight: Integer): Boolean; overload;
    function  Load(const AIO: IIO; const AOwnIO: Boolean=True; const AColorKey: PColor=nil): Boolean; overload;
    function  LoadFromFile(const AFilename: string; const AColorKey: PColor=nil): Boolean;
    function  LoadFromZipFile(const AZipFilename, AFilename: string; const AColorKey: PColor=nil; const APassword: string=CDefaultZipFilePassword): Boolean;
    function  IsLoaded(): Boolean;
    procedure Unload();
    function  GetChannels(): Integer;
    function  GetSize():TSize;
    function  GetPivot(): TPoint;
    procedure SetPivot( const APoint: TPoint); overload;
    procedure SetPivot(const X, Y: Single); overload;
    function  Anchor(): TPoint;
    procedure SetAnchor(const APoint: TPoint); overload;
    procedure SetAnchor(const X, Y: Single); overload;
    function  GetBlend(): TTextureBlend;
    procedure SetBlend(const AValue: TTextureBlend);
    function  GetPos(): TPoint;
    procedure SetPos(const APos: TPoint); overload;
    procedure SetPos(const X, Y: Single); overload;
    function  GetScale(): Single;
    procedure SetScale(const AScale: Single);
    function  GetColor(): TColor;
    procedure SetColor(const AColor: TColor); overload;
    procedure SetColor(const ARed, AGreen, ABlue, AAlpha: Single); overload;
    function  GetAngle(): Single;
    procedure SetAngle(const AAngle: Single);
    function  GetHFlip(): Boolean;
    procedure SetHFlip(const AFlip: Boolean);
    function  GetVFlip(): Boolean;
    procedure SetVFlip(const AFlip: Boolean);
    function  GetRegion(): TRect;
    procedure SetRegion(const ARegion: TRect); overload;
    procedure SetRegion(const X, Y, AWidth, AHeight: Single); overload;
    procedure ResetRegion();
    procedure Draw(const AWindow: IWindow);
    procedure DrawTiled(const AWindow: IWindow; const ADeltaX, ADeltaY: Single);
    function  Save(const AFilename: string): Boolean;
    function  Lock(): Boolean;
    procedure Unlock();
    function  GetPixel(const X, Y: Single): TColor;
    procedure SetPixel(const X, Y: Single; const AColor: TColor); overload;
    procedure SetPixel(const X, Y: Single; const ARed, AGreen, ABlue, AAlpha: Byte); overload;
    function  CollideAABB(const ATexture: ITexture): Boolean;
    function  CollideOBB(const ATexture: ITexture): Boolean;
  end;

{ TTexture }
function  Texture_Read(AUser: Pointer; AData: PUTF8Char; ASize: Integer): Integer; cdecl;
var
  LIO: IIO;
begin
  Result := -1;

  LIO := IIO(AUser);
  if not Assigned(LIO) then Exit;

  Result := LIO.Read(AData, ASize);
end;

procedure Texture_Skip(AUser: Pointer; AOffset: Integer); cdecl;
var
  LIO: IIO;
begin
  LIO := IIO(AUser);
  if not Assigned(LIO) then Exit;

  LIO.Seek(AOffset, iosCurrent);
end;

function  Texture_Eof(AUser: Pointer): Integer;  cdecl;
var
  LIO: IIO;
begin
  Result := -1;

  LIO := IIO(AUser);
  if not Assigned(LIO) then Exit;

  Result := Ord(LIO.Eos);
end;

procedure TTexture.ConvertMaskToAlpha(Data: Pointer; Width, Height: Integer; MaskColor: TColor);
var
  I: Integer;
  LPixelPtr: PRGBA;
begin
  LPixelPtr := PRGBA(Data);
  if not Assigned(LPixelPtr) then Exit;

  for I := 0 to Width * Height - 1 do
  begin
    if (LPixelPtr^.R = Round(MaskColor.r * 256)) and
       (LPixelPtr^.G = Round(MaskColor.g * 256)) and
       (LPixelPtr^.B = Round(MaskColor.b * 256)) then
      LPixelPtr^.A := 0
    else
      LPixelPtr^.A := 255;

    Inc(LPixelPtr);
  end;
end;

constructor TTexture.Create();
begin
  inherited;
end;

destructor TTexture.Destroy();
begin
  Unload();
  inherited;
end;

function  TTexture.Alloc(const AWidth, AHeight: Integer): Boolean;
var
  LData: array of Byte;
begin
  Result := False;

  if FHandle <> 0 then Exit;

  // init RGBA data
  SetLength(LData, AWidth * AHeight * 4);

  glGenTextures(1, @FHandle);
  glBindTexture(GL_TEXTURE_2D, FHandle);

  // init the texture with transparent pixels
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, AWidth, AHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, @LData[0]);

  // set texture parameters
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  FSize.w := AWidth;
  FSize.h := AHeight;
  FChannels := 4;

  SetBlend(tbAlpha);
  SetColor(WHITE);
  SetScale(1.0);
  SetAngle(0.0);
  SetHFlip(False);
  SetVFlip(False);
  SetPivot(0.5, 0.5);
  SetAnchor(0.5, 0.5);
  SetPos(0.0, 0.0);
  ResetRegion();

  glBindTexture(GL_TEXTURE_2D, 0);

  Result := True;
end;

procedure TTexture.Fill(const AColor: TColor);
var
  X,Y,LWidth,LHeight: Integer;
begin
  if FHandle = 0 then Exit;

  LWidth := Round(FSize.w);
  LHeight := Round(FSize.h);

  glBindTexture(GL_TEXTURE_2D, FHandle);

  for X := 0 to LWidth-1 do
  begin
    for Y := 0 to LHeight-1 do
    begin
      glTexSubImage2D(GL_TEXTURE_2D, 0, X, Y, 1, 1, GL_RGBA, GL_FLOAT, @AColor);
    end;
  end;

  glBindTexture(GL_TEXTURE_2D, 0);
end;

function  TTexture.Load(const ARGBData: Pointer; const AWidth, AHeight: Integer): Boolean;
begin
  Result := False;

  if FHandle > 0 then Exit;

  if not Alloc(AWidth, AHeight) then Exit;

  glBindTexture(GL_TEXTURE_2D, FHandle);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_ALPHA, AWidth, AHeight, 0, GL_ALPHA, GL_UNSIGNED_BYTE, ARGBData);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glBindTexture(GL_TEXTURE_2D, 0);

  Result := True;
end;

function  TTexture.Load(const AIO: IIO; const AOwnIO: Boolean; const AColorKey: PColor): Boolean;
var
  LCallbacks: stbi_io_callbacks;
  LData: Pstbi_uc;
  LWidth,LHeight,LChannels: Integer;
  LIO: IIO;
begin
  Result := False;

  if FHandle > 0 then Exit;

  if not Assigned(AIO) then Exit;

  LIO := AIO;

  LCallbacks.read := Texture_Read;
  LCallbacks.skip := Texture_Skip;
  LCallbacks.eof := Texture_Eof;

  LData := stbi_load_from_callbacks(@LCallbacks, LIO, @LWidth, @LHeight, @LChannels, 4);
  if not Assigned(LData) then Exit;

  if Assigned(AColorKey) then
    ConvertMaskToAlpha(LData, LWidth, LHeight, AColorKey^);

  glGenTextures(1, @FHandle);
  glBindTexture(GL_TEXTURE_2D, FHandle);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, LWidth, LHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, LData);

  // Set texture parameters
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  stbi_image_free(LData);

  FSize.w := LWidth;
  FSize.h := LHeight;
  FChannels := LChannels;

  SetBlend(tbAlpha);
  SetColor(WHITE);
  SetScale(1.0);
  SetAngle(0.0);
  SetHFlip(False);
  SetVFlip(False);
  SetPivot(0.5, 0.5);
  SetAnchor(0.5, 0.5);
  SetPos(0.0, 0.0);
  ResetRegion();

  glBindTexture(GL_TEXTURE_2D, 0);

  if AOwnIO then
  begin
    IRelease(AIO);
  end;

  Result := True;
end;

function  TTexture.LoadFromFile(const AFilename: string; const AColorKey: PColor=nil): Boolean;
var
  LIO: IFileIO;
begin
  Result := False;
  if not IGet(IFileIO, LIO) then Exit;
  try
    if not LIO.Open(AFilename, iomRead) then Exit;
    Result := Load(LIO, False, AColorKey);
  finally
    IRelease(LIO);
  end;
end;

function  TTexture.LoadFromZipFile(const AZipFilename, AFilename: string; const AColorKey: PColor; const APassword: string): Boolean;
var
  LIO: IZipFileIO;
begin
  Result := False;
  if not IGet(IZIPFileIO, LIO) then Exit;
  try
    if not LIO.Open(AZipFilename, AFilename, APassword) then Exit;
    Result := Load(LIO, False, AColorkey);
  finally
    IRelease(LIO);
  end;
end;

function  TTexture.IsLoaded(): Boolean;
begin
  Result := Boolean(FHandle > 0);
end;

procedure TTexture.Unload();
begin
  if FHandle > 0 then
  begin
    glDeleteTextures(1, @FHandle);
  end;
  FHandle := 0;
end;

function  TTexture.GetChannels(): Integer;
begin
  Result := -1;
  if FHandle = 0 then Exit;
  Result := FChannels;
end;

function  TTexture.GetSize(): TSize;
begin
  Result := Math.Size(0,0);
  if FHandle = 0 then Exit;
  Result := FSize;
end;

function  TTexture.GetPivot(): TPoint;
begin
  Result := Math.Point(0,0);
  if FHandle = 0 then Exit;
  Result := FPivot;
end;

procedure TTexture.SetPivot(const APoint: TPoint);
begin
  if FHandle = 0 then Exit;
  SetPivot(APoint.X, APoint.Y);
end;

procedure TTexture.SetPivot(const X, Y: Single);
begin
  if FHandle = 0 then Exit;
  FPivot.x := EnsureRange(X, 0, 1);
  FPivot.y := EnsureRange(Y, 0, 1);
end;

function  TTexture.Anchor(): TPoint;
begin
  if FHandle = 0 then Exit;
  Result := FAnchor;
end;

procedure TTexture.SetAnchor(const APoint: TPoint);
begin
  if FHandle = 0 then Exit;
  SetAnchor(APoint.x, APoint.y);
end;

procedure TTexture.SetAnchor(const X, Y: Single);
begin
  if FHandle = 0 then Exit;
  FAnchor.x := EnsureRange(X, 0, 1);
  FAnchor.y := EnsureRange(Y, 0, 1);
end;

function  TTexture.GetBlend(): TTextureBlend;
begin
  Result := tbNone;
  if FHandle = 0 then Exit;
  Result := FBlend;
end;

procedure TTexture.SetBlend(const AValue: TTextureBlend);
begin
  if FHandle = 0 then Exit;
  FBlend := AValue;
end;

function  TTexture.GetPos(): TPoint;
begin
  if FHandle = 0 then Exit;
  Result := FPos;
end;

procedure TTexture.SetPos(const APos: TPoint);
begin
  if FHandle = 0 then Exit;
  FPos := APos;
end;

procedure TTexture.SetPos(const X, Y: Single);
begin
  if FHandle = 0 then Exit;
  FPos.x := X;
  FPos.y := Y;
end;

function  TTexture.GetScale(): Single;
begin
  Result := 0;
  if FHandle = 0 then Exit;
  Result := FScale;
end;

procedure TTexture.SetScale(const AScale: Single);
begin
  if FHandle = 0 then Exit;
  FScale := AScale;
end;

function  TTexture.GetColor(): TColor;
begin
  Result := BLANK;
  if FHandle = 0 then Exit;
  Result := FColor;
end;

procedure TTexture.SetColor(const AColor: TColor);
begin
  if FHandle = 0 then Exit;
  FColor := AColor;
end;

procedure TTexture.SetColor(const ARed, AGreen, ABlue, AAlpha: Single);
begin
  if FHandle = 0 then Exit;

  FColor.r:= EnsureRange(ARed, 0, 1);
  FColor.g := EnsureRange(AGreen, 0, 1);
  FColor.b := EnsureRange(ABlue, 0, 1);
  FColor.a := EnsureRange(AAlpha, 0, 1);
end;

function  TTexture.GetAngle(): Single;
begin
  Result := 0;
  if FHandle = 0 then Exit;
  Result := FAngle;
end;

procedure TTexture.SetAngle(const AAngle: Single);
begin
  if FHandle = 0 then Exit;
  FAngle := AAngle;
end;

function  TTexture.GetHFlip(): Boolean;
begin
  Result := FAlse;
  if FHandle = 0 then Exit;
  Result := FHFlip;
end;

procedure TTexture.SetHFlip(const AFlip: Boolean);
begin
  if FHandle = 0 then Exit;
  FHFlip := AFlip;
end;

function  TTexture.GetVFlip(): Boolean;
begin
  Result := False;
  if FHandle = 0 then Exit;
  Result := FVFlip;
end;

procedure TTexture.SetVFlip(const AFlip: Boolean);
begin
  if FHandle = 0 then Exit;
  FVFlip := AFlip;
end;

function  TTexture.GetRegion(): TRect;
begin
  Result := Math.Rect(0,0,0,0);
  if FHandle = 0 then Exit;
  Result := FRegion;
end;

procedure TTexture.SetRegion(const ARegion: TRect);
begin
  if FHandle = 0 then Exit;
  SetRegion(ARegion.pos.x, ARegion.pos.y, ARegion.size.w, ARegion.size.h);
end;

procedure TTexture.SetRegion(const X, Y, AWidth, AHeight: Single);
begin
  if FHandle = 0 then Exit;
 FRegion.pos.X := X;
 FRegion.pos.Y := Y;
 FRegion.size.w := AWidth;
 FRegion.size.h := AHeight;
end;

procedure TTexture.ResetRegion();
begin
  if FHandle = 0 then Exit;
  FRegion.pos.X := 0;
  FRegion.pos.Y := 0;
  FRegion.size.W := FSize.w;
  FRegion.size.H := FSize.h;
end;

procedure TTexture.Draw(const AWindow: IWindow);
var
  FlipX, FlipY: Single;
begin
  if FHandle = 0 then Exit;
  if not Assigned(AWindow) then Exit;

  glBindTexture(GL_TEXTURE_2D, FHandle);
  glEnable(GL_TEXTURE_2D);

  glPushMatrix();

  // Set the color
  glColor4f(FColor.r, FColor.g, FColor.b, FColor.a);

  // set blending
  case FBlend of
    tbNone: // no blending
    begin
      glDisable(GL_BLEND);
      glBlendFunc(GL_ONE, GL_ZERO);
    end;

    tbAlpha: // alpha blending
    begin
      glEnable(GL_BLEND);
      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    end;

    tbAdditiveAlpha: // addeditve blending
    begin
      glEnable(GL_BLEND);
      glBlendFunc(GL_SRC_ALPHA, GL_ONE);
    end;
  end;

  // Use the normalized anchor value
  glTranslatef(FPos.X - (FAnchor.X * FRegion.size.w * FScale), FPos.Y - (FAnchor.Y * FRegion.size.h * FScale), 0);
  glScalef(FScale, FScale, 1);

  // Apply rotation using the normalized pivot value
  glTranslatef(FPivot.X * FRegion.size.w, FPivot.Y * FRegion.size.h, 0);
  glRotatef(FAngle, 0, 0, 1);
  glTranslatef(-FPivot.X * FRegion.size.w, -FPivot.Y * FRegion.size.h, 0);

  // Apply flip
  if FHFlip then FlipX := -1 else FlipX := 1;
  if FVFlip then FlipY := -1 else FlipY := 1;
  glScalef(FlipX, FlipY, 1);

  // Adjusted texture coordinates and vertices for the specified rectangle
  glBegin(GL_QUADS);
    glTexCoord2f(FRegion.pos.X/FSize.w, FRegion.pos.Y/FSize.h); glVertex2f(0, 0);
    glTexCoord2f((FRegion.pos.X + FRegion.size.w)/FSize.w, FRegion.pos.Y/FSize.h); glVertex2f(FRegion.size.w, 0);
    glTexCoord2f((FRegion.pos.X + FRegion.size.W)/FSize.w, (FRegion.pos.Y + FRegion.size.h)/FSize.h); glVertex2f(FRegion.size.w, FRegion.size.h);
    glTexCoord2f(FRegion.pos.X/FSize.w, (FRegion.pos.Y + FRegion.size.H)/FSize.h); glVertex2f(0, FRegion.size.h);
  glEnd();

  glPopMatrix();

  glDisable(GL_TEXTURE_2D);
  glBindTexture(GL_TEXTURE_2D, 0);
end;

procedure TTexture.DrawTiled(const AWindow: IWindow; const ADeltaX, ADeltaY: Single);
var
  LW,LH    : Integer;
  LOX,LOY  : Integer;
  LPX,LPY  : Single;
  LFX,LFY  : Single;
  LTX,LTY  : Integer;
  LVPW,LVPH: Integer;
  LVR,LVB  : Integer;
  LIX,LIY  : Integer;
  LViewport: TRect;
begin
  if FHandle = 0 then Exit;

  SetPivot(0, 0);
  SetAnchor(0, 0);

  LViewport := AWindow.GetViewport();
  LVPW := Round(LViewport.size.w);
  LVPH := Round(LViewport.size.h);

  LW := Round(FSize.w);
  LH := Round(FSize.h);

  LOX := -LW+1;
  LOY := -LH+1;

  LPX := aDeltaX;
  LPY := aDeltaY;

  LFX := LPX-floor(LPX);
  LFY := LPY-floor(LPY);

  LTX := floor(LPX)-LOX;
  LTY := floor(LPY)-LOY;

  if (LTX>=0) then LTX := LTX mod LW + LOX else LTX := LW - -LTX mod LW + LOX;
  if (LTY>=0) then LTY := LTY mod LH + LOY else LTY := LH - -LTY mod LH + LOY;

  LVR := LVPW;
  LVB := LVPH;
  LIY := LTY;

  while LIY<LVB do
  begin
    LIX := LTX;
    while LIX<LVR do
    begin
      SetPos(LIX+LFX, LIY+LFY);
      Draw(AWindow);
      LIX := LIX+LW;
    end;
   LIY := LIY+LH;
  end;
end;

function  TTexture.Save(const AFilename: string): Boolean;
var
  LData: array of Byte;
  LFilename: string;
begin
  Result := False;
  if FHandle = 0 then Exit;

  if AFilename.IsEmpty then Exit;

  // Allocate space for the texture data
  SetLength(LData, Round(FSize.w * FSize.h * 4)); // Assuming RGBA format

  // Bind the texture
  glBindTexture(GL_TEXTURE_2D, FHandle);

  // Read the texture data
  glGetTexImage(GL_TEXTURE_2D, 0, GL_RGBA, GL_UNSIGNED_BYTE, @LData[0]);

  LFilename := TPath.ChangeExtension(AFilename, 'png');

  // Use stb_image_write to save the texture to a PNG file
  Result := Boolean(stbi_write_png(AsUtf8(LFilename), Round(FSize.w), Round(FSize.h), 4, @LData[0], Round(FSize.w * 4)));

  // Unbind the texture
  glBindTexture(GL_TEXTURE_2D, 0);
end;

function  TTexture.Lock(): Boolean;
begin
  Result := False;
  if FHandle = 0 then Exit;

  if Assigned(FLock) then Exit;

  GetMem(FLock, Round(FSize.w*FSize.h*4));
  if not Assigned(FLock) then Exit;

  glBindTexture(GL_TEXTURE_2D, FHandle);
  glGetTexImage(GL_TEXTURE_2D, 0, GL_RGBA, GL_UNSIGNED_BYTE, FLock);
  glBindTexture(GL_TEXTURE_2D, 0);

  Result := True;
end;

procedure TTexture.Unlock();
begin
  if FHandle = 0 then Exit;

  if not Assigned(FLock) then Exit;

  glBindTexture(GL_TEXTURE_2D, FHandle);
  glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, Round(FSize.w), Round(FSize.h), GL_RGBA, GL_UNSIGNED_BYTE, FLock);
  glBindTexture(GL_TEXTURE_2D, 0);
  FreeMem(FLock);
  FLock := nil;
end;

function  TTexture.GetPixel(const X, Y: Single): TColor;
var
  LOffset: Integer;
  LPixel: Cardinal;
begin
  Result := BLANK;
  if FHandle = 0 then Exit;

  if not Assigned(FLock) then Exit;

  LOffset := Round((Y * FSize.w + X) * 4);
  LPixel := PCardinal(FLock + LOffset)^;

  Result.a := (LPixel shr 24) / $FF;
  Result.b := ((LPixel shr 16) and $FF) / $FF;
  Result.g := ((LPixel shr 8) and $FF) / $FF;
  Result.r := (LPixel and $FF) / $FF;
end;

procedure TTexture.SetPixel(const X, Y: Single; const AColor: TColor);
var
  LOffset: Integer;
begin
  if FHandle = 0 then Exit;

  if not Assigned(FLock) then Exit;

  LOffset := Round((Y * FSize.w + X) * 4);
  PCardinal(FLock + LOffset)^ :=
    (Round(AColor.a*$FF) shl 24) or
    (Round(AColor.b*$FF) shl 16) or
    (Round(AColor.g*$FF) shl 8) or
    Round(AColor.r*$FF);
end;

procedure TTexture.SetPixel(const X, Y: Single; const ARed, AGreen, ABlue, AAlpha: Byte);
var
  LOffset: Integer;
begin
  if FHandle = 0 then Exit;

  if not Assigned(FLock) then Exit;

  LOffset := Round((Y * FSize.w + X) * 4);
  PCardinal(FLock + LOffset)^ :=
    (AAlpha shl 24) or
    (ABlue shl 16) or
    (AGreen shl 8) or
    ARed;
end;

function  TTexture.CollideAABB(const ATexture: ITexture): Boolean;
var
  LA: TTexture;
  LB: TTexture;
  boxA, boxB: c2AABB;

  function _c2v(x, y: Single): c2v;
  begin
    result.x := x;
    result.y := y;
  end;

begin
  Result := False;

  LA := Self;
  LB := ATexture as TTexture;

  if not Assigned(LA) then Exit;
  if LA.FHandle = 0 then Exit;

  if not Assigned(LB) then Exit;
  if LB.FHandle = 0 then Exit;

  // Set up AABB for this texture
  boxA.min := _c2V(LA.FPos.X - (LA.FAnchor.X * LA.FRegion.size.w * LA.FScale), LA.FPos.Y - (LA.FAnchor.Y * LA.FRegion.size.h * LA.FScale));
  boxA.max := _c2V((LA.FPos.X - (LA.FAnchor.X * LA.FRegion.size.w * LA.FScale)) + LA.FRegion.size.w * LA.FScale, (LA.FPos.Y - (LA.FAnchor.Y * LA.FRegion.size.h * LA.FScale)) + LA.FRegion.size.h * LA.FScale);

  // Set up AABB for the other texture
  boxB.min := _c2V(LB.FPos.X - (LB.FAnchor.X * LB.FRegion.size.w * LB.FScale), LB.FPos.Y - (LB.FAnchor.Y * LB.FRegion.size.h * LB.FScale));
  boxB.max := _c2V((LB.FPos.X - (LB.FAnchor.X * LB.FRegion.size.w * LB.FScale)) + LB.FRegion.size.w * LB.FScale, (LB.FPos.Y - (LB.FAnchor.Y * LB.FRegion.size.h * LB.FScale)) + LB.FRegion.size.h * LB.FScale);

  // Check for collision and return result
  Result := Boolean(c2AABBtoAABB(boxA, boxB));
end;

function  TTexture.CollideOBB(const ATexture: ITexture): Boolean;
var
  LA: TTexture;
  LB: TTexture;
  obbA, obbB: TOBB;
begin
  Result := False;

  LA := Self;
  LB := ATexture as TTexture;

  if not Assigned(LA) then Exit;
  if LA.FHandle = 0 then Exit;

  if not Assigned(LB) then Exit;
  if LB.FHandle = 0 then Exit;

  // Set up OBB for this texture
  obbA.Center := Math.Point(LA.FPos.X, LA.FPos.Y);
  obbA.Extents := Math.Point(LA.FRegion.size.w * LA.FScale / 2, LA.FRegion.size.h * LA.FScale / 2);
  obbA.Rotation := LA.FAngle;

  // Set up OBB for the other texture
  obbB.Center := Math.Point(LB.FPos.X, LB.FPos.Y);
  obbB.Extents := Math.Point(LB.FRegion.size.w * LB.FScale / 2, LB.FRegion.size.h * LB.FScale / 2);
  obbB.Rotation := LB.FAngle;

  // Check for collision and return result
  Result := Math.OBBIntersect(obbA, obbB);
end;
{$ENDREGION}

{$REGION ' FONT '}
//=== FONT ==================================================================
type
  { TFont }
  TFont = class(TBaseInterface, IFont)
  protected const
    DEFAULT_GLYPHS = ' !"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~™©';
  protected type
    PFontGlyph = ^TFontGlyph;
    TFontGlyph = record
      SrcRect: TRect;
      DstRect: TRect;
      XAdvance: Single;
    end;
  protected
    FAtlasSize: Integer;
    FAtlas: TTexture;
    FBaseLine: Single;
    FGlyph: TDictionary<Integer, TFontGlyph>;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    function  Load(const AWindow: IWindow; const ASize: Cardinal; const AGlyphs: string=''): Boolean; overload;
    function  Load(const AWindow: IWindow; const AIO: IIO; const ASize: Cardinal; const AGlyphs: string=''; const AOwnIO: Boolean=True): Boolean; overload;
    function  LoadFromFile(const AWindow: IWindow; const AFilename: string; const ASize: Cardinal; const AGlyphs: string=''): Boolean;
    function  LoadFromZipFile(const AWindow: IWindow; const AZipFilename, AFilename: string; const ASize: Cardinal; const AGlyphs: string=''; const APassword: string=CDefaultZipFilePassword): Boolean;
    procedure Unload();
    procedure DrawText(const AWindow: IWindow; const X, Y: Single; const AColor: TColor; AHAlign: THAlign; const AText: string; const AArgs: array of const); overload;
    procedure DrawText(const AWindow: IWindow; const X: Single; var Y: Single; const aLineSpace: Single; const aColor: TColor; AHAlign: THAlign; const AText: string; const AArgs: array of const); overload;
    function  TextLength(const AText: string; const AArgs: array of const): Single;
    function  TextHeight(): Single;
    function  SaveTexture(const AFilename: string): Boolean;
  end;

{ TFont }
constructor TFont.Create();
begin
  inherited;
  FGlyph := TDictionary<Integer, TFontGlyph>.Create();
end;

destructor TFont.Destroy();
begin
  Unload();
  FGlyph.Free();

  inherited;
end;

function  TFont.Load(const AWindow: IWindow; const ASize: Cardinal; const AGlyphs: string): Boolean;
const
  CDefaultFontResName = 'a22a034b88d844578c672a8073d49229';
var
  LResStream: TResourceStream;
  LIO: TMemoryIO;
begin
  Result := False;
  if not Assigned(AWindow) then Exit;
  if not ResourceExist(HInstance, CDefaultFontResName) then Exit;

  LResStream := TResourceStream.Create(HInstance, CDefaultFontResName, RT_RCDATA);
  try
    LIO := TMemoryIO.Create;
    LIO.Open(LResStream.Memory, LResStream.Size);
    if not Load(AWindow, LIO, ASize, AGlyphs) then Exit;
  finally
    LResStream.Free();
  end;
end;

function  TFont.Load(const AWindow: IWindow; const AIO: IIO; const ASize: Cardinal; const AGlyphs: string; const AOwnIO: Boolean): Boolean;
var
  LBuffer: TVirtualBuffer;
  LChars: TVirtualBuffer;
  LFileSize: Int64;
  LFontInfo: stbtt_fontinfo;
  NumOfGlyphs: Integer;
  LGlyphChars: string;
  LCodePoints: array of Integer;
  LBitmap: array of Byte;
  LPackContext: stbtt_pack_context;
  LPackRange: stbtt_pack_range;
  I: Integer;
  LGlyph: TFontGlyph;
  LChar: Pstbtt_packedchar;
  LScale: Single;
  LAscent: Integer;
  LSize: Single;
  LMaxTextureSize: Integer;
  LDpiScale: Single;
  LIO: IIO;
begin
  Result := False;
  if not Assigned(AWindow) then Exit;
  if not Assigned(AIO) then Exit;

  LIO := AIO;

  LDpiScale := AWindow.GetScale().h;
  LMaxTextureSize :=  AWindow.GetMaxTextureSize();

  LSize := aSize * LDpiScale;
  LFileSize :=  LIO.Size();
  LBuffer := TVirtualBuffer.Create(LFileSize);
  try
    LIO.Read(LBuffer.Memory, LFileSize);

    if stbtt_InitFont(@LFontInfo, LBuffer.Memory, 0) = 0 then Exit;
    LGlyphChars := DEFAULT_GLYPHS + aGlyphs;
    LGlyphChars := RemoveDuplicates(LGlyphChars);
    NumOfGlyphs :=  LGlyphChars.Length;
    SetLength(LCodePoints, NumOfGlyphs);

    for I := 1 to NumOfGlyphs do
    begin
      LCodePoints[I-1] := Integer(Char(LGlyphChars[I]));
    end;

    LChars := TVirtualBuffer.Create(SizeOf(stbtt_packedchar) * (NumOfGlyphs+1));
    try
      LPackRange.font_size := -LSize;
      LPackRange.first_unicode_codepoint_in_range := 0;
      LPackRange.array_of_unicode_codepoints := @LCodePoints[0];
      LPackRange.num_chars := NumOfGlyphs;
      LPackRange.chardata_for_range := LChars.Memory;
      LPackRange.h_oversample := 1;
      LPackRange.v_oversample := 1;

      FAtlasSize := 32;

      while True do
      begin
        SetLength(LBitmap, FAtlasSize * FAtlasSize);
        stbtt_PackBegin(@LPackContext, @LBitmap[0], FAtlasSize, FAtlasSize, 0, 1, nil);
        stbtt_PackSetOversampling(@LPackContext, 1, 1);
        if stbtt_PackFontRanges(@LPackContext, LBuffer.Memory, 0, @LPackRange, 1) = 0  then
          begin
            LBitmap := nil;
            stbtt_PackEnd(@LPackContext);
            FAtlasSize := FAtlasSize * 2;
            if (FAtlasSize > LMaxTextureSize) then
            begin
              raise Exception.Create(Format('Font texture too large. Max size: %d', [LMaxTextureSize]));
            end;
          end
        else
          begin
            stbtt_PackEnd(@LPackContext);
            break;
          end;
      end;

      FAtlas := TTexture.Create();
      FAtlas.Load(@LBitmap[0], FAtlasSize, FAtlasSize);
      FAtlas.SetPivot(0, 0);
      FAtlas.SetAnchor(0, 0);
      FAtlas.SetBlend(tbAlpha);
      FAtlas.SetColor(WHITE);

      LBitmap := nil;

      LScale := stbtt_ScaleForMappingEmToPixels(@LFontInfo, LSize);
      stbtt_GetFontVMetrics(@LFontInfo, @LAscent, nil, nil);
      FBaseline := LAscent * LScale;

      FGlyph.Clear();
      for I := Low(LCodePoints) to High(LCodePoints) do
      begin
        LChar := Pstbtt_packedchar(LChars.Memory);
        Inc(LChar, I);

        LGlyph.SrcRect.pos.x := LChar.x0;
        LGlyph.SrcRect.pos.y := LChar.y0;
        LGlyph.SrcRect.size.w := LChar.x1-LChar.x0;
        LGlyph.SrcRect.size.h := LChar.y1-LChar.y0;

        LGlyph.DstRect.pos.x := 0 + LChar.xoff;
        LGlyph.DstRect.pos.y := 0 + LChar.yoff + FBaseline;
        LGlyph.DstRect.size.w := (LChar.x1-LChar.x0);
        LGlyph.DstRect.size.h := (LChar.y1-LChar.y0);

        LGlyph.XAdvance := LChar.xadvance;

        FGlyph.Add(LCodePoints[I], LGlyph);
      end;

      if AOwnIO then
      begin
        IRelease(LIO);
      end;

      Result := True;

    finally
      LChars.Free();
    end;

  finally
    LBuffer.Free();
  end;
end;

function  TFont.LoadFromFile(const AWindow: IWindow; const AFilename: string; const ASize: Cardinal; const AGlyphs: string): Boolean;
var
  LIO: IFileIO;
begin
  Result := False;
  if not IGet(IFileIO, LIO) then Exit;
  try
    if not LIO.Open(AFilename, iomRead) then Exit;
    Result := Load(AWindow, LIO, ASize, AGlyphs, False);
  finally
    IRelease(LIO);
  end;
end;

function  TFont.LoadFromZipFile(const AWindow: IWindow; const AZipFilename, AFilename: string; const ASize: Cardinal; const AGlyphs: string; const APassword: string): Boolean;
var
  LIO: TZipFileIO;
begin
  Result := False;

  LIO := TZipFileIO.Create();
  if not LIO.Open(AZipFilename, AFilename, APassword) then
  begin
    LIO.Free();
    Exit;
  end;

  Result := Load(AWindow, LIO, ASize, AGlyphs, True);
end;

procedure TFont.Unload();
begin
  if Assigned(FAtlas) then
  begin
    FAtlas.Free();
    FGlyph.Clear();
  end;
end;

procedure TFont.DrawText(const AWindow: IWindow; const X, Y: Single; const AColor: TColor; AHAlign: THAlign; const AText: string; const AArgs: array of const);
var
  LText: string;
  LChar: Integer;
  LGlyph: TFontGlyph;
  I, LLen: Integer;
  LX, LY: Single;
  LViewport: TRect;
  LWidth: Single;
begin
  LText := Format(AText, AArgs);
  LLen := LText.Length;

  LX := X;
  LY := Y;

  LViewport := AWindow.GetViewport();

  case aHAlign of
    haLeft:
      begin
      end;
    haCenter:
      begin
        LWidth := TextLength(AText, []);
        LX := (LViewport.size.w - LWidth)/2;
      end;
    haRight:
      begin
        LWidth := TextLength(AText, []);
        LX := LViewport.size.w - LWidth;
      end;
  end;

  FAtlas.SetColor(AColor);

  for I := 1 to LLen do
  begin
    LChar := Integer(Char(LText[I]));
    if FGlyph.TryGetValue(LChar, LGlyph) then
    begin
      LGlyph.DstRect.pos.x := LGlyph.DstRect.pos.x + LX;
      LGlyph.DstRect.pos.y := LGlyph.DstRect.pos.y + LY;

      FAtlas.SetRegion(LGlyph.SrcRect);
      FAtlas.SetPos(LGlyph.DstRect.pos.x, LGlyph.DstRect.pos.y);
      FAtlas.Draw(AWindow);
      LX := LX + LGlyph.XAdvance;
    end;
  end;
end;

procedure TFont.DrawText(const AWindow: IWindow; const X: Single; var Y: Single; const aLineSpace: Single; const aColor: TColor; AHAlign: THAlign; const AText: string; const AArgs: array of const);
begin
  DrawText(AWindow, X, Y, aColor, aHAlign, AText, AArgs);
  Y := Y + FBaseLine + ALineSpace;
end;

function  TFont.TextLength(const AText: string; const AArgs: array of const): Single;
var
  LText: string;
  LChar: Integer;
  LGlyph: TFontGlyph;
  I, LLen: Integer;
  LWidth: Single;
begin
  Result := 0;
  if not Assigned(FAtlas) then Exit;

  LText := AText;
  LLen := LText.Length;

  LWidth := 0;

  for I := 1 to LLen do
  begin
    LChar := Integer(Char(LText[I]));
    if FGlyph.TryGetValue(LChar, LGlyph) then
    begin
      LWidth := LWidth + LGlyph.XAdvance;
    end;
  end;

  Result := LWidth;
end;

function  TFont.TextHeight(): Single;
begin
  Result :=0;
  if not Assigned(FAtlas) then Exit;
  Result := FBaseLine;
end;

function  TFont.SaveTexture(const AFilename: string): Boolean;
begin
  Result := False;
  if not Assigned(FAtlas) then Exit;
  if AFilename.IsEmpty then Exit;
  FAtlas.Save(AFilename);
end;
{$ENDREGION}

{$REGION ' VIDEO '}
//=== VIDEO =================================================================
type
  { TVideo }
  TVideo = class(TBaseInterface, IVideo)
  private const
    BUFFERSIZE = 1024;
    CSampleSize = 2304;
    CSampleRate = 44100;
  private
    FIO: IIO;
    FStatus: TVideoStatus;
    FStatusFlag: Boolean;
    FStaticPlmBuffer: array[0..BUFFERSIZE] of byte;
    FRingBuffer: TVirtualRingBuffer<Single>;
    FDeviceConfig: ma_device_config;
    FDevice: ma_device;
    FPLM: Pplm_t;
    FVolume: Single;
    FLoop: Boolean;
    FRGBABuffer: array of uint8;
    FTexture: TTexture;
    FCallback: TCallback<TVideoStatusEvent>;
    FFilename: string;
    procedure OnStatusEvent();
  public
    constructor Create(); override;
    destructor Destroy(); override;
    function  GetStatusEvent(): TVideoStatusEvent;
    procedure SetStatusEvent(const ASender: Pointer; const AHandler: TVideoStatusEvent);
    function  Play(const AIO: IIO; const AFilename: string; const AVolume: Single; const ALoop: Boolean): Boolean;
    function  PlayFromZipFile(const AZipFilename, AFilename: string; const AVolume: Single; const ALoop: Boolean; const APassword: string=CDefaultZipFilePassword): Boolean;
    procedure Stop();
    function  Update(const AWindow: IWindow): Boolean;
    procedure Draw(const AWindow: IWindow; const X, Y, AScale: Single);
    function  Status(): TVideoStatus;
    function  Volume(): Single;
    procedure SetVolume(const AVolume: Single);
    function  IsLooping(): Boolean;
    procedure SetLooping(const ALoop: Boolean);
  end;

{ Video }
procedure TVideo_MADataCallback(ADevice: Pma_device; AOutput: Pointer; AInput: Pointer; AFrameCount: ma_uint32); cdecl;
var
  LReadPtr: PSingle;
  LFramesNeeded: Integer;
  LVideo: TVideo;
begin
  LVideo := Video as TVideo;
  LFramesNeeded := AFrameCount * 2;
  LReadPtr := PSingle(LVideo.FRingBuffer.DirectReadPointer(LFramesNeeded));

  if LVideo.FRingBuffer.AvailableBytes >= LFramesNeeded then
    begin
      Move(LReadPtr^, AOutput^, LFramesNeeded * SizeOf(Single));
    end
  else
    begin
      FillChar(AOutput^, LFramesNeeded * SizeOf(Single), 0);
    end;
end;

procedure TVideo_PLMAudioDecodeCallback(APLM: Pplm_t; ASamples: Pplm_samples_t; AUserData: Pointer); cdecl;
var
  LVideo: TVideo;
begin
  LVideo := Video as TVideo;

  LVideo.FRingBuffer.Write(ASamples^.interleaved, ASamples^.count*2);
end;

procedure TVideo_PLMVideoDecodeCallback(APLM: Pplm_t; AFrame: Pplm_frame_t; AUserData: Pointer); cdecl;
var
  LVideo: TVideo;
begin
  LVideo := Video as TVideo;

  // convert YUV to RGBA
  plm_frame_to_rgba(AFrame, @LVideo.FRGBABuffer[0], Round(LVideo.FTexture.FSize.w*4));

  // update OGL texture
  glBindTexture(GL_TEXTURE_2D, LVideo.FTexture.FHandle);
  glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, AFrame^.width, AFrame^.height, GL_RGBA, GL_UNSIGNED_BYTE, LVideo.FRGBABuffer);
end;

procedure TVideo_PLMLoadBufferCallback(ABuffer: pplm_buffer_t; AUserData: pointer); cdecl;
var
  LBytesRead: Int64;
  LVideo: TVideo;
begin
  LVideo := Video as TVideo;

  // read data from inputstream
  LBytesRead := LVideo.FIO.Read(@LVideo.FStaticPlmBuffer[0], LVideo.BUFFERSIZE);

  // push LBytesRead to PLM buffer
  if LBytesRead > 0 then
    begin
      plm_buffer_write(aBuffer, @LVideo.FStaticPlmBuffer[0], LBytesRead);
    end
  else
    begin
      // set status to stopped
      LVideo.FStatus := vsStopped;
      LVideo.FStatusFlag := True;
    end;
end;

procedure TVideo.OnStatusEvent();
begin
  if Assigned(FCallback.Handler) then
  begin
    FCallback.Handler(FCallback.UserData, FStatus, FFilename);
  end;
end;

constructor TVideo.Create();
begin
  inherited;
end;

destructor TVideo.Destroy();
begin
  Stop();
  inherited;
end;

function  TVideo.GetStatusEvent(): TVideoStatusEvent;
begin
  Result := FCallback.Handler;
end;

procedure TVideo.SetStatusEvent(const ASender: Pointer; const AHandler: TVideoStatusEvent);
begin
  FCallback.Handler := AHandler;
  FCallback.UserData := ASender;
end;

function  TVideo.Play(const AIO: IIO;  const AFilename: string; const AVolume: Single; const ALoop: Boolean): Boolean;
var
  LBuffer: Pplm_buffer_t;
begin
  Result := False;

  Stop();

  // set volume & loop status
  FVolume := AVolume;
  FLoop := ALoop;

  // init ringbuffer
  FRingBuffer := TVirtualRingBuffer<Single>.Create(CSampleRate*2);
  if not Assigned(FRingBuffer) then Exit;

  // init device for audio playback
  FDeviceConfig := ma_device_config_init(ma_device_type_playback);
  FDeviceConfig.playback.format := ma_format_f32;
  FDeviceConfig.playback.channels := 2;
  FDeviceConfig.sampleRate := CSampleRate;
  FDeviceConfig.dataCallback := @TVideo_MADataCallback;
  if ma_device_init(nil, @FDeviceConfig, @FDevice) <> MA_SUCCESS then Exit;
  ma_device_start(@FDevice);
  SetVolume(AVolume);

  // set the input stream
  FIO := AIO;
  FFilename := AFilename;
  FStatus := vsPlaying;
  FStatusFlag := False;
  OnStatusEvent();

  // init plm buffer
  LBuffer := plm_buffer_create_with_capacity(BUFFERSIZE);
  if not Assigned(LBuffer) then
  begin
    ma_device_uninit(@FDevice);
    FRingBuffer.Free;
    Exit;
  end;

  plm_buffer_set_load_callback(LBuffer, TVideo_PLMLoadBufferCallback, Self);
  FPLM := plm_create_with_buffer(LBuffer, 1);
  if not Assigned(FPLM) then
  begin
    plm_buffer_destroy(LBuffer);
    ma_device_uninit(@FDevice);
    FRingBuffer.Free;
    Exit;
  end;

  // create video render texture
  FTexture := TTexture.Create;
  FTexture.SetBlend(tbNone);
  FTexture.Alloc(plm_get_width(FPLM), plm_get_height(FPLM));

  // alloc the video rgba buffer
  SetLength(FRGBABuffer,
    Round(FTexture.GetSize.w*FTexture.GetSize.h*4));
  if not Assigned(FRGBABuffer) then
  begin
    plm_buffer_destroy(LBuffer);
    ma_device_uninit(@FDevice);
    FRingBuffer.Free;
    Exit;
  end;

  // set the audio lead time
  plm_set_audio_lead_time(FPLM, (CSampleSize*2)/FDeviceConfig.sampleRate);

  // set audio/video callbacks
  plm_set_audio_decode_callback(FPLM, TVideo_PLMAudioDecodeCallback, Self);
  plm_set_video_decode_callback(FPLM, TVideo_PLMVideoDecodeCallback, Self);

  FTexture.SetPivot(0, 0);
  FTexture.SetAnchor(0, 0);
  FTexture.SetBlend(tbNone);

  // return OK
  Result := True;
end;

function  TVideo.PlayFromZipFile(const AZipFilename, AFilename: string; const AVolume: Single; const ALoop: Boolean; const APassword: string): Boolean;
var
  LIO: TZipFileIO;
begin
  Result := False;

  LIO := TZipFileIO.Create();
  if not LIO.Open(AZipFilename, AFilename, APassword) then
  begin
    LIO.Free();
    Exit;
  end;

  Result := Play(LIO, AFilename, AVolume, ALoop);
end;

procedure TVideo.Stop();
begin
  if not Assigned(FPLM) then Exit;

  ma_device_stop(@FDevice);
  ma_device_uninit(@FDevice);

  plm_destroy(FPLM);

  //FIO.Free;
  IRelease(FIO);
  FTexture.Free;
  FRingBuffer.Free;

  FPLM := nil;
  FRingBuffer := nil;
  FStatus := vsStopped;
  FTexture := nil;
end;

function  TVideo.Update(const AWindow: IWindow): Boolean;
begin
  Result := False;
  if not Assigned(FPLM) then Exit;
  if FStatusFlag then
  begin
    FStatusFlag := False;
    OnStatusEvent();
  end;

  if FStatus = vsStopped then
  begin
    ma_device_stop(@FDevice);

    if FLoop then
    begin
      plm_rewind(FPLM);
      FIO.Seek(0, iosStart);
      FRingBuffer.Clear;
      ma_device_start(@FDevice);
      SetVolume(FVolume);
      FStatus := vsPlaying;
      plm_decode(FPLM, AWindow.GetTargetTime());
      OnStatusEvent();
      Exit;
    end;
    Result := True;
    Exit;
  end;

  plm_decode(FPLM, AWindow.GetTargetTime());
end;

procedure TVideo.Draw(const AWindow: IWindow; const X, Y, AScale: Single);
begin
  if FStatus <> vsPlaying then Exit;
  FTexture.SetPos(X, Y);
  FTexture.SetScale(AScale);
  FTexture.Draw(AWindow);
end;

function  TVideo.Status(): TVideoStatus;
begin
  Result := FStatus;
end;

function  TVideo.Volume(): Single;
begin
  Result := FVolume;
end;

procedure TVideo.SetVolume(const AVolume: Single);
begin
  FVolume := EnsureRange(AVolume, 0, 1);
  ma_device_set_master_volume(@FDevice, Math.UnitToScalarValue(FVolume, 1));
end;

function  TVideo.IsLooping(): Boolean;
begin
  Result := FLoop;
end;

procedure TVideo.SetLooping(const ALoop: Boolean);
begin
  FLoop := ALoop;
end;
{$ENDREGION}

{$REGION ' AUDIO '}
//=== AUDIO =================================================================
type
  { TMaVFS }
  PMaVFS = ^TMaVFS;
  TMaVFS = record
  private
    Callbacks: ma_vfs_callbacks;
    IO: IIO;
  public
    constructor Create(const AIO: IIO);
  end;

{ TMaVPS }
function TMaVFS_OnOpen(AVFS: Pma_vfs; const AFilename: PUTF8Char; AOpenMode: ma_uint32; AFile: Pma_vfs_file): ma_result; cdecl;
var
  LIO: IIO;
begin
  Result := MA_ERROR;
  LIO := PMaVFS(AVFS).IO;
  if not Assigned(LIO) then Exit;
  if not LIO.IsOpen() then Exit;
  AFile^ := LIO;
  Result := MA_SUCCESS;
end;

function TMaVFS_OnOpenW(AVFS: Pma_vfs; const AFilename: PWideChar; AOpenMode: ma_uint32; pFile: Pma_vfs_file): ma_result; cdecl;
begin
  Result := MA_ERROR;
end;

function TMaVFS_OnClose(AVFS: Pma_vfs; file_: ma_vfs_file): ma_result; cdecl;
var
  LIO: IIO;
begin
  Result := MA_ERROR;
  LIO := IIO(File_);
  if not Assigned(LIO) then Exit;
  if not LIO.IsOpen then Exit;
  IRelease(LIO);
  Result := MA_SUCCESS;
end;

function TMaVFS_OnRead(AVFS: Pma_vfs; file_: ma_vfs_file; AData: Pointer; ASizeInBytes: NativeUInt; ABytesRead: PNativeUInt): ma_result; cdecl;
var
  LIO: IIO;
  LResult: Int64;
begin
  Result := MA_ERROR;
  LIO := IIO(File_);
  if not Assigned(LIO) then Exit;
  if not LIO.IsOpen then Exit;
  LResult := LIO.Read(AData, ASizeInBytes);
  if LResult < 0 then Exit;
  ABytesRead^ := LResult;
  Result := MA_SUCCESS;
end;

function TMaVFS_OnWrite(AVFS: Pma_vfs; AVFSFile: ma_vfs_file; const AData: Pointer; ASizeInBytes: NativeUInt; ABytesWritten: PNativeUInt): ma_result; cdecl;
begin
  Result := MA_ERROR;
end;

function TMaVFS_OnSeek(AVFS: Pma_vfs; file_: ma_vfs_file; AOffset: ma_int64;
  AOrigin: ma_seek_origin): ma_result; cdecl;
var
  LIO: IIO;
begin
  Result := MA_ERROR;
  LIO := IIO(File_);
  if not Assigned(LIO) then Exit;
  if not LIO.IsOpen then Exit;
  LIO.Seek(AOffset, TIOSeek(AOrigin));
  Result := MA_SUCCESS;
end;

function TMaVFS_OnTell(AVFS: Pma_vfs; file_: ma_vfs_file; ACursor: Pma_int64): ma_result; cdecl;
var
  LIO: IIO;
begin
  Result := MA_ERROR;
  LIO := IIO(File_);
  if not Assigned(LIO) then Exit;
  if not LIO.IsOpen then Exit;
  ACursor^ := LIO.Pos();
  Result := MA_SUCCESS;
end;

function TMaVFS_OnInfo(AVFS: Pma_vfs; AVFSFile: ma_vfs_file; AInfo: Pma_file_info): ma_result; cdecl;
var
  LIO: IIO;
  LResult: Int64;
begin
  Result := MA_ERROR;
  LIO := IIO(AVFSFile);
  if not Assigned(LIO) then Exit;
  if not LIO.IsOpen then Exit;

  LResult := LIO.Size;
  if LResult < 0 then Exit;

  AInfo.sizeInBytes := LResult;
  Result := MA_SUCCESS;
end;

constructor TMaVFS.Create(const AIO: IIO);
begin
  Self := Default(TMaVFS);
  Callbacks.onopen := TMaVFS_OnOpen;
  Callbacks.onOpenW := TMaVFS_OnOpenW;
  Callbacks.onRead := TMaVFS_OnRead;
  Callbacks.onWrite := TMaVFS_OnWrite;
  Callbacks.onclose := TMaVFS_OnClose;
  Callbacks.onread := TMaVFS_OnRead;
  Callbacks.onseek := TMaVFS_OnSeek;
  Callbacks.onTell := TMaVFS_OnTell;
  Callbacks.onInfo := TMaVFS_OnInfo;
  IO := AIO;
end;

type
  { TAudio }
  TAudio = class(TBaseInterface, IAudio)
  protected type
    TMusic = record
      Handle: ma_sound;
      Loaded: Boolean;
      Volume: Single;
      Pan: Single;
    end;
    TSound = record
      Handle: ma_sound;
      InUse: Boolean;
    end;
    TChannel = record
      Handle: ma_sound;
      Reserved: Boolean;
      InUse: Boolean;
      Volume: Single;
    end;
  protected
    FVFS: TMaVFS;
    FEngineConfig: ma_engine_config;
    FEngine: ma_engine;
    FOpened: Boolean;
    FPaused: Boolean;
    FMusic: TMusic;
    snd1,snd2,snd3: ma_sound;
    FSound: array[0..SOUND_COUNT-1] of TSound;
    FChannel: array[0..CHANNEL_COUNT-1] of TChannel;
    function FindFreeSoundSlot(): Integer;
    function FindFreeChannelSlot(): Integer;
    function ValidChannel(const AChannel: Integer): Boolean;
    procedure InitData();
  public
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Update();
    function  Open(): Boolean;
    function  IsOpen(): Boolean;
    procedure Close();
    function  IsPaused(): Boolean;
    procedure SetPause(const APause: Boolean);
    function  PlayMusic(const AIO: IIO; const AFilename: string; const AVolume: Single; const ALoop: Boolean; const APan: Single=0.0): Boolean;
    function  PlayMusicFromFile(const AFilename: string; const AVolume: Single; const ALoop: Boolean; const APan: Single=0.0): Boolean;
    function  PlayMusicFromZipFile(const AZipFilename, AFilename: string; const AVolume: Single; const ALoop: Boolean; const APan: Single=0.0; const APassword: string=CDefaultZipFilePassword): Boolean;
    procedure UnloadMusic();
    function  IsMusicLooping(): Boolean;
    procedure SetMusicLooping(const ALoop: Boolean);
    function  MusicVolume(): Single;
    procedure SetMusicVolume(const AVolume: Single);
    function  MusicPan(): Single;
    procedure SetMusicPan(const APan: Single);
    function  LoadSound(const AIO: IIO; const AFilename: string): Integer;
    function  LoadSoundFromFile(const AFilename: string): Integer;
    function  LoadSoundFromZipFile(const AZipFilename, AFilename: string; const APassword: string=CDefaultZipFilePassword): Integer;
    procedure UnloadSound(var ASound: Integer);
    procedure UnloadAllSounds();
    function  PlaySound(const ASound, AChannel: Integer; const AVolume: Single; const ALoop: Boolean): Integer;
    procedure ReserveChannel(const AChannel: Integer; const aReserve: Boolean);
    procedure StopChannel(const AChannel: Integer);
    procedure SetChannelVolume(const AChannel: Integer; const AVolume: Single);
    function  GetChannelVolume(const AChannel: Integer): Single;
    procedure SetChannelPosition(const AChannel: Integer; const X, Y: Single);
    procedure SetChannelLoop(const AChannel: Integer; const ALoop: Boolean);
    function  GetchannelLoop(const AChannel: Integer): Boolean;
    function  GetChannelPlaying(const AChannel: Integer): Boolean;
  end;

{ TAudio }
function TAudio.FindFreeSoundSlot(): Integer;
var
  I: Integer;
begin
  Result := ERROR;
  for I := 0 to SOUND_COUNT-1 do
  begin
    if not FSound[I].InUse then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

function TAudio.FindFreeChannelSlot(): Integer;
var
  I: Integer;
begin
  Result := ERROR;
  for I := 0 to SOUND_COUNT-1 do
  begin
    if (not FChannel[I].InUse) and (not FChannel[I].Reserved) then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

function TAudio.ValidChannel(const AChannel: Integer): Boolean;
begin
  Result := False;
  if not InRange(AChannel, 0, CHANNEL_COUNT-1) then Exit;
  if not FChannel[AChannel].InUse then Exit;
  Result := True;
end;

constructor TAudio.Create();
begin
  inherited;
end;

destructor TAudio.Destroy();
begin
  Close();
  inherited;
end;

function  TAudio.Open(): Boolean;
begin
  Result := False;
  if IsOpen() then Exit;

  FVFS := TMaVFS.Create(nil);
  FEngineConfig := ma_engine_config_init;
  FEngineConfig.pResourceManagerVFS := @FVFS;
  if ma_engine_init(@FEngineConfig, @FEngine) <> MA_SUCCESS then Exit;

  FOpened := True;
  Result := IsOpen();
end;

procedure TAudio.Close();
begin
  if not IsOpen() then Exit;
  UnloadMusic();
  UnloadAllSounds();
  ma_engine_uninit(@FEngine);
  InitData;
end;

function TAudio.IsOpen(): Boolean;
begin
  Result := FOpened;
end;

procedure TAudio.InitData();
var
  I: Integer;
begin
  FEngine := Default(ma_engine);

  for I := Low(FSound) to High(FSound) do
    FSound[I] := Default(TSound);

  for I := Low(FChannel) to High(FChannel) do
    FChannel[i] := Default(TChannel);

  FOpened := False;
  FPaused := False;
end;

procedure TAudio.Update();
var
  I: Integer;
begin
  if not IsOpen() then Exit;

  // check channels
  for I := 0 to CHANNEL_COUNT-1 do
  begin
    if FChannel[I].InUse then
    begin
      if ma_sound_is_playing(@FChannel[I].Handle) = MA_FALSE then
      begin
        ma_sound_uninit(@FChannel[I].Handle);
        FChannel[I].InUse := False;
      end;
    end;
  end;
end;

function  TAudio.IsPaused(): Boolean;
begin
  Result := FPaused;
end;

procedure TAudio.SetPause(const APause: Boolean);
begin
  if not IsOpen() then Exit;

  case aPause of
    True:
    begin
      if ma_engine_stop(@FEngine) = MA_SUCCESS then
        FPaused := aPause;
    end;

    False:
    begin
      if ma_engine_start(@FEngine) = MA_SUCCESS then
        FPaused := aPause;
    end;
  end;
end;

function  TAudio.PlayMusic(const AIO: IIO; const AFilename: string; const AVolume: Single; const ALoop: Boolean; const APan: Single): Boolean;
begin
  Result := FAlse;
  if not IsOpen then Exit;
  if not Assigned(AIO) then Exit;
  UnloadMusic();
  FVFS.IO := AIO;
  if ma_sound_init_from_file(@FEngine, AsUtf8(AFilename), Ord(MA_SOUND_FLAG_STREAM), nil,
    nil, @FMusic.Handle) <> MA_SUCCESS then
  FVFS.IO := nil;
  ma_sound_start(@FMusic);
  FMusic.Loaded := True;
  SetMusicLooping(ALoop);
  SetMusicVolume(AVolume);
  SetMusicPan(APan);
end;

function  TAudio.PlayMusicFromFile(const AFilename: string; const AVolume: Single; const ALoop: Boolean; const APan: Single): Boolean;
var
  LIO: IFileIO;
begin
  Result := False;
  if not IGet(IFileIO, LIO) then Exit;
  if not LIO.Open(AFilename,iomRead) then
  begin
    IRelease(LIO);
    Exit;
  end;

  Result := PlayMusic(LIO, AFilename, AVolume, ALoop, APan);
end;

function  TAudio.PlayMusicFromZipFile(const AZipFilename, AFilename: string; const AVolume: Single; const ALoop: Boolean; const APan: Single; const APassword: string): Boolean;
var
  LIO: IZipFileIO;
begin
  Result := False;
  if not IGet(IZipFileIO, LIO) then Exit;

  if not LIO.Open(AZipFilename, AFilename, APassword) then
  begin
    IRelease(LIO);
    Exit;
  end;
  Result := PlayMusic(LIO, AFilename, AVolume, ALoop, APan);
end;

procedure TAudio.UnloadMusic();
begin
  if not IsOpen() then Exit;
  if not FMusic.Loaded then Exit;
  ma_sound_stop(@FMusic.Handle);
  ma_sound_uninit(@FMusic.Handle);
  FMusic.Loaded := False;
end;

function  TAudio.IsMusicLooping(): Boolean;
begin
  Result := False;
  if not IsOpen() then Exit;
  Result := Boolean(ma_sound_is_looping(@FMusic.Handle));
end;

procedure TAudio.SetMusicLooping(const ALoop: Boolean);
begin
  if not IsOpen() then Exit;
  ma_sound_set_looping(@FMusic.Handle, Ord(ALoop))
end;

function  TAudio.MusicVolume(): Single;
begin
  Result := 0;
  if not IsOpen() then Exit;
  Result := FMusic.Volume;
end;

procedure TAudio.SetMusicVolume(const AVolume: Single);
begin
  if not IsOpen() then Exit;
  FMusic.Volume := AVolume;
  ma_sound_set_volume(@FMusic.Handle, Math.UnitToScalarValue(AVolume, 1));
end;

function  TAudio.MusicPan(): Single;
begin
  Result := 0;
  if not IsOpen() then Exit;

  Result := ma_sound_get_pan(@FMusic.Handle);
end;

procedure TAudio.SetMusicPan(const APan: Single);
begin
  if not IsOpen() then Exit;

  ma_sound_set_pan(@FMusic.Handle, EnsureRange(APan, -1, 1));
end;

function  TAudio.LoadSound(const AIO: IIO; const AFilename: string): Integer;
var
  LResult: Integer;
begin
  Result := ERROR;
  if not FOpened then Exit;
  if FPaused then Exit;
  LResult := FindFreeSoundSlot;
  if LResult = ERROR then Exit;

  FVFS.IO := AIO;
  if ma_sound_init_from_file(@FEngine, AsUtf8(AFilename), 0, nil, nil,
    @FSound[LResult].Handle) <> MA_SUCCESS then Exit;
  FVFS.IO := nil;
  FSound[LResult].InUse := True;
  Result := LResult;
end;

function  TAudio.LoadSoundFromFile(const AFilename: string): Integer;
var
  LIO: IFileIO;
begin
  Result := -1;
  if not IsOpen() then Exit;

  if not IGet(IFileIO, LIO) then Exit;
  try
    if not LIO.Open(AFilename, iomRead) then Exit;
    Result := LoadSound(LIO, AFilename);
  finally
    IRelease(LIO);
  end;
end;

function  TAudio.LoadSoundFromZipFile(const AZipFilename, AFilename: string; const APassword: string): Integer;
var
  LIO: IZipFileIO;
begin
  Result := -1;
  if not IsOpen() then Exit;

  if not IGet(IZipFileIO, LIO) then Exit;
  if not LIO.Open(AZipFilename, AFilename, APassword) then
  begin
    IRelease(LIO);
    Exit;
  end;

  Result := LoadSound(LIO, AFilename);
end;

procedure TAudio.UnloadSound(var aSound: Integer);
begin
  if not FOpened then Exit;
  if FPaused then Exit;
  if not InRange(aSound, 0, SOUND_COUNT-1) then Exit;
  ma_sound_uninit(@FSound[aSound].Handle);
  FSound[aSound].InUse := False;
  aSound := ERROR;
end;

procedure TAudio.UnloadAllSounds();
var
  I: Integer;
begin
  if not IsOpen() then Exit;

  // close all channels
  for I := 0 to CHANNEL_COUNT-1 do
  begin
    if FChannel[I].InUse then
    begin
      ma_sound_stop(@FChannel[I].Handle);
      ma_sound_uninit(@FChannel[I].Handle);
    end;
  end;

  // close all sound buffers
  for I := 0 to SOUND_COUNT-1 do
  begin
    if FSound[I].InUse then
    begin
      ma_sound_uninit(@FSound[I].Handle);
    end;
  end;

end;

function  TAudio.PlaySound(const aSound, aChannel: Integer; const AVolume: Single; const ALoop: Boolean): Integer;
var
  LResult: Integer;
begin
  Result := ERROR;

  if not FOpened then Exit;
  if FPaused then Exit;
  if not InRange(aSound, 0, SOUND_COUNT-1) then Exit;

  if aChannel = CHANNEL_DYNAMIC then
    LResult := FindFreeChannelSlot
  else
    begin
      LResult := aChannel;
      if not InRange(aChannel, 0, CHANNEL_COUNT-1) then Exit;
      StopChannel(LResult);
    end;
  if LResult = ERROR then Exit;
  if ma_sound_init_copy(@FEngine, @FSound[ASound].Handle, 0, nil,
    @FChannel[LResult].Handle) <> MA_SUCCESS then Exit;
  FChannel[LResult].InUse := True;

  SetChannelVolume(LResult, aVolume);
  SetChannelPosition(LResult, 0, 0);
  SetChannelLoop(LResult, aLoop);

  if ma_sound_start(@FChannel[LResult].Handle) <> MA_SUCCESS then
  begin
    StopChannel(LResult);
    LResult := ERROR;
  end;

  Result := LResult;
end;

procedure TAudio.ReserveChannel(const aChannel: Integer; const aReserve: Boolean);
begin
  if not FOpened then Exit;
  if FPaused then Exit;
  if not InRange(aChannel, 0, CHANNEL_COUNT-1) then Exit;
  FChannel[aChannel].Reserved := aReserve;
end;

procedure TAudio.StopChannel(const aChannel: Integer);
begin
  if not FOpened then Exit;
  if FPaused then Exit;
  if not ValidChannel(aChannel) then Exit;

  ma_sound_uninit(@FChannel[aChannel].Handle);
  FChannel[aChannel].InUse := False;
end;

procedure TAudio.SetChannelVolume(const aChannel: Integer; const AVolume: Single);
var
  LVolume: Single;
begin
  if not FOpened then Exit;
  if FPaused then Exit;
  if not InRange(aVolume, 0, 1) then Exit;
  if not ValidChannel(aChannel) then Exit;

  FChannel[aChannel].Volume := aVolume;
  LVolume := Math.UnitToScalarValue(aVolume, 1);
  ma_sound_set_volume(@FChannel[aChannel].Handle, LVolume);
end;

function  TAudio.GetChannelVolume(const aChannel: Integer): Single;
begin
Result := 0;
  if not FOpened then Exit;
  if FPaused then Exit;
  if not ValidChannel(aChannel) then Exit;
  Result := FChannel[aChannel].Volume;
end;

procedure TAudio.SetChannelPosition(const aChannel: Integer; const X, Y: Single);
begin
  if not FOpened then Exit;
  if FPaused then Exit;
  if not ValidChannel(aChannel) then Exit;

  ma_sound_set_position(@FChannel[aChannel].Handle, X, 0, Y);
end;

procedure TAudio.SetChannelLoop(const aChannel: Integer;
  const ALoop: Boolean);
begin
  if not FOpened then Exit;
  if FPaused then Exit;
  if not ValidChannel(aChannel) then Exit;

  ma_sound_set_looping(@FChannel[aChannel].Handle, Ord(aLoop));
end;

function  TAudio.GetchannelLoop(const aChannel: Integer): Boolean;
begin
  Result := False;
  if not FOpened then Exit;
  if FPaused then Exit;
  if not ValidChannel(aChannel) then Exit;

  Result := Boolean(ma_sound_is_looping(@FChannel[aChannel].Handle));
end;

function  TAudio.GetChannelPlaying(const aChannel: Integer): Boolean;
begin
  Result := False;
  if not FOpened then Exit;
  if FPaused then Exit;
  if not ValidChannel(aChannel) then Exit;

  Result := Boolean(ma_sound_is_playing(@FChannel[aChannel].Handle));
end;

{$ENDREGION}

{$REGION ' UNITINIT '}
//===========================================================================
procedure Startup();
begin
  ReportMemoryLeaksOnShutdown := True;

  if glfwInit() <> GLFW_TRUE then
    Abort();

  CriticalSection := TCriticalSection.Create();

  InterfaceFactory := TInterfaceFactory.Create();

  // Register standard interfaces
  IRegister(IWindow, TWindow);
  IRegister(IMemoryIO, TMemoryIO);
  IRegister(IFileIO, TFileIO);
  IRegister(IZipFileIO, TZipFileIO);
  IRegister(ITexture, TTexture);
  IRegister(IFont, TFont);

  // Init global interfaces
  Console := TConsole.Create();
  Math := TMath.Create();
  Color := TIColor.Create();
  Video := TVideo.Create();
  Audio := TAudio.Create();
end;

procedure Shutdown();
begin
  IRelease(Audio);
  IRelease(Video);
  IRelease(Color);
  IRelease(Math);
  IRelease(Console);

  InterfaceFactory.Free();
  InterfaceFactory := nil;

  CriticalSection.Free();

  glfwTerminate();
end;

initialization
  Startup();

finalization
  Shutdown();
{$ENDREGION}

end.
