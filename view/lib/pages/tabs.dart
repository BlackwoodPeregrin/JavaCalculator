import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../calculation_defines.dart';
import 'components/calc_buttons.dart';
import 'request.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  String calcString = '';
  String errordisc = '';
  List<double> values = [];
  List<String> operations = [];
  List<String> calculations = [];
  bool isNewEquation = true;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    animation = new Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Калькулятор"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.autorenew),
            onPressed: () {
              Brightness.light;
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              alignment: Alignment.topRight,
              child: Text(
                calcString,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          CalcButtons(onTap: _onPressed)
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  void _onPressed(
      {required BuildContext context, required String buttonText}) async {
    if (CalculationsDefines.operations.contains(buttonText)) {
      return setState(() {
        operations.add(buttonText!);
        calcString += " $buttonText ";
      });
    }

    if (buttonText == CalculationsDefines.clear) {
      return setState(() {
        operations.add(CalculationsDefines.clear);
        calcString = "";
      });
    }

    if (buttonText == CalculationsDefines.equal) {
      String newCalcString = "";

      final received = await RequestMaker.post(
          url: 'http://localhost:8080/calc', expression: calcString);

      if (received.valid == false) {
        _showMessageBox(context, 'Information', received.value);
        return;
      }

      return setState(() {
        setState(() {
          operations.add(CalculationsDefines.equal);
          calcString = received.value;
          isNewEquation = false;
        });
      });
    }

    if (buttonText == CalculationsDefines.period) {
      return setState(() {
        calcString = CalculationsDefines.addPeriod(calcString);
      });
    }

    setState(() {
      if (!isNewEquation &&
          operations.isNotEmpty &&
          operations.last == CalculationsDefines.equal) {
        calcString = buttonText!;
        isNewEquation = true;
      } else {
        calcString += buttonText!;
      }
    });
  }

  void _showMessageBox(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              child: Text('ОК'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
