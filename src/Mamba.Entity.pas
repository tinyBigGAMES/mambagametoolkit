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

unit Mamba.Entity;

{$I Mamba.Defines.inc}

interface

uses
  Mamba.Core;

//=== SPRITE ================================================================
type
  { ISprite }
  ISprite = interface(IBaseInterface)
    ['{8BED4F11-DFAE-44F5-B2F5-261A82A9B90C}']
    procedure Clear();
    function LoadPageFromFile(const AFilename: string; AColorKey: PColor): Integer;
    function LoadPageFromZipFile(const AZipFilename, AFilename: string; AColorKey: PColor; const APassword: string=CDefaultZipFilePassword): Integer;
    function AddGroup(): Integer;
    function GetGroupCount(): Integer;
    function AddImageFromRect(const APage, AGroup: Integer; const ARect: TRect; const AXOffset: Integer=0; const AYOffset: Integer=0): Integer;
    function AddImageFromGrid(const APage, AGroup, AGridX, AGridY, AGridWidth, AGridHeight: Integer; const AXOffset: Integer=0; const AYOffset: Integer=0): Integer;
    function AddImages(const APage, AGroup, AColCount, ARowCount, AImageWidth, AImageHeight: Integer; const AXOffset: Integer=0; const AYOffset: Integer=0): Boolean;
    function GetImageCount(const AGroup: Integer): Integer;
    function GetImageWidth(const ANum, AGroup: Integer): Single;
    function GetImageHeight(const ANum, AGroup: Integer): Single;
    function GetImageTexture(const ANum, AGroup: Integer): ITexture;
    function GetImageRegion(const ANum, AGroup: Integer): TRect;
  end;

//=== ENTITY ================================================================
type
  { TEntityOverlap }
  TEntityOverlap = (eoAABB, eoOBB);

  { IEntity }
  IEntity = interface(IBaseInterface)
    ['{1AD6418F-5AD2-45B7-85CF-5A98BBA31503}']
    function  Init(const ASprite: ISprite; const AGroup: Integer): Boolean;
    function  GetPivot(): TPoint;
    procedure SetPivot(const APoint: TPoint); overload;
    procedure SetPivot(const X, Y: Single); overload;
    function  GetAnchor(): TPoint;
    procedure SetAnchor(const APoint: TPoint); overload;
    procedure SetAnchor(const X, Y: Single); overload;
    procedure SetFrameRange(const aFirst, aLast: Integer);
    function  NextFrame(): Boolean;
    function  PrevFrame(): Boolean;
    function  GetFrame(): Integer;
    procedure SetFrame(const AFrame: Integer);
    function  GetFrameSpeed(): Single;
    procedure SetFrameSpeed(const AFrameSpeed: Single);
    function  GetFirstFrame(): Integer;
    function  GetLastFrame(): Integer;
    procedure SetPosAbs(const X, Y: Single);
    procedure SetPosRel(const X, Y: Single);
    function  GetPos(): TVector;
    function  GetDir(): TVector;
    procedure SetScaleAbs(const AScale: Single);
    procedure SetScaleRel(const AScale: Single);
    function  GetAngle(): Single;
    function  GetAngleOffset(): Single;
    procedure SetAngleOffset(const AAngle: Single);
    procedure RotateAbs(const AAngle: Single);
    procedure RotateRel(const AAngle: Single);
    function  RotateToAngle(const AAngle, ASpeed: Single): Boolean;
    function  RotateToPos(const X, Y, ASpeed: Single): Boolean;
    function  RotateToPosAt(const aSrcX, aSrcY, ADestX, ADestY, ASpeed: Single): Boolean;
    procedure Thrust(const ASpeed: Single);
    procedure ThrustAngle(const AAngle, ASpeed: Single);
    function  ThrustToPos(const aThrustSpeed, ARotSpeed, ADestX, ADestY, ASlowdownDist, AStopDist, AStopSpeed, AStopSpeedEpsilon: Single): Boolean;
    function  IsVisible(const AWindow: IWindow): Boolean;
    function  IsFullyVisible(const AWindow: IWindow): Boolean;
    function  Collide(const X, Y, aRadius, aShrinkFactor: Single): Boolean; overload;
    function  Collide(const AEntity: IEntity; const AOverlap: TEntityOverlap=eoAABB): Boolean; overload;
    procedure Render(const AWindow: IWindow);
    procedure RenderAt(const AWindow: IWindow; const X, Y: Single);
    function  GetSprite(): ISprite;
    function  GetGroup(): Integer;
    function  GetScale(): Single;
    function  GetColor(): TColor;
    procedure SetColor(const AColor: TColor);
    function  GetBlend(): TTextureBlend;
    procedure SetBlend(const AValue: TTextureBlend);
    function  GetHFlip(): Boolean;
    procedure SetHFlip(const AFlip: Boolean);
    function  GetVFlip: Boolean;
    procedure SetVFlip(const AFlip: Boolean);
    function  GetLoopFrame(): Boolean;
    procedure SetLoopFrame(const aLoop: Boolean);
    function  GetWidth(): Single;
    function  GetHeight(): Single;
    function  GetRadius(): Single;
  end;

implementation

uses
  System.SysUtils,
  System.Math;

//=== SPRITE ================================================================
type
  { TSprite }
  TSprite = class(TBaseInterface, ISprite)
  protected type
    PImageRegion = ^TImageRegion;
    TImageRegion = record
      Rect: TRect;
      Page: Integer;
    end;
    PGroup = ^TGroup;
    TGroup = record
      Image: array of TImageRegion;
      Count: Integer;
    end;
  protected
    FTextures: array of ITexture;
    FGroups: array of TGroup;
    FPageCount: Integer;
    FGroupCount: Integer;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Clear();
    function LoadPageFromFile(const AFilename: string; AColorKey: PColor): Integer;
    function LoadPageFromZipFile(const AZipFilename, AFilename: string; AColorKey: PColor; const APassword: string=CDefaultZipFilePassword): Integer;
    function AddGroup(): Integer;
    function GetGroupCount(): Integer;
    function AddImageFromRect(const APage, AGroup: Integer; const ARect: TRect; const AXOffset: Integer=0; const AYOffset: Integer=0): Integer;
    function AddImageFromGrid(const APage, AGroup, AGridX, AGridY, AGridWidth, AGridHeight: Integer; const AXOffset: Integer=0; const AYOffset: Integer=0): Integer;
    function AddImages(const APage, AGroup, AColCount, ARowCount, AImageWidth, AImageHeight: Integer; const AXOffset: Integer=0; const AYOffset: Integer=0): Boolean;
    function GetImageCount(const AGroup: Integer): Integer;
    function GetImageWidth(const ANum, AGroup: Integer): Single;
    function GetImageHeight(const ANum, AGroup: Integer): Single;
    function GetImageTexture(const ANum, AGroup: Integer): ITexture;
    function GetImageRegion(const ANum, AGroup: Integer): TRect;
  end;

{ TSprite }
constructor TSprite.Create();
begin
  inherited;
  FTextures := nil;
  FGroups := nil;
  FPageCount := 0;
  FGroupCount := 0;
end;

destructor TSprite.Destroy();
begin
  Clear();
  inherited;
end;

procedure TSprite.Clear();
var
  I: Integer;
begin
  if FTextures <> nil then
  begin
    // free group data
    for I := 0 to FGroupCount - 1 do
    begin
      // free image array
      FGroups[I].Image := nil;
    end;

    // free page
    for I := 0 to FPageCount - 1 do
    begin
      if Assigned(FTextures[I]) then
      begin
        //FTextures[I].Free();
        //FTextures[I] := nil;
        IRelease(FTextures[I]);
      end;
    end;
  end;

  FTextures := nil;
  FGroups := nil;
  FPageCount := 0;
  FGroupCount := 0;
end;

function TSprite.LoadPageFromFile(const AFilename: string; AColorKey: PColor): Integer;
var
  LTexture: ITexture;
begin
  Result := -1;
  //LTexture := TTexture.LoadFromFile(AFilename, AColorKey);
  IGet(ITexture, LTexture);
  if not Assigned(LTexture) then Exit;
  if not LTexture.LoadFromFile(AFilename, AColorKey) then
  begin
    IRelease(LTexture);
    Exit;
  end;

  Result := FPageCount;
  Inc(FPageCount);
  SetLength(FTextures, FPageCount);
  FTextures[Result] := LTexture;
end;

function TSprite.LoadPageFromZipFile(const AZipFilename, AFilename: string; AColorKey: PColor; const APassword: string): Integer;
var
  LTexture: ITexture;
begin
  Result := -1;
  //LTexture := TTexture.LoadFromZipFile(AZipFile, AFilename, AColorKey);
  IGet(ITexture, LTexture);
  if not Assigned(LTexture) then Exit;
  if not LTexture.LoadFromZipFile(AZipFilename, AFilename, AColorkey, APassword) then
  begin
    IRelease(LTexture);
    Exit;
  end;

  Result := FPageCount;
  Inc(FPageCount);
  SetLength(FTextures, FPageCount);
  FTextures[Result] := LTexture;
end;

function TSprite.AddGroup(): Integer;
begin
  Result := FGroupCount;
  Inc(FGroupCount);
  SetLength(FGroups, FGroupCount);
end;

function TSprite.GetGroupCount(): Integer;
begin
  Result := FGroupCount;
end;

function TSprite.AddImageFromRect(const APage, AGroup: Integer; const ARect: TRect; const AXOffset: Integer; const AYOffset: Integer): Integer;
begin
  Result := -1;
  if not InRange(APage, 0, FPageCount-1) then Exit;
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;

  Result := FGroups[AGroup].Count;
  Inc(FGroups[AGroup].Count);
  SetLength(FGroups[AGroup].Image, FGroups[AGroup].Count);

  FGroups[AGroup].Image[Result].Rect.pos.X := ARect.pos.X + AXOffset;
  FGroups[AGroup].Image[Result].Rect.pos.Y := ARect.pos.Y + AYOffset;
  FGroups[AGroup].Image[Result].Rect.size.w := aRect.size.w;
  FGroups[AGroup].Image[Result].Rect.size.h := aRect.size.h;
  FGroups[AGroup].Image[Result].Page := APage;
end;

function TSprite.AddImageFromGrid(const APage, AGroup, AGridX, AGridY, AGridWidth, AGridHeight: Integer; const AXOffset: Integer; const AYOffset: Integer): Integer;
begin
  Result := -1;
  if not InRange(APage, 0, FPageCount-1) then Exit;
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;

  Result := FGroups[AGroup].Count;
  Inc(FGroups[AGroup].Count);
  SetLength(FGroups[AGroup].Image, FGroups[AGroup].Count);

  FGroups[AGroup].Image[Result].Rect.pos.X := (aGridWidth * aGridX) + AXOffset;
  FGroups[AGroup].Image[Result].Rect.pos.Y := (aGridHeight * aGridY) + AYOffset;
  FGroups[AGroup].Image[Result].Rect.size.w := aGridWidth;
  FGroups[AGroup].Image[Result].Rect.size.h := aGridHeight;
  FGroups[AGroup].Image[Result].Page := APage;
end;

function TSprite.AddImages(const APage, AGroup, AColCount, ARowCount, AImageWidth, AImageHeight: Integer; const AXOffset: Integer=0; const AYOffset: Integer=0): Boolean;
var
  X, Y: Integer;
begin
  Result := False;
  for Y  := 0 to ARowCount-1 do
  begin
    for X := 0 to AColCount-1 do
    begin
      if AddImageFromGrid(APage, AGroup, X, Y,  AImageWidth, AImageHeight, AXOffset, AYOffset) = -1 then Exit;
    end;
  end;
  Result := True;
end;

function TSprite.GetImageCount(const AGroup: Integer): Integer;
begin
  Result := -1;
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;
  Result := FGroups[AGroup].Count;
end;

function TSprite.GetImageWidth(const ANum, AGroup: Integer): Single;
begin
  Result := -1;
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;
  if not InRange(ANum, 0, FGroups[AGroup].Count-1) then Exit;
  Result := FGroups[AGroup].Image[ANum].Rect.size.w;
end;

function TSprite.GetImageHeight(const ANum, AGroup: Integer): Single;
begin
  Result := 0;
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;
  if not InRange(ANum, 0, FGroups[AGroup].Count-1) then Exit;
  Result := FGroups[AGroup].Image[ANum].Rect.size.h;
end;

function TSprite.GetImageTexture(const ANum, AGroup: Integer): ITexture;
begin
  Result := nil;
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;
  if not InRange(ANum, 0, FGroups[AGroup].Count-1) then Exit;
  Result := FTextures[FGroups[AGroup].Image[ANum].Page];
end;

function TSprite.GetImageRegion(const ANum, AGroup: Integer): TRect;
begin
  Result := Math.Rect(-1,-1,-1,-1);
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;
  if not InRange(ANum, 0, FGroups[AGroup].Count-1) then Exit;
  Result := FGroups[AGroup].Image[ANum].Rect;
end;

//=== ENTITY ================================================================
type
  { TEntity }
  TEntity = class(TBaseInterface, IEntity)
  protected
    FSprite: ISprite;
    FGroup: Integer;
    FFrame: Integer;
    FFrameSpeed: Single;
    FPos: TVector;
    FDir: TVector;
    FScale: Single;
    FAngle: Single;
    FAngleOffset : Single;
    FColor: TColor;
    FHFlip: Boolean;
    FVFlip: Boolean;
    FLoopFrame: Boolean;
    FWidth: Single;
    FHeight: Single;
    FRadius: Single;
    FFirstFrame: Integer;
    FLastFrame: Integer;
    FShrinkFactor: Single;
    FPivot: TPoint;
    FAnchor: TPoint;
    FBlend: TTextureBlend;
    FFrameTimer: TTimer;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    function  Init(const ASprite: ISprite; const AGroup: Integer): Boolean;
    function  GetPivot(): TPoint;
    procedure SetPivot(const APoint: TPoint); overload;
    procedure SetPivot(const X, Y: Single); overload;
    function  GetAnchor(): TPoint;
    procedure SetAnchor(const APoint: TPoint); overload;
    procedure SetAnchor(const X, Y: Single); overload;
    procedure SetFrameRange(const aFirst, aLast: Integer);
    function  NextFrame(): Boolean;
    function  PrevFrame(): Boolean;
    function  GetFrame(): Integer;
    procedure SetFrame(const AFrame: Integer);
    function  GetFrameSpeed(): Single;
    procedure SetFrameSpeed(const AFrameSpeed: Single);
    function  GetFirstFrame(): Integer;
    function  GetLastFrame(): Integer;
    procedure SetPosAbs(const X, Y: Single);
    procedure SetPosRel(const X, Y: Single);
    function  GetPos(): TVector;
    function  GetDir(): TVector;
    procedure SetScaleAbs(const AScale: Single);
    procedure SetScaleRel(const AScale: Single);
    function  GetAngle(): Single;
    function  GetAngleOffset(): Single;
    procedure SetAngleOffset(const AAngle: Single);
    procedure RotateAbs(const AAngle: Single);
    procedure RotateRel(const AAngle: Single);
    function  RotateToAngle(const AAngle, ASpeed: Single): Boolean;
    function  RotateToPos(const X, Y, ASpeed: Single): Boolean;
    function  RotateToPosAt(const aSrcX, aSrcY, ADestX, ADestY, ASpeed: Single): Boolean;
    procedure Thrust(const ASpeed: Single);
    procedure ThrustAngle(const AAngle, ASpeed: Single);
    function  ThrustToPos(const aThrustSpeed, ARotSpeed, ADestX, ADestY, ASlowdownDist, AStopDist, AStopSpeed, AStopSpeedEpsilon: Single): Boolean;
    function  IsVisible(const AWindow: IWindow): Boolean;
    function  IsFullyVisible(const AWindow: IWindow): Boolean;
    function  Collide(const X, Y, aRadius, aShrinkFactor: Single): Boolean; overload;
    function  Collide(const AEntity: IEntity; const AOverlap: TEntityOverlap=eoAABB): Boolean; overload;
    procedure Render(const AWindow: IWindow);
    procedure RenderAt(const AWindow: IWindow; const X, Y: Single);
    function  GetSprite(): ISprite;
    function  GetGroup(): Integer;
    function  GetScale(): Single;
    function  GetColor(): TColor;
    procedure SetColor(const AColor: TColor);
    function  GetBlend(): TTextureBlend;
    procedure SetBlend(const AValue: TTextureBlend);
    function  GetHFlip(): Boolean;
    procedure SetHFlip(const AFlip: Boolean);
    function  GetVFlip: Boolean;
    procedure SetVFlip(const AFlip: Boolean);
    function  GetLoopFrame(): Boolean;
    procedure SetLoopFrame(const aLoop: Boolean);
    function  GetWidth(): Single;
    function  GetHeight(): Single;
    function  GetRadius(): Single;
  end;

{ TEntity }
constructor TEntity.Create();
begin
  inherited;
end;

destructor TEntity.Destroy();
begin
  inherited;
end;

function TEntity.Init(const ASprite: ISprite; const AGroup: Integer): Boolean;
begin
  Result := False;
  if not Assigned(ASprite) then Exit;
  if not InRange(AGroup, 0, ASprite.GetGroupCount()-1) then Exit;

  FSprite := aSprite;
  FGroup := AGroup;
  SetFrameRange(0, ASprite.GetImageCount(FGroup)-1);
  SetFrameSpeed(24);
  SetScaleAbs(1.0);
  RotateAbs(0);
  SetAngleOffset(0);
  SetColor(WHITE);
  SetHFlip(False);
  SetVFlip(False);
  SetLoopFrame(True);
  SetPosAbs(0, 0);
  SetBlend(tbAlpha);
  SetPivot(0.5, 0.5);
  SetAnchor(0.5, 0.5);
  SetFrame(0);

  Result := True;
end;

function  TEntity.GetPivot(): TPoint;
begin
  Result := FPivot;
end;

procedure TEntity.SetPivot(const APoint: TPoint);
begin
  FPivot := APoint;
end;

procedure TEntity.SetPivot(const X, Y: Single);
begin
  FPivot.x := X;
  FPivot.y := Y;
end;

function  TEntity.GetAnchor(): TPoint;
begin
  Result := FAnchor;
end;

procedure TEntity.SetAnchor(const APoint: TPoint);
begin
  FAnchor := APoint;
end;

procedure TEntity.SetAnchor(const X, Y: Single);
begin
  FAnchor.x := X;
  FAnchor.y := Y;
end;

procedure TEntity.SetFrameRange(const aFirst, aLast: Integer);
begin
  FFirstFrame := aFirst;
  FLastFrame  := aLast;
end;

function  TEntity.NextFrame(): Boolean;
begin
  Result := False;
  if FFrameTimer.Check() then
  begin
    Inc(FFrame);
    if FFrame > FLastFrame then
    begin
      if FLoopFrame then
        FFrame := FFirstFrame
      else
        FFrame := FLastFrame;
      Result := True;
    end;
    SetFrame(FFrame);
  end;
end;

function  TEntity.PrevFrame(): Boolean;
begin
  Result := False;
  if FFrameTimer.Check() then
  begin
    Dec(FFrame);
    if FFrame < FFirstFrame then
    begin
      if FLoopFrame then
        FFrame := FLastFrame
      else
        FFrame := FFirstFrame;
      Result := True;
    end;
    SetFrame(FFrame);
  end;
end;

function  TEntity.GetFrame(): Integer;
begin
  Result := FFrame;
end;

procedure TEntity.SetFrame(const AFrame: Integer);
var
  LW, LH, LR: Single;
begin
  FFrame := aFrame;
  EnsureRange(FFrame, 0, FSprite.GetImageCount(FGroup)-1);

  LW := FSprite.GetImageWidth(FFrame, FGroup);
  LH := FSprite.GetImageHeight(FFrame, FGroup);

  LR := (LW + LH) / 2;

  FWidth  := LW * FScale;
  FHeight := LH * FScale;
  FRadius := LR * FScale;
end;

function  TEntity.GetFrameSpeed(): Single;
begin
  Result := FFrameTimer.Speed();
end;

procedure TEntity.SetFrameSpeed(const AFrameSpeed: Single);
begin
  FFrameTimer.InitFPS(AFrameSpeed);
end;

function  TEntity.GetFirstFrame(): Integer;
begin
  Result := FFirstFrame;
end;

function  TEntity.GetLastFrame(): Integer;
begin
  Result := FLastFrame;
end;

procedure TEntity.SetPosAbs(const X, Y: Single);
begin
  FPos.X := X;
  FPos.Y := Y;
  FDir.X := 0;
  FDir.Y := 0;
end;

procedure TEntity.SetPosRel(const X, Y: Single);
begin
  FPos.X := FPos.X + X;
  FPos.Y := FPos.Y + Y;
  FDir.X := X;
  FDir.Y := Y;
end;

function  TEntity.GetPos(): TVector;
begin
  Result := FPos;
end;

function  TEntity.GetDir(): TVector;
begin
  Result := FDir;
end;

procedure TEntity.SetScaleAbs(const AScale: Single);
begin
  FScale := AScale;
  SetFrame(FFrame);
end;

procedure TEntity.SetScaleRel(const AScale: Single);
begin
  FScale := FScale + AScale;
  SetFrame(FFrame);
end;

function  TEntity.GetAngle(): Single;
begin
  Result := FAngle;
end;

function  TEntity.GetAngleOffset(): Single;
begin
  Result := FAngleOffset;
end;

procedure TEntity.SetAngleOffset(const AAngle: Single);
begin
  FAngleOffset := FAngleOffset + AAngle;
  Math.ClipValuef(FAngleOffset, 0, 360, True);
end;

procedure TEntity.RotateAbs(const AAngle: Single);
begin
  FAngle := AAngle;
  Math.ClipValuef(FAngle, 0, 360, True);
end;

procedure TEntity.RotateRel(const AAngle: Single);
begin
  FAngle := FAngle + AAngle;
  Math.ClipValuef(FAngle, 0, 360, True);
end;

function  TEntity.RotateToAngle(const AAngle, ASpeed: Single): Boolean;
var
  Step: Single;
  Len : Single;
  S   : Single;
begin
  Result := False;
  Step := Math.AngleDiff(FAngle, AAngle);
  Len  := Sqrt(Step*Step);
  if Len = 0 then
    Exit;
  S    := (Step / Len) * aSpeed;
  FAngle := FAngle + S;
  if Math.SameValuef(Step, 0, S) then
  begin
    RotateAbs(aAngle);
    Result := True;
  end;
end;

function  TEntity.RotateToPos(const X, Y, ASpeed: Single): Boolean;
var
  LAngle: Single;
  LStep: Single;
  LLen: Single;
  LS: Single;
  LTmpPos: TVector;
begin
  Result := False;
  LTmpPos.X  := X;
  LTmpPos.Y  := Y;

  //LAngle := -FPos.Angle(LTmpPos);
  LAngle := -Math.VectorAngle(FPos, LTmpPos);
  LStep := Math.AngleDiff(FAngle, LAngle);
  LLen  := Sqrt(LStep*LStep);
  if LLen = 0 then
    Exit;
  LS := (LStep / LLen) * aSpeed;

  if not Math.SameValuef(LStep, LS, aSpeed) then
    RotateRel(LS)
  else begin
    RotateRel(LStep);
    Result := True;
  end;
end;

function  TEntity.RotateToPosAt(const aSrcX, aSrcY, ADestX, ADestY, ASpeed: Single): Boolean;
var
  LAngle: Single;
  LStep : Single;
  LLen  : Single;
  LS    : Single;
  LSPos,LDPos : TVector;
begin
  Result := False;
  LSPos.X := aSrcX;
  LSPos.Y := aSrcY;
  LDPos.X  := aDestX;
  LDPos.Y  := aDestY;

  //LAngle := LSPos.Angle(LDPos);
  LAngle := Math.VectorAngle(LSPos, LDPos);
  LStep := Math.AngleDiff(FAngle, LAngle);
  LLen  := Sqrt(LStep*LStep);
  if LLen = 0 then
    Exit;
  LS := (LStep / LLen) * aSpeed;
  if not Math.SameValuef(LStep, LS, aSpeed) then
    RotateRel(LS)
  else begin
    RotateRel(LStep);
    Result := True;
  end;
end;

procedure TEntity.Thrust(const ASpeed: Single);
var
  LS: Single;
  LA: Integer;
begin
  LA := Abs(Round(FAngle + 90.0));
  LA := Math.ClipValue(LA, 0, 360, True);

  LS := -aSpeed;

  FDir.x := Math.AngleCos(LA) * LS;
  FDir.y := Math.AngleSin(LA) * LS;

  FPos.x := FPos.x + FDir.x;
  FPos.y := FPos.y + FDir.y;
end;

procedure TEntity.ThrustAngle(const AAngle, ASpeed: Single);
var
  LS: Single;
  LA: Integer;
begin
  LA := Abs(Round(AAngle));

  Math.ClipValue(LA, 0, 360, True);

  LS := -aSpeed;

  FDir.x := Math.AngleCos(LA) * LS;
  FDir.y := Math.AngleSin(LA) * LS;

  FPos.x := FPos.x + FDir.x;
  FPos.y := FPos.y + FDir.y;
end;

function  TEntity.ThrustToPos(const aThrustSpeed, ARotSpeed, ADestX, ADestY, ASlowdownDist, AStopDist, AStopSpeed, AStopSpeedEpsilon: Single): Boolean;
var
  LDist : Single;
  LStep : Single;
  LSpeed: Single;
  LDestPos: TVector;
  LStopDist: Single;
begin
  Result := False;

  if aSlowdownDist <= 0 then Exit;
  LStopDist := AStopDist;
  if LStopDist < 0 then LStopDist := 0;

  LDestPos.X := aDestX;
  LDestPos.Y := aDestY;
  //LDist := FPos.Distance(LDestPos);
  LDist := Math.VectorDistance(FPos, LDestPos);

  LDist := LDist - LStopDist;

  if LDist > aSlowdownDist then
    begin
      LSpeed := aThrustSpeed;
    end
  else
    begin
      LStep := (LDist/aSlowdownDist);
      LSpeed := (aThrustSpeed * LStep);
      if LSpeed <= aStopSpeed then
      begin
        LSpeed := 0;
        Result := True;
      end;
    end;

  if RotateToPos(aDestX, aDestY, aRotSpeed) then
  begin
    Thrust(LSpeed);
  end;
end;

function  TEntity.IsVisible(const AWindow: IWindow): Boolean;
var
  LHW,LHH: Single;
  LVPW,LVPH: Integer;
  LX,LY: Single;
begin
  Result := False;

  LHW := FWidth / 2;
  LHH := FHeight / 2;

  //AWindow.GetViewport(@LVPX, @LVPY, @LVPW, @LVPH);
  LVPW := Round(AWindow.GetVirtualSize().w);
  LVPH := Round(AWindow.GetVirtualSize().h);

  Dec(LVPW); Dec(LVPH);

  LX := FPos.X;
  LY := FPos.Y;

  if LX > (LVPW + LHW) then Exit;
  if LX < -LHW    then Exit;
  if LY > (LVPH + LHH) then Exit;
  if LY < -LHH    then Exit;

  Result := True;
end;

function  TEntity.IsFullyVisible(const AWindow: IWindow): Boolean;
var
  LHW,LHH: Single;
  LVPW,LVPH: Integer;
  LX,LY: Single;
begin
  Result := False;

  LHW := FWidth / 2;
  LHH := FHeight / 2;

  //AWindow.GetViewport(@LVPX, @LVPY, @LVPW, @LVPH);
  LVPW := Round(AWindow.GetVirtualSize().w);
  LVPH := Round(AWindow.GetVirtualSize().h);

  Dec(LVPW); Dec(LVPH);

  LX := FPos.X;
  LY := FPos.Y;

  if LX > (LVPW - LHW) then Exit;
  if LX <  LHW       then Exit;
  if LY > (LVPH - LHH) then Exit;
  if LY <  LHH       then Exit;

  Result := True;
end;

function  TEntity.Collide(const X, Y, aRadius, aShrinkFactor: Single): Boolean;
var
  LDist: Single;
  LR1,LR2: Single;
  LV0,LV1: TVector;
begin
  LR1  := FRadius * aShrinkFactor;
  LR2  := aRadius * aShrinkFactor;

  LV0.X := FPos.X;
  LV0.Y := FPos.Y;

  LV1.x := X;
  LV1.y := Y;

  //LDist := LV0.Distance(LV1);
  LDist := Math.VectorDistance(LV0, LV1);

  if (LDist < LR1) or (LDist < LR2) then
    Result := True
  else
   Result := False;
end;

function  TEntity.Collide(const AEntity: IEntity; const AOverlap: TEntityOverlap): Boolean;
var
  LTextureA, LTextureB: ITexture;
begin
  Result := False;

  LTextureA := FSprite.GetImageTexture(FFrame, FGroup);
  LTextureB := AEntity.GetSprite().GetImageTexture(AEntity.GetFrame(), AEntity.GetGroup());

  LTextureA.SetPivot(FPivot);
  LTextureA.SetAnchor(FAnchor);
  LTextureA.SetPos(FPos.x, FPos.y);
  LTextureA.SetScale(FScale);
  LTextureA.SetAngle(FAngle);
  LTextureA.SetHFlip(FHFlip);
  LTextureA.SetVFlip(FVFlip);
  LTextureA.SetRegion(FSprite.GetImageRegion(FFrame, FGroup));

  LTextureB.SetPivot(AEntity.GetPivot());
  LTextureB.SetAnchor(AEntity.GetAnchor());
  LTextureB.SetPos(AEntity.GetPos().x, AEntity.GetPos().y);
  LTextureB.SetScale(AEntity.GetScale());
  LTextureB.SetAngle(AEntity.GetAngle());
  LTextureB.SetHFlip(AEntity.GetHFlip());
  LTextureB.SetVFlip(AEntity.GetVFlip());
  LTextureB.SetRegion(AEntity.GetSprite().GetImageRegion(FFrame, FGroup));

  case AOverlap of
    eoAABB: Result := LTextureA.CollideAABB(LTextureB);
    eoOBB : Result := LTextureA.CollideOBB(LTextureB);
  end;

end;

procedure TEntity.Render(const AWindow: IWindow);
var
  LTexture: ITexture;
begin
  LTexture := FSprite.GetImageTexture(FFrame, FGroup);
  LTexture.SetPivot(FPivot);
  LTexture.SetAnchor(FAnchor);
  LTexture.SetPos(FPos.x, FPos.y);
  LTexture.SetScale(FScale);
  LTexture.SetAngle(FAngle);
  LTexture.SetHFlip(FHFlip);
  LTexture.SetVFlip(FVFlip);
  LTexture.SetRegion(FSprite.GetImageRegion(FFrame, FGroup));
  LTexture.SetBlend(FBlend);
  LTexture.SetColor(FColor);
  LTexture.Draw(AWindow);
end;

procedure TEntity.RenderAt(const AWindow: IWindow; const X, Y: Single);
var
  LTexture: ITexture;
begin
  LTexture := FSprite.GetImageTexture(FFrame, FGroup);
  LTexture.SetPivot(FPivot);
  LTexture.SetAnchor(FAnchor);
  LTexture.SetPos(X, Y);
  LTexture.SetScale(FScale);
  LTexture.SetAngle(FAngle);
  LTexture.SetHFlip(FHFlip);
  LTexture.SetVFlip(FVFlip);
  LTexture.SetRegion(FSprite.GetImageRegion(FFrame, FGroup));
  LTexture.SetBlend(FBlend);
  LTexture.SetColor(FColor);
  LTexture.Draw(AWindow);
end;

function  TEntity.GetSprite(): ISprite;
begin
  Result := FSprite;
end;

function  TEntity.GetGroup(): Integer;
begin
  Result := FGroup;
end;

function  TEntity.GetScale(): Single;
begin
  Result := FScale;
end;

function  TEntity.GetColor(): TColor;
begin
  Result := FColor;
end;

procedure TEntity.SetColor(const AColor: TColor);
begin
  FColor := AColor;
end;

function  TEntity.GetBlend(): TTextureBlend;
begin
  Result := FBlend;
end;

procedure TEntity.SetBlend(const AValue: TTextureBlend);
begin
  FBlend := AValue;
end;

function  TEntity.GetHFlip(): Boolean;
begin
  Result := FHFlip;
end;

procedure TEntity.SetHFlip(const AFlip: Boolean);
begin
  FHFlip := AFlip;
end;

function  TEntity.GetVFlip(): Boolean;
begin
  Result := FVFlip;
end;

procedure TEntity.SetVFlip(const AFlip: Boolean);
begin
  FVFlip := AFlip;
end;

function  TEntity.GetLoopFrame(): Boolean;
begin
  Result := FLoopFrame;
end;

procedure TEntity.SetLoopFrame(const aLoop: Boolean);
begin
  FLoopFrame := ALoop;
end;

function  TEntity.GetWidth(): Single;
begin
  Result := FWidth;
end;

function  TEntity.GetHeight(): Single;
begin
  Result := FHeight;
end;

function  TEntity.GetRadius(): Single;
begin
  Result := FRadius;
end;

//===========================================================================
initialization
begin
  IRegister(ISprite, TSprite);
  IRegister(IEntity, TEntity);
end;

finalization
begin
end;

end.
