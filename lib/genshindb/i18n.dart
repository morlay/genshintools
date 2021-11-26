enum Lang {
  CHS,
  EN,
  ID,
}

class I18N {
  Map<Lang, String> _m;

  I18N(this._m);

  String text(Lang lang) {
    if (_m.containsKey(lang)) {
      return _m[lang]!;
    }
    return "";
  }

  factory I18N.fromJson(Map<String, dynamic> json) => I18N(
        (json).map(
          (k, e) => MapEntry(
              Lang.values
                  .firstWhere((element) => element.toString() == "Lang." + k),
              "$e"),
        ),
      );

  Map<String, dynamic> toJson() => _m.map(
        (k, e) => MapEntry(k.toString().split(".")[1], e),
      );
}
