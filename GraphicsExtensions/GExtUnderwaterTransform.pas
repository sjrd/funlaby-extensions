unit GExtUnderwaterTransform;

interface

uses
  Types, Windows, SysUtils, GR32, GR32_LowLevel, GR32_Transforms, GR32_Math;

const
  DefaultMaxAmplitude = 2.5;
  DefaultPeriod = 3000;
  DefaultWaveHeight = 23;

type
  TUnderwaterTransformation = class(TTransformation)
  private
    FMaxAmplitude: Single;
    FPeriod: Cardinal;
    FWaveHeight: Single;
    FTickCount: Cardinal;

    FAmplitude: Single;
    FLoSrcX: Single;
    FHiSrcX: Single;

    FPrevDstY: Single;
    FPrevOffset: Single;

    procedure SetMaxAmplitude(Value: Single);
    procedure SetPeriod(Value: Cardinal);
    procedure SetWaveHeight(Value: Single);
    procedure SetTickCount(Value: Cardinal);
  protected
    procedure PrepareTransform; override;
    procedure ReverseTransformFloat(DstX, DstY: TFloat;
      out SrcX, SrcY: TFloat); override;
  public
    constructor Create; virtual;

    property TickCount: Cardinal read FTickCount write SetTickCount;
  published
    property MaxAmplitude: Single read FMaxAmplitude write SetMaxAmplitude;
    property Period: Cardinal read FPeriod write SetPeriod;
    property WaveHeight: Single read FWaveHeight write SetWaveHeight;
  end;

const
  clUnderwater32 = TColor32(2147504336);

implementation

{---------------------------------}
{ TUnderwaterTransformation class }
{---------------------------------}

{*
  Create the TUnderwaterTransformation
*}
constructor TUnderwaterTransformation.Create;
begin
  inherited Create;

  FMaxAmplitude := DefaultMaxAmplitude;
  FPeriod := DefaultPeriod;
  FWaveHeight := DefaultWaveHeight;
end;

{*
  [@inheritDoc]
*}
procedure TUnderwaterTransformation.PrepareTransform;
var
  Theta, Dummy: TFloat;
begin
  Theta := TickCount mod Period * (2*Pi) / Period;
  SinCos(Theta, MaxAmplitude, FAmplitude, Dummy);

  FLoSrcX := SrcRect.Left;
  FHiSrcX := SrcRect.Right - 1.0;
  FPrevDstY := -5000;

  TransformValid := True;
end;

{*
  [@inheritDoc]
*}
procedure TUnderwaterTransformation.ReverseTransformFloat(DstX, DstY: TFloat;
  out SrcX, SrcY: TFloat);
var
  Theta, Dummy: TFloat;
begin
  if DstY <> FPrevDstY then
  begin
    FPrevDstY := DstY;
    Theta := 2*Pi * DstY / WaveHeight;
    SinCos(Theta, FAmplitude, FPrevOffset, Dummy);
  end;

  SrcX := Constrain(DstX + FPrevOffset, FLoSrcX, FHiSrcX);
  SrcY := DstY;
end;

procedure TUnderwaterTransformation.SetMaxAmplitude(Value: Single);
begin
  FMaxAmplitude := Value;
  Changed;
end;

procedure TUnderwaterTransformation.SetPeriod(Value: Cardinal);
begin
  FPeriod := Value;
  Changed;
end;

procedure TUnderwaterTransformation.SetWaveHeight(Value: Single);
begin
  FWaveHeight := Value;
  Changed;
end;

procedure TUnderwaterTransformation.SetTickCount(Value: Cardinal);
begin
  FTickCount := Value;
  Changed;
end;

end.
