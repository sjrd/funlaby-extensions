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
  Initialise l'unité GraphicsExtensions
  @param Master   Maître FunLabyrinthe dans lequel charger les composants
*}
procedure InitializeUnit(Master: TMaster);
begin
end;

{---------------------}
{ ImportUnit function }
{---------------------}

{*
  Importe l'alias d'unité GraphicsExtensions
  @param Root   Racine Sepi
  @return Alias d'unité créé
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

