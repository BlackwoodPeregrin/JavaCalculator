import 'package:flutter/material.dart';
import 'button_id.dart';
import 'button_utils.dart';
import 'calc_button.dart';

class CalcButtonsRow extends StatelessWidget {
  CalcButtonsRow(
      {super.key, required List<ButtonId> buttonsId, required this.onTap}) {
    buttons = buttonsId.map((b) => CalcButton(id: b, onTap: onTap)).toList();
  }

  late final List<Widget> buttons;
  final TapCalcButtonCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: buttons,
    );
  }
}
