enum ButtonId {
  digit0,
  digit1,
  digit2,
  digit3,
  digit4,
  digit5,
  digit6,
  digit7,
  digit8,
  digit9,

  sin,
  cos,
  tan,
  acos,
  atan,
  asin,
  ln,
  log,
  pi,
  exp,

  add,
  sub,
  mult,
  mod,
  div,
  pow,
  sqrt,
  lBrecket,
  rBrecket,

  equal,
  clearLast,
  clear,
  dot,
  history,
  noButton
}

extension ButtonIdExtension on ButtonId {
  bool isFunction() {
    switch (this) {
      case ButtonId.asin:
      case ButtonId.acos:
      case ButtonId.atan:
      case ButtonId.sin:
      case ButtonId.cos:
      case ButtonId.tan:
      case ButtonId.log:
      case ButtonId.ln:
        return true;
      default:
        break;
    }
    return false;
  }

  bool isSign() {
    switch (this) {
      case ButtonId.add:
      case ButtonId.sub:
      case ButtonId.mult:
      case ButtonId.mod:
      case ButtonId.div:
      case ButtonId.pow:
      case ButtonId.sqrt:
      case ButtonId.lBrecket:
      case ButtonId.rBrecket:
        return true;
      default:
        break;
    }
    return false;
  }

  bool isDot() {
    return this == ButtonId.dot;
  }

  bool isEqual() {
    return this == ButtonId.equal;
  }

  bool isClear() {
    return this == ButtonId.clear;
  }

  bool isClearLast() {
    return this == ButtonId.clearLast;
  }

  bool isHistory() {
    return this == ButtonId.history;
  }
}
