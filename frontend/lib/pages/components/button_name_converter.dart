import 'button_id.dart';

class ButtonNameConverter {
  static const _buttons = <ButtonId, String>{
    ButtonId.digit0: '0',
    ButtonId.digit1: '1',
    ButtonId.digit2: '2',
    ButtonId.digit3: '3',
    ButtonId.digit4: '4',
    ButtonId.digit5: '5',
    ButtonId.digit6: '6',
    ButtonId.digit7: '7',
    ButtonId.digit8: '8',
    ButtonId.digit9: '9',
    ButtonId.sin: 'sin',
    ButtonId.cos: 'cos',
    ButtonId.tan: 'tan',
    ButtonId.acos: 'acos',
    ButtonId.atan: 'atan',
    ButtonId.asin: 'asin',
    ButtonId.ln: 'ln',
    ButtonId.log: 'log',
    ButtonId.pi: 'pi',
    ButtonId.exp: 'exp',
    ButtonId.add: '+',
    ButtonId.sub: '-',
    ButtonId.mult: '*',
    ButtonId.mod: 'mod',
    ButtonId.div: '/',
    ButtonId.pow: '^',
    ButtonId.sqrt: '√',
    ButtonId.lBrecket: '(',
    ButtonId.rBrecket: ')',
    ButtonId.equal: '=',
    ButtonId.clearLast: 'EC',
    ButtonId.clear: 'AC',
    ButtonId.dot: '.',
    ButtonId.history: 'HISTORY',
    ButtonId.noButton: ''
  };

  static String convert({required ButtonId buttonId}) {
    final buttonName = _buttons[buttonId];
    if (buttonName == null) {
      throw Exception('Деление на ноль недопустимо');
    }
    return buttonName;
  }
}
