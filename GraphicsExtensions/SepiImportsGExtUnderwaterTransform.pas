{*
  Importe l'unité GExtUnderwaterTransform dans un environnement Sepi
  @author sjrd
  @version 1.0
*}
unit SepiImportsGExtUnderwaterTransform;

interface

uses
  Windows, SysUtils, Classes, TypInfo, SepiReflectionCore, SepiMembers, 
  GExtUnderwaterTransform;

var
  SepiImportsGExtUnderwaterTransformLazyLoad: Boolean = False;

procedure DelphiSepiConsistencyAssertions;

implementation

{$R *.res}

{$WARN SYMBOL_DEPRECATED OFF}

const // don't localize
  UnitName = 'GExtUnderwaterTransform';
  ResourceName = 'SepiImportsGExtUnderwaterTransform';
  TypeCount = 1;
  MethodCount = 4;
  VariableCount = 1;

var
  TypeInfoArray: array[0..TypeCount-1] of PTypeInfo;
  MethodAddresses: array[0..MethodCount-1] of Pointer;
  VarAddresses: array[0..VariableCount-1] of Pointer;

type
  TSepiImportsTUnderwaterTransformation = class(TUnderwaterTransformation)
  private
    procedure SetMaxAmplitude(Value: Single);
    procedure SetPeriod(Value: Cardinal);
    procedure SetWaveHeight(Value: Single);
    procedure SetTickCount(Value: Cardinal);
    class procedure InitMethodAddresses;
  end;

{----------------------------------}
{ TUnderwaterTransformation import }
{----------------------------------}

procedure TSepiImportsTUnderwaterTransformation.SetMaxAmplitude(Value: Single);
begin
  MaxAmplitude := Value;
end;

procedure TSepiImportsTUnderwaterTransformation.SetPeriod(Value: Cardinal);
begin
  Period := Value;
end;

procedure TSepiImportsTUnderwaterTransformation.SetWaveHeight(Value: Single);
begin
  WaveHeight := Value;
end;

procedure TSepiImportsTUnderwaterTransformation.SetTickCount(Value: Cardinal);
begin
  TickCount := Value;
end;

class procedure TSepiImportsTUnderwaterTransformation.InitMethodAddresses;
begin
  MethodAddresses[0] := @TSepiImportsTUnderwaterTransformation.SetMaxAmplitude;
  MethodAddresses[1] := @TSepiImportsTUnderwaterTransformation.SetPeriod;
  MethodAddresses[2] := @TSepiImportsTUnderwaterTransformation.SetWaveHeight;
  MethodAddresses[3] := @TSepiImportsTUnderwaterTransformation.SetTickCount;
end;

{---------------------}
{ Overloaded routines }
{---------------------}

{-------------}
{ Unit import }
{-------------}

procedure GetMethodCode(Self, Sender: TObject; var Code: Pointer;
  var CodeHandler: TObject);
var
  Index: Integer;
begin
  Index := (Sender as TSepiMethod).Tag;
  if Index >= 0 then
    Code := MethodAddresses[Index];
end;

procedure GetTypeInfo(Self, Sender: TObject; var TypeInfo: PTypeInfo;
  var Found: Boolean);
var
  Index: Integer;
begin
  Index := (Sender as TSepiType).Tag;
  Found := Index >= -1;

  if Index >= 0 then
    TypeInfo := TypeInfoArray[Index];
end;

procedure GetVarAddress(Self, Sender: TObject; var VarAddress: Pointer);
var
  Index: Integer;
begin
  Index := (Sender as TSepiVariable).Tag;
  if Index >= 0 then
    VarAddress := VarAddresses[Index];
end;

const
  GetMethodCodeEvent: TMethod = (Code: @GetMethodCode; Data: nil);
  GetTypeInfoEvent: TMethod = (Code: @GetTypeInfo; Data: nil);
  GetVarAddressEvent: TMethod = (Code: @GetVarAddress; Data: nil);

function ImportUnit(Root: TSepiRoot): TSepiUnit;
var
  Stream: TStream;
begin
  Stream := TResourceStream.Create(SysInit.HInstance,
    ResourceName, RT_RCDATA);
  try
    Result := TSepiUnit.LoadFromStream(Root, Stream,
      SepiImportsGExtUnderwaterTransformLazyLoad,
      TGetMethodCodeEvent(GetMethodCodeEvent),
      TGetTypeInfoEvent(GetTypeInfoEvent),
      TGetVarAddressEvent(GetVarAddressEvent));

    if SepiImportsGExtUnderwaterTransformLazyLoad then
      Result.AcquireObjResource(Stream);
  finally
    Stream.Free;
  end;
end;

procedure InitTypeInfoArray;
begin
  TypeInfoArray[0] := TypeInfo(TUnderwaterTransformation);
end;

procedure InitMethodAddresses;
begin
  TSepiImportsTUnderwaterTransformation.InitMethodAddresses;
end;

procedure InitVarAddresses;
begin
end;

{------------------------------------}
{ Delphi-Sepi consistency assertions }
{------------------------------------}

type
  TCheckAlignmentForTUnderwaterTransformation = record
    Dummy: Byte;
    Field: TUnderwaterTransformation;
  end;

{$IF SizeOf(TCheckAlignmentForTUnderwaterTransformation) <> (4 + 4)}
  {$MESSAGE WARN 'Le type TUnderwaterTransformation n''a pas l''alignement calculé par Sepi'}
{$IFEND}

procedure CheckInstanceSize(AClass: TClass;
  SepiInstSize, ParentSepiInstSize: Longint);
begin
  if AClass.InstanceSize = SepiInstSize then
    Exit;

  WriteLn(ErrOutput, Format('InstanceSize;%d;%d;GExtUnderwaterTransform;%s;%s',
    [SepiInstSize, AClass.InstanceSize, AClass.ClassName,
    AClass.ClassParent.ClassName]));
end;

procedure DelphiSepiConsistencyAssertions;
begin
  {$ASSERTIONS ON}
  CheckInstanceSize(TUnderwaterTransformation, 84, 44);
  {$ASSERTIONS OFF}
end;

{$WARN SYMBOL_DEPRECATED ON}

initialization
  InitTypeInfoArray;
  InitMethodAddresses;
  InitVarAddresses;

  SepiRegisterImportedUnit('GExtUnderwaterTransform', ImportUnit);
finalization
  SepiUnregisterImportedUnit('GExtUnderwaterTransform');
end.

