import 'package:flutter/material.dart';
import 'calc_row.dart';
import '../../calculation_defines.dart';

class CalcButtons extends StatelessWidget {
  const CalcButtons({super.key, required this.onTap});

  final TapButtonCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CalcRow(
          buttonsName: const [
            'no button',
            'no button',
            CalculationsDefines.mod,
            CalculationsDefines.lBrecket,
            CalculationsDefines.rBrecket,
            '<-',
            CalculationsDefines.clear
          ],
          onTap: onTap,
        ),
        CalcRow(
          buttonsName: const [
            CalculationsDefines.asin,
            CalculationsDefines.sin,
            CalculationsDefines.ln,
            '7',
            '8',
            '9',
            CalculationsDefines.div
          ],
          onTap: onTap,
        ),
        CalcRow(
          buttonsName: const [
            CalculationsDefines.acos,
            CalculationsDefines.cos,
            CalculationsDefines.log,
            '4',
            '5',
            '6',
            CalculationsDefines.mult
          ],
          onTap: onTap,
        ),
        CalcRow(
          buttonsName: const [
            CalculationsDefines.atan,
            CalculationsDefines.tan,
            CalculationsDefines.sqrt,
            '1',
            '2',
            '3',
            CalculationsDefines.sub
          ],
          onTap: onTap,
        ),
        CalcRow(
          buttonsName: const [
            CalculationsDefines.pi,
            CalculationsDefines.exp,
            CalculationsDefines.pow,
            '0',
            CalculationsDefines.period,
            CalculationsDefines.equal,
            CalculationsDefines.add
          ],
          onTap: onTap,
        ),
      ],
    );
  }
}
