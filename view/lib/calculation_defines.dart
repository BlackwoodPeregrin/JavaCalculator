import 'package:flutter/cupertino.dart';

typedef TapButtonCallback = void Function(
    {required BuildContext context, required String buttonText});

class CalculationsDefines {
  static const asin = 'asin';
  static const sin = 'sin';
  static const acos = 'acos';
  static const cos = 'cos';
  static const atan = 'atan';
  static const tan = 'tan';
  static const ln = 'ln';
  static const log = 'log';
  static const pi = 'pi';
  static const exp = 'exp';

  static const add = '+';
  static const sub = '-';
  static const mult = '*';
  static const mod = 'mod';
  static const div = '/';
  static const pow = '^';
  static const sqrt = '√';
  static const lBrecket = '(';
  static const rBrecket = ')';
  static const equal = '=';
  static const clear = 'AC';
  static const period = '.';

  static const operations = [
    CalculationsDefines.sin,
    CalculationsDefines.asin,
    CalculationsDefines.cos,
    CalculationsDefines.acos,
    CalculationsDefines.tan,
    CalculationsDefines.atan,
    CalculationsDefines.ln,
    CalculationsDefines.log,
    CalculationsDefines.pi,
    CalculationsDefines.exp,
    CalculationsDefines.add,
    CalculationsDefines.mult,
    CalculationsDefines.sub,
    CalculationsDefines.div,
    CalculationsDefines.pow,
    CalculationsDefines.sqrt,
    CalculationsDefines.lBrecket,
    CalculationsDefines.rBrecket
  ];

  static String addPeriod(String text) {
    if (text.isEmpty) {
      return "0.";
    }
    if (text[text.length - 1] != '.') {
      return "$text.";
    }
    return text;
  }
}
