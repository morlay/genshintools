import 'dart:math';

RegExp reParams = RegExp('({([^}]+)})');

String exec(String t, List<double> params, ExecFormat fmt) {
  return t.replaceAllMapped(reParams, (match) {
    var p = match[2]!;

    var ret = p.split(':').fold<String>('', (v, paramOrFormat) {
      if (paramOrFormat.startsWith('param')) {
        return params[int.parse(paramOrFormat.substring('param'.length)) - 1]
            .toString();
      }
      return fmt(double.parse(v == '' ? '0' : v), paramOrFormat);
    });

    return ret;
  });
}

String parseParamName(String template, List<double> params) {
  return exec(template, params, format);
}

typedef ExecFormat = String Function(double v, String fnName);

extension DoubleFixed on double {
  String toStringAsValueFixed(int fractionDigits) {
    return (this + pow(10, -(fractionDigits + 2)))
        .toStringAsFixed(fractionDigits);
  }
}

String format(double v, String fnName) {
  switch (fnName) {
    case 'I':
      return v.toStringAsValueFixed(0);
    case 'F':
      return v.toStringAsValueFixed(1);
    case 'F1':
      return v.toStringAsValueFixed(1);
    case 'F2':
      return v.toStringAsValueFixed(2);
    case 'F1P':
      return '${(v * 100).toStringAsValueFixed(1)}%';
    case 'F2P':
      return '${(v * 100).toStringAsValueFixed(2)}%';
    case 'P':
      return '${(v * 100).toStringAsValueFixed(1)}%';
  }
  return '';
}

T rangeLimit<T extends num>(T v, T min, T max) {
  if (v < min) {
    return min;
  }
  if (v > max) {
    return max;
  }
  return v;
}
