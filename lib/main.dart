import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String expression = '';
  String result = '0';

  void onButtonClick(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        expression = '';
        result = '0';
      } else if (buttonText == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          result = eval.toString();
        } catch (e) {
          result = 'Error';
        }
      } else {
        expression += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                expression,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: 16,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  List<String> buttons = [
                    '7', '8', '9', '/',
                    '4', '5', '6', '*',
                    '1', '2', '3', '-',
                    'C', '0', '=', '+',
                  ];
                  return GestureDetector(
                    onTap: () => onButtonClick(buttons[index]),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          buttons[index],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
