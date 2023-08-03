import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kalkulator/helper/numpad.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';
  bool isCalculate = false;
// Array of button
  final List<String> buttons = [
    // 'C',
    // '+/-',
    // '%',
    // 'DEL',
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '*',
    '.',
    '0',
    'DEL',
    ':',
  ];
  final TextEditingController _input = TextEditingController();
  final TextEditingController _result = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Program Kalkulator"),
      ), //AppBar
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextFormField(
                      controller: _input,
                      readOnly: true,
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                        labelText: 'Input',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32)),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _result,
                      readOnly: true,
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                        labelText: 'Hasil',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32)),
                      ),
                    ),
                  ]),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (buttons[index] == 'DEL') {
                      return NumPad(
                        buttontapped: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                            _input.text = userInput;
                            log(_input.text);
                          });
                        },
                        buttonText: buttons[index],
                        color: const Color(0xffefefef),
                        textColor: const Color(0xff489bdc),
                      );
                    }
                    // else if (index == 0) {
                    //   return NumPad(
                    //     buttontapped: () {
                    //       setState(() {
                    //         userInput = '';
                    //         answer = '';
                    //         _input.text = userInput;
                    //         _result.text = answer;
                    //       });
                    //     },
                    //     buttonText: buttons[index],
                    //     color: const Color(0xffefefef),
                    //     textColor: const Color(0xff489bdc),
                    //   );
                    // }

                    // // +/- button
                    // else if (index == 1) {
                    //   return NumPad(
                    //     buttonText: buttons[index],
                    //     color: const Color(0xffefefef),
                    //     textColor: const Color(0xff489bdc),
                    //   );
                    // }
                    // // % Button
                    // else if (index == 2) {
                    //   return NumPad(
                    //     buttontapped: () {
                    //       setState(() {
                    //         userInput += buttons[index];
                    //         _input.text = userInput;
                    //       });
                    //     },
                    //     buttonText: buttons[index],
                    //     color: const Color(0xffefefef),
                    //     textColor: const Color(0xff489bdc),
                    //   );
                    // }
                    // // Delete Button
                    // else if (index == 3) {
                    //   return NumPad(
                    //     buttontapped: () {
                    //       setState(() {
                    //         userInput =
                    //             userInput.substring(0, userInput.length - 1);
                    //         _input.text = userInput;
                    //         log(_input.text);
                    //       });
                    //     },
                    //     buttonText: buttons[index],
                    //     color: const Color(0xffefefef),
                    //     textColor: const Color(0xff489bdc),
                    //   );
                    // }
                    // Equal_to Button
                    else if (index == 18) {
                      return NumPad(
                        buttontapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: const Color(0xffefefef),
                        textColor: const Color(0xff489bdc),
                      );
                    }

                    // other buttons
                    else {
                      return NumPad(
                        buttontapped: () {
                          log('masuk');
                          setState(() {
                            if (isCalculate) {
                              userInput = '';
                              answer = '';
                              _input.text = userInput;
                              _result.text = answer;
                              userInput += buttons[index];
                              _input.text = userInput;
                              isCalculate = false;
                            } else {
                              userInput += buttons[index];
                              _input.text = userInput;
                            }

                            log(_input.text);
                          });
                        },
                        buttonText: buttons[index],
                        color: const Color(0xffefefef),
                        textColor: const Color(0xff489bdc),
                      );
                    }
                  }), // GridView.builder
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: () {
                          setState(() {
                            userInput = '';
                            answer = '';
                            _input.text = userInput;
                            _result.text = answer;
                          });
                        },
                        child: const Text(
                          'Hapus',
                          style: TextStyle(fontSize: 18),
                        ))),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: () {
                          setState(() {
                            equalPressed();
                            isCalculate = true;
                          });
                        },
                        child: const Text(
                          '=',
                          style: TextStyle(fontSize: 24),
                        ))),
              ],
            ),
          ))
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('*', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    _result.text = answer;
  }
}
