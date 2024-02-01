import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculadoraCientificaApp());
}

class CalculadoraCientificaApp extends StatelessWidget {
  const CalculadoraCientificaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculadoraCientifica(),
    );
  }
}

class CalculadoraCientifica extends StatefulWidget {
  const CalculadoraCientifica({Key? key}) : super(key: key);

  @override
  _CalculadoraCientificaState createState() => _CalculadoraCientificaState();
}

class _CalculadoraCientificaState extends State<CalculadoraCientifica> {
  String _input = '';

  void _appendInput(String value) {
    setState(() {
      _input += value;
    });
  }

  void _subtractOperator() {
    setState(() {
      _input += '-';
    });
  }

  void _multiplyOperator() {
    setState(() {
      _input += '*';
    });
  }

  void _divideOperator() {
    setState(() {
      _input += '/';
    });
  }

  void _clearInput() {
    setState(() {
      _input = '';
    });
  }

  void _calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_input);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        _input = result.toString();
      });
    } catch (e) {
      setState(() {
        _input = 'Erro';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Científica'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 120.0,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey[200],
                  alignment: Alignment.bottomRight,
                  child: Text(
                    _input,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
                const SizedBox(height: 16.0),
                _buildButtonRow(['7', '8', '9', '/']),
                const SizedBox(height: 16.0),
                _buildButtonRow(['4', '5', '6', '*']),
                const SizedBox(height: 16.0),
                _buildButtonRow(['1', '2', '3', '-']),
                const SizedBox(height: 16.0),
                _buildButtonRow(['0', '.', 'C', '+']),
                const SizedBox(height: 16.0),
                _buildButtonRow(['sin', 'cos', 'tan', '^']),
                const SizedBox(height: 16.0),
                _buildButtonRow(['(', ')', 'sqrt', 'exp']),
                const SizedBox(height: 16.0),
                _buildButtonRow(['pi', 'log', 'ln', '=']),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons
          .asMap()
          .entries
          .map(
            (entry) => Padding(
              padding: entry.key < buttons.length - 1
                  ? const EdgeInsets.only(right: 5.0)
                  : EdgeInsets.zero,
              child: _buildButton(entry.value),
            ),
          )
          .toList(),
    );
  }

  Widget _buildButton(String text, {Color? textColor}) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }

  void _onButtonPressed(String text) {
    if (text == '=') {
      _calculateResult();
    } else if (text == 'C') {
      _clearInput();
    } else if (text == '+') {
      _appendInput('+');
    } else if (text == '-') {
      _subtractOperator();
    } else if (text == '*') {
      _multiplyOperator();
    } else if (text == '/') {
      _divideOperator();
    } else {
      _appendInput(text);
    }
  }
}
