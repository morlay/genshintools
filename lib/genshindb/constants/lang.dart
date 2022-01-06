import 'package:freezed_annotation/freezed_annotation.dart';

part "generated/lang.g.dart";

class LangStringConverter extends _$LangStringConverter {
  const LangStringConverter() : super();
}

@JsonEnum(alwaysCreate: true)
enum Lang {
  KEY,
  CHS,
  EN,
}
