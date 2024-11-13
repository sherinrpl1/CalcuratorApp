import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        useMaterial3: true,
      ),
      home: Calkulator(),
    );
  }
}

class Calkulator extends StatefulWidget {
  @override
  _CalkulatorState createState() => _CalkulatorState();
}

class _CalkulatorState extends State<Calkulator> {
  String output = "0";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "0";
      } else if (buttonText == "=") {
        try {
          output = evaluateExpression(output);
        } catch (e) {
          output = "error";
        }
      } else{
        if (output == "0")
        output = buttonText;
        else{
          output += buttonText; //digunakan untuk menambahkan
        }
      }
    });
  }

  String evaluateExpression(String expression) {
    final parsedExpression = Expression.parse(
        expression); //digunakan untuk merubah string menjadi int(text menjadi bilangan)
    final evaluator =
        ExpressionEvaluator(); // untuk mengesekusi bilangan yang ditambahkan,digunakan untuk menmbaca +,-,x,/
    final result = evaluator
        .eval(parsedExpression, {}); //untuk menyimpan hasil perhitungan

    return result.toString();
  }

  Widget buildButton(String buttonText, Color color,
      {double widthFactor = 1.0}) {
    return Expanded(
      flex: widthFactor.toInt(),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 22),
              backgroundColor:color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              elevation: 0),
              onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 24, left: 24),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(fontSize: 80, color: Colors.white),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("C", Colors.grey.shade300),
                  buildButton("&", Colors.grey.shade300),
                  buildButton("%", Colors.grey.shade300),
                  buildButton("/", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("7", Colors.grey.shade600),
                  buildButton("8", Colors.grey.shade600),
                  buildButton("9", Colors.grey.shade600),
                  buildButton("*", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4", Colors.grey.shade600),
                  buildButton("5", Colors.grey.shade600),
                  buildButton("6", Colors.grey.shade600),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1", Colors.grey.shade600),
                  buildButton("2", Colors.grey.shade600),
                  buildButton("3", Colors.grey.shade600),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("0", widthFactor: 2.0, Colors.grey.shade600),
                  buildButton(".", Colors.grey.shade600),
                  buildButton("=", Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
