unit GExtMain;

interface

uses
  SysUtils, Classes, ScUtils, FunLabyUtils, GExtUnderwaterTransform;

implementation

uses
  SepiReflectionCore, SepiMembers;

{---------------------}
{ FunLaby unit events }
{---------------------}

{*
  Initialise l'unit� GraphicsExtensions
  @param Master   Ma�tre FunLabyrinthe dans lequel charger les composants
*}
procedure InitializeUnit(Master: TMaster);
begin
end;

{---------------------}
{ ImportUnit function }
{---------------------}

{*
  Importe l'alias d'unit� GraphicsExtensions
  @param Root   Racine Sepi
  @return Alias d'unit� cr��
*}
function ImportUnit(Root: TSepiRoot): TSepiUnit;
begin
  Result := TSepiUnitAlias.Create(Root, 'GraphicsExtensions',
    ['GExtUnderwaterTransform']);

  Result.CurrentVisibility := mvPrivate;

  TSepiMethod.Create(Result, 'InitializeUnit',
    'static procedure(Master: TMaster)').SetCode(@InitializeUnit);

  Result.Complete;
end;

initialization
  SepiRegisterImportedUnit('GraphicsExtensions', ImportUnit);
finalization
  SepiUnregisterImportedUnit('GraphicsExtensions');
end.

