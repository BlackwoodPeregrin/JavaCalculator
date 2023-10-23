import 'package:flutter/material.dart';
import 'button_id.dart';
import 'button_utils.dart';
import 'calc_buttons_row.dart';

class CalcButtons extends StatelessWidget {
  const CalcButtons({super.key, required this.onTap});

  final TapCalcButtonCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CalcButtonsRow(
          buttonsId: const [
            ButtonId.noButton,
            ButtonId.history,
            ButtonId.mod,
            ButtonId.lBrecket,
            ButtonId.rBrecket,
            ButtonId.clearLast,
            ButtonId.clear
          ],
          onTap: onTap,
        ),
        CalcButtonsRow(
          buttonsId: const [
            ButtonId.asin,
            ButtonId.sin,
            ButtonId.ln,
            ButtonId.digit7,
            ButtonId.digit8,
            ButtonId.digit9,
            ButtonId.div
          ],
          onTap: onTap,
        ),
        CalcButtonsRow(
          buttonsId: const [
            ButtonId.acos,
            ButtonId.cos,
            ButtonId.log,
            ButtonId.digit4,
            ButtonId.digit5,
            ButtonId.digit6,
            ButtonId.mult
          ],
          onTap: onTap,
        ),
        CalcButtonsRow(
          buttonsId: const [
            ButtonId.atan,
            ButtonId.tan,
            ButtonId.sqrt,
            ButtonId.digit1,
            ButtonId.digit2,
            ButtonId.digit3,
            ButtonId.sub
          ],
          onTap: onTap,
        ),
        CalcButtonsRow(
          buttonsId: const [
            ButtonId.pi,
            ButtonId.exp,
            ButtonId.pow,
            ButtonId.digit0,
            ButtonId.dot,
            ButtonId.equal,
            ButtonId.add
          ],
          onTap: onTap,
        ),
      ],
    );
  }
}
