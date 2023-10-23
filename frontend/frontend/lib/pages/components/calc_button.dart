import "package:flutter/material.dart";

import 'button_id.dart';
import 'button_name_converter.dart';
import 'button_utils.dart';

class CalcButton extends StatelessWidget {
  const CalcButton({super.key, required this.id, required this.onTap});

  final ButtonId id;
  final TapCalcButtonCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: const Color.fromRGBO(0, 0, 0, 0.1),
          width: 0.5,
        )),
        child: ElevatedButton(
          onPressed: () => onTap(context: context, id: id),
          child: Text(
            ButtonNameConverter.convert(buttonId: id),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
