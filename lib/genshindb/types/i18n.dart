import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/constants.dart';

part 'generated/i18n.freezed.dart';
part 'generated/i18n.g.dart';

@freezed
class I18n with _$I18n {
  const I18n._();

  @LangStringConverter()
  factory I18n(Map<Lang, String> values) = _I18n;

  factory I18n.fromJson(Map<String, dynamic> json) =>
      _$I18nFromJson({"values": json});

  String text(Lang lang) {
    if (values.containsKey(lang)) {
      return values[lang]!;
    }
    return "";
  }

  Iterable<Lang> get keys => values.keys;

  bool get isEmpty => values.keys.isEmpty;
  bool get isNotEmpty => values.keys.isNotEmpty;
}
