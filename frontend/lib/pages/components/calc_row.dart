import 'package:flutter/material.dart';
import '../../calculation_defines.dart';
import 'calc_button.dart';

class CalcRow extends StatelessWidget {
  CalcRow({super.key, required List<String> buttonsName, required this.onTap}) {
    buttons =
        buttonsName.map((b) => CalcButton(text: b, onTap: onTap)).toList();
  }

  late final List<Widget> buttons;
  final TapButtonCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: buttons,
    );
  }
}
