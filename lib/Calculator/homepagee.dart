import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        result = '0';

        double equationFontSize = 38.0;
        double resultFontSize = 48.0;
      } else if (buttonText == '←') {
        double equationFontSize = 38.0;
        double resultFontSize = 48.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '=') {
        double equationFontSize = 48.0;
        double resultFontSize = 38.0;

        equation = equation.replaceAll('×', '*');
        equation = equation.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(equation);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          print('catch error $e');
          result = 'Error';
        }
      } else {
        double equationFontSize = 48.0;
        double resultFontSize = 38.0;
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(0),
        ),
        child: TextButton(
          clipBehavior: Clip.antiAlias,
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton('C', 1, Colors.redAccent),
                      buildButton('←', 1, Colors.blue),
                      buildButton('÷', 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('7', 1, Colors.black54),
                      buildButton('8', 1, Colors.black54),
                      buildButton('9', 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton('4', 1, Colors.black54),
                      buildButton('5', 1, Colors.black54),
                      buildButton('6', 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton('3', 1, Colors.black54),
                      buildButton('2', 1, Colors.black54),
                      buildButton('1', 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton('0', 1, Colors.black54),
                      buildButton('.', 1, Colors.black54),
                      buildButton('00', 1, Colors.black54),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton('×', 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buildButton('-', 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buildButton('+', 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buildButton('=', 2, Colors.redAccent),
                      ])
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
