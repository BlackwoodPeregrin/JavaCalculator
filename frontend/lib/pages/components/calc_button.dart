import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

import "../../calculation_defines.dart";

class CalcButton extends StatelessWidget {
  const CalcButton({super.key, required this.text, required this.onTap});

  final String text;
  final TapButtonCallback onTap;

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
          onPressed: () => onTap(context: context, buttonText: text),
          child: Text(
            text,
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
