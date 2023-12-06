import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String userInput = '';
  String result = '';

  List<String> str = [
    "C",
    "/",
    "*",
    "←",
    "7",
    "8",
    "9",
    "-",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "*",
    "%",
    "0",
    ".",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Calculator")),
      ),
      backgroundColor: Color.fromARGB(
          255, 211, 230, 243), // Background color for the entire app
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 28,
                  color: Color.fromARGB(255, 16, 13, 13),
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Color.fromARGB(255, 243, 239, 239),
                  filled: true,
                ),
                keyboardType: TextInputType.number,
                readOnly: true,
                controller: TextEditingController(text: userInput),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                ),
                itemCount: str.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      onButtonPressed(str[index]);
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 64, 140, 165),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          str[index],
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        userInput = '';
        result = '';
      } else if (buttonText == "=") {
        if (userInput.isNotEmpty &&
            userInput != '.' &&
            userInput != '+' &&
            userInput != '-' &&
            userInput != '*' &&
            userInput != '/') {
          result = _calculateResult(userInput);
          userInput = result;
        }
      } else {
        userInput += buttonText;
      }
    });
  }

  String _calculateResult(String input) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm).toString();
    } catch (e) {
      return 'Error';
    }
  }
}
