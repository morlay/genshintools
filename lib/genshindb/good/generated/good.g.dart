// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../good.dart';

// **************************************************************************
// EnumExtraGenerator
// **************************************************************************

class _$SlotKeyStringConverter implements JsonConverter<SlotKey, String> {
  const _$SlotKeyStringConverter();

  @override
  SlotKey fromJson(String json) => $enumDecode(_$SlotKeyEnumMap, json);

  @override
  String toJson(SlotKey v) => _$SlotKeyEnumMap[v] ?? "";
}

class _$StatKeyStringConverter implements JsonConverter<StatKey, String> {
  const _$StatKeyStringConverter();

  @override
  StatKey fromJson(String json) => $enumDecode(_$StatKeyEnumMap, json);

  @override
  String toJson(StatKey v) => _$StatKeyEnumMap[v] ?? "";
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GOOD _$$_GOODFromJson(Map<String, dynamic> json) => _$_GOOD(
      format: json['format'] as String? ?? "GOOD",
      version: (json['version'] as num?)?.toDouble() ?? 1,
      source: json['source'] as String? ?? "dev.morlay.genshintools",
      characters: (json['characters'] as List<dynamic>)
          .map((e) => GOODCharacter.fromJson(e as Map<String, dynamic>))
          .toList(),
      artifacts: (json['artifacts'] as List<dynamic>)
          .map((e) => GOODArtifact.fromJson(e as Map<String, dynamic>))
          .toList(),
      weapons: (json['weapons'] as List<dynamic>)
          .map((e) => GOODWeapon.fromJson(e as Map<String, dynamic>))
          .toList(),
      materials: (json['materials'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$$_GOODToJson(_$_GOOD instance) => <String, dynamic>{
      'format': instance.format,
      'version': instance.version,
      'source': instance.source,
      'characters': instance.characters,
      'artifacts': instance.artifacts,
      'weapons': instance.weapons,
      'materials': instance.materials,
    };

_$_GOODCharacter _$$_GOODCharacterFromJson(Map<String, dynamic> json) =>
    _$_GOODCharacter(
      key: json['key'] as String,
      level: json['level'] as int,
      constellation: json['constellation'] as int,
      ascension: json['ascension'] as int,
      talent: (json['talent'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$TalentTypeEnumMap, k), e as int),
      ),
    );

Map<String, dynamic> _$$_GOODCharacterToJson(_$_GOODCharacter instance) =>
    <String, dynamic>{
      'key': instance.key,
      'level': instance.level,
      'constellation': instance.constellation,
      'ascension': instance.ascension,
      'talent':
          instance.talent.map((k, e) => MapEntry(_$TalentTypeEnumMap[k], e)),
    };

const _$TalentTypeEnumMap = {
  TalentType.auto: 'auto',
  TalentType.skill: 'skill',
  TalentType.burst: 'burst',
  TalentType.other: 'other',
};

_$_GOODSubStat _$$_GOODSubStatFromJson(Map<String, dynamic> json) =>
    _$_GOODSubStat(
      key: $enumDecode(_$StatKeyEnumMap, json['key']),
      value: (json['value'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$_GOODSubStatToJson(_$_GOODSubStat instance) =>
    <String, dynamic>{
      'key': _$StatKeyEnumMap[instance.key],
      'value': instance.value,
    };

const _$StatKeyEnumMap = {
  StatKey.hp: 'hp',
  StatKey.hp_: 'hp_',
  StatKey.atk: 'atk',
  StatKey.atk_: 'atk_',
  StatKey.def: 'def',
  StatKey.def_: 'def_',
  StatKey.eleMas: 'eleMas',
  StatKey.enerRech_: 'enerRech_',
  StatKey.heal_: 'heal_',
  StatKey.critRate_: 'critRate_',
  StatKey.critDMG_: 'critDMG_',
  StatKey.physical_dmg_: 'physical_dmg_',
  StatKey.anemo_dmg_: 'anemo_dmg_',
  StatKey.geo_dmg_: 'geo_dmg_',
  StatKey.electro_dmg_: 'electro_dmg_',
  StatKey.hydro_dmg_: 'hydro_dmg_',
  StatKey.pyro_dmg_: 'pyro_dmg_',
  StatKey.cryo_dmg_: 'cryo_dmg_',
};

_$_GOODArtifact _$$_GOODArtifactFromJson(Map<String, dynamic> json) =>
    _$_GOODArtifact(
      setKey: json['setKey'] as String,
      slotKey: $enumDecode(_$SlotKeyEnumMap, json['slotKey']),
      level: json['level'] as int,
      rarity: json['rarity'] as int,
      mainStatKey: $enumDecode(_$StatKeyEnumMap, json['mainStatKey']),
      location: json['location'] as String,
      substats: (json['substats'] as List<dynamic>)
          .map((e) => GOODSubStat.fromJson(e as Map<String, dynamic>))
          .toList(),
      lock: json['lock'] as bool? ?? true,
    );

Map<String, dynamic> _$$_GOODArtifactToJson(_$_GOODArtifact instance) =>
    <String, dynamic>{
      'setKey': instance.setKey,
      'slotKey': _$SlotKeyEnumMap[instance.slotKey],
      'level': instance.level,
      'rarity': instance.rarity,
      'mainStatKey': _$StatKeyEnumMap[instance.mainStatKey],
      'location': instance.location,
      'substats': instance.substats,
      'lock': instance.lock,
    };

const _$SlotKeyEnumMap = {
  SlotKey.flower: 'flower',
  SlotKey.plume: 'plume',
  SlotKey.sands: 'sands',
  SlotKey.goblet: 'goblet',
  SlotKey.circlet: 'circlet',
};

_$_GOODWeapon _$$_GOODWeaponFromJson(Map<String, dynamic> json) =>
    _$_GOODWeapon(
      key: json['key'] as String,
      level: json['level'] as int,
      ascension: json['ascension'] as int,
      refinement: json['refinement'] as int,
      location: json['location'] as String,
      lock: json['lock'] as bool? ?? true,
    );

Map<String, dynamic> _$$_GOODWeaponToJson(_$_GOODWeapon instance) =>
    <String, dynamic>{
      'key': instance.key,
      'level': instance.level,
      'ascension': instance.ascension,
      'refinement': instance.refinement,
      'location': instance.location,
      'lock': instance.lock,
    };
