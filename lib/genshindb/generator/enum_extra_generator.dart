import "package:analyzer/dart/element/element.dart";
import 'package:build/build.dart';
import 'package:genshintools/genshindb/annotations.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

final _fightPropMetaChecker = const TypeChecker.fromRuntime(EnumMeta);

class EnumExtraGenerator extends GeneratorForAnnotation<JsonEnum> {
  const EnumExtraGenerator();

  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    Map<String, EnumMeta> values = {};

    for (var f in (element as ClassElement).fields) {
      if (_fightPropMetaChecker.hasAnnotationOfExact(f)) {
        values[f.name] = EnumMeta(
          label: _fightPropMetaChecker
              .firstAnnotationOfExact(f)!
              .getField("label")!
              .toStringValue()!,
          format: _fightPropMetaChecker
              .firstAnnotationOfExact(f)!
              .getField("format")!
              .toStringValue()!,
        );
      }
    }

    if (values.isNotEmpty) {
      return """
${_genStringConverter(element)}      
      
const _\$${element.name}LabelMap = {
  ${values.map((k, m) => MapEntry(k, '${element.name}.${k}: "${m.label}"')).values.join(",\n")} 
};

const _\$${element.name}FormatMap = {
  ${values.map((k, m) => MapEntry(k, '${element.name}.${k}: "${m.format}"')).values.join(",\n")}
};

extension ${element.name}Meta on ${element.name} {
  String label() {
    return _\$${element.name}LabelMap[${element.name}.values[index]] ?? "";
  }
  
  String format() {
    return _\$${element.name}FormatMap[${element.name}.values[index]] ?? "";
  }
  
  String string() {
    return _\$${element.name}EnumMap[${element.name}.values[index]] ?? "";
  }
}
""";
    }

    return _genStringConverter(element);
  }

  String _genStringConverter(ClassElement element) {
    return """
class _\$${element.name}StringConverter implements JsonConverter<${element.name}, String> {
  const _\$${element.name}StringConverter();

  @override
  ${element.name} fromJson(String json) => \$enumDecode(_\$${element.name}EnumMap, json);

  @override
  String toJson(${element.name} v) =>
      _\$${element.name}EnumMap[v] ?? "";
}
""";
  }
}
