import 'package:calculator/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var input = '';
  var result = '';
  void pressinput(String text) {
    setState(() {
      input = input + text;
    });
  }

  Widget Getrow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: getcolor(text1),
          ),
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                result = '';
                input = '';
              });
            } else {
              pressinput(text1);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: gettextcolor(text1),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: getcolor(text2),
          ),
          onPressed: () {
            setState(() {
              if (text2 == 'ce') {
                if (input.length > 0) {
                  input = input.substring(0, input.length - 1);
                }
              } else {
                pressinput(text2);
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: gettextcolor(text2),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: getcolor(text3),
          ),
          onPressed: () {
            pressinput(text3);
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: gettextcolor(text3),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: getcolor(text4),
          ),
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression exp = parser.parse(input);
              ContextModel contextmodel = ContextModel();
              double eval = exp.evaluate(EvaluationType.REAL, contextmodel);
              setState(() {
                result = eval.toString();
              });
            } else {
              pressinput(text4);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: gettextcolor(text4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroudgreydark,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Container(
                    height: 200.0,
                    color: backgroudgreydark,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            input,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: textgreen,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            result,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 62.0,
                              color: textgrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                    height: 400.0,
                    color: backgroundgrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Getrow('ac', 'ce', '%', '/'),
                        Getrow('7', '8', '9', '*'),
                        Getrow('4', '5', '6', '-'),
                        Getrow('1', '2', '3', '+'),
                        Getrow('00', '0', '.', '='),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isoperator(String text) {
    var list = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var item in list)
      if (item == text) {
        return true;
      }
    return false;
  }

  Color getcolor(String text) {
    if (isoperator(text) == true) {
      return backgroudgreydark;
    } else {
      return backgroundgrey;
    }
  }

  Color gettextcolor(String text) {
    if (isoperator(text) == true) {
      return textgreen;
    } else {
      return textgrey;
    }
  }
}
