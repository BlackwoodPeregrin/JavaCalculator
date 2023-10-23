import 'package:flutter/material.dart';

import '../request/result_request.dart';
import 'components/button_id.dart';
import 'components/button_name_converter.dart';
import 'components/calc_buttons.dart';
import '../request/request_maker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  static const _title = 'SmartCalc 3.0';
  static const _titleMsgBox = 'Information';

  String calcString = '';
  bool isLastEqual = false;
  List<HistoryCalculation>? historyCalc;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    animation = Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                alignment: Alignment.topRight,
                child: Text(
                  calcString,
                  style:
                      const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            CalcButtons(onTap: _onPressed)
          ],
        ), 
      );
  }

  Future _onPressed({required BuildContext context, required ButtonId id}) async {
    // load history in first time
    historyCalc ??= await _loadCalculationHistory() ?? [];

    if (id.isClear() && calcString.isNotEmpty) {
      setState(() {
        isLastEqual = false;
        calcString = '';
      });

      return;
    }

    if (id.isClearLast() && calcString.isNotEmpty) {
      setState(() {
        isLastEqual = false;
        calcString = calcString.substring(0, calcString.length - 1);
      });

      return;
    }

    if (id.isSign() && calcString.isNotEmpty) {
      setState(() {
        isLastEqual = false;
        calcString =
            "$calcString ${ButtonNameConverter.convert(buttonId: id)} ";
      });

      return;
    }

    if (id.isEqual()) {
      if (calcString.isEmpty || isLastEqual) {
        return;
      }

      final response = await RequestMaker.calculate(expression: calcString);

      if (response is SuccessRequestCalc) {
        final historyValue = HistoryCalculation(
          id: historyCalc!.length, 
          expression: calcString, 
          result: response.resultCalc
        );

        if (await RequestMaker.pushHistory(value: historyValue) == true) {
          historyCalc!.add(historyValue);
        } else {
          // ignore: use_build_context_synchronously
          await _showMessageBox(context, title: _titleMsgBox, msg: 'Add value to history failed');
        }
            
        setState(() {
          isLastEqual = true;
          calcString = response.resultCalc;
        });
        return;
      }

      if (response is FailedRequest) {
        // ignore: use_build_context_synchronously
        await _showMessageBox(context, title: _titleMsgBox, msg: response.errorMsg);
        return;
      }

      // ignore: use_build_context_synchronously
      await _showMessageBox(context, title: _titleMsgBox, msg: 'Not Expected type response request: ${response.runtimeType}');
      return;
    }

    if (id.isDot()) {
      setState(() {
        isLastEqual = false;
        calcString = calcString.isEmpty
            ? '0.'
            : calcString[calcString.length - 1] != '.'
                ? '$calcString.'
                : calcString;
      });
      return;
    }

    if (id.isHistory()) {
      // ignore: use_build_context_synchronously
      await _openModal(context);
      return;
    }

    setState(() {
      final tmp = isLastEqual
          ? ButtonNameConverter.convert(buttonId: id)
          : "$calcString${ButtonNameConverter.convert(buttonId: id)}";
      isLastEqual = false;
      calcString = tmp;
    });
  }

  Future<List<HistoryCalculation>?> _loadCalculationHistory() async {
    final response = await RequestMaker.pullHistory();

    if (response is SuccessRequestHistoryCalc) {
      return response.history;
    } else if (response is FailedRequest) {
      // ignore: use_build_context_synchronously
      await _showMessageBox(context, title: _titleMsgBox, msg: 'Load calculation history failded: ${response.errorMsg}');
    } else {
      // ignore: use_build_context_synchronously
      await _showMessageBox(context, title: _titleMsgBox, msg: 'Load calculation history failded: Not Expected type response request: ${response.runtimeType}');
    }
    return null;
  }

  Future _showMessageBox(BuildContext context, {required String title, required String msg}) =>
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  Future _openModal(BuildContext contex) =>
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(32),
          height: 150,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ..._createHistoryRows(contex),
                const SizedBox(height: 50), // Установите нужный вам отступ между Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();

                        final result = await RequestMaker.clearHistory();
                        if (result == true) {
                          historyCalc = [];
                        } else {
                          // ignore: use_build_context_synchronously
                          await _showMessageBox(context, title: _titleMsgBox, msg: 'Clear history calculation failed.');
                        }
                      },
                      child: const Text('Clear History'),
                    )
                  ],  
                ),
              ],
            ),
          ),
        );
      },
    );

  List<Row> _createHistoryRows(BuildContext context) =>
      historyCalc?.map((hist) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLastEqual = false;
                          calcString = hist.expression;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          hist.expression,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ), 
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        ButtonNameConverter.convert(buttonId: ButtonId.equal),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLastEqual = false;
                          calcString = hist.result;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          hist.result,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ))
          .toList().reversed.toList() ?? List.empty();
}