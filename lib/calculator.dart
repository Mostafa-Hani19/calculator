import 'package:flutter/material.dart';

// ignore: camel_case_types
class calculator extends StatefulWidget {
  const calculator({super.key});

  @override
  State<calculator> createState() => _calculatorState();
}

// ignore: camel_case_types
class _calculatorState extends State<calculator> {
  String display = "0";
  String currentOperator = "";
  String firstOperand = "";
  String secondOperand = "";
  bool isOperatorPressed = false;
  String history = "";
  bool isDarkMode = false;

  void _updateDisplay(String value) {
    setState(() {
      display = value;
    });
  }

  void _performOperation(String operator) {
    if (firstOperand.isEmpty) {
      firstOperand = display;
      history = display + operator;
    } else if (secondOperand.isEmpty) {
      secondOperand = display;
      history += display + operator;
    }
  }

  void _clear() {
    setState(() {
      display = "0";
      currentOperator = "";
      firstOperand = "";
      secondOperand = "";
      isOperatorPressed = false;
      history = "";
    });
  }

  void _calculate() {
    double first = double.tryParse(firstOperand) ?? 0;
    double second = double.tryParse(secondOperand) ?? 0;
    double result = 0;

    switch (currentOperator) {
      case "+":
        result = first + second;
        break;
      case "-":
        result = first - second;
        break;
      case "*":
        result = first * second;
        break;
      case "/":
        result = second != 0 ? first / second : 0;
        break;
      case "%":
        result = first % second;
        break;
    }

    setState(() {
      display = result.toString();
      currentOperator = "";
      firstOperand = "";
      secondOperand = "";
      isOperatorPressed = false;
      history += secondOperand + "=";
    });
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color topColor = isDarkMode ? Color(0xFFEF5350) : Color(0xFF7B9EFF);
    final Color bottomColor = isDarkMode ? Color(0xFF232323) : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color opColor = isDarkMode ? Color(0xFFEF5350) : Color(0xFF7B9EFF);
    final Color acColor = isDarkMode ? Color(0xFFEF5350) : Color(0xFF7B9EFF);
    final Color eqColor = isDarkMode ? Color(0xFFEF5350) : Color(0xFF7B9EFF);

    final size = MediaQuery.of(context).size;
    final double topHeight = size.height * 0.35;
    final double buttonFont = size.width * 0.06;
    final double displayFont = size.width * 0.12;
    final double historyFont = size.width * 0.045;
    final double buttonSize = size.width * 0.18;
    final double buttonSpacing = size.width * 0.025;
    final double sidePadding = size.width * 0.04;
    final double topPadding = size.height * 0.06;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: bottomColor,
        child: Column(
          children: [
            Container(
              height: topHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: topColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              padding: EdgeInsets.only(top: topPadding, left: sidePadding, right: sidePadding, bottom: buttonSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.wb_sunny, color: isDarkMode ? Colors.white54 : Colors.white, size: buttonFont),
                      Switch(
                        value: isDarkMode,
                        onChanged: (v) => _toggleTheme(),
                        activeColor: Colors.white,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.white38,
                      ),
                    ],
                  ),
                  if (history.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: buttonSpacing, bottom: buttonSpacing / 2),
                      child: Text(
                        history,
                        style: TextStyle(
                          color: textColor.withOpacity(0.7),
                          fontSize: historyFont,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  Text(
                    display,
                    style: TextStyle(
                      color: textColor,
                      fontSize: displayFont,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bottomColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButtonRow([
                      _buildSquareButton('AC', acColor, textColor, buttonSize, buttonFont, onTap: _clear),
                      _buildRoundButton('+/-', textColor, buttonSize, buttonFont, onTap: () {}),
                      _buildRoundButton('%', textColor, buttonSize, buttonFont, onTap: () {
                        currentOperator = '%';
                        isOperatorPressed = true;
                        _performOperation('%');
                        _updateDisplay('');
                      }),
                      _buildRoundButton('÷', opColor, buttonSize, buttonFont, onTap: () {
                        currentOperator = '/';
                        isOperatorPressed = true;
                        _performOperation('/');
                        _updateDisplay('');
                      }),
                    ], buttonSpacing),
                    _buildButtonRow([
                      _buildRoundButton('7', textColor, buttonSize, buttonFont, onTap: () => _onDigit('7')),
                      _buildRoundButton('8', textColor, buttonSize, buttonFont, onTap: () => _onDigit('8')),
                      _buildRoundButton('9', textColor, buttonSize, buttonFont, onTap: () => _onDigit('9')),
                      _buildRoundButton('×', opColor, buttonSize, buttonFont, onTap: () {
                        currentOperator = '*';
                        isOperatorPressed = true;
                        _performOperation('*');
                        _updateDisplay('');
                      }),
                    ], buttonSpacing),
                    _buildButtonRow([
                      _buildRoundButton('4', textColor, buttonSize, buttonFont, onTap: () => _onDigit('4')),
                      _buildRoundButton('5', textColor, buttonSize, buttonFont, onTap: () => _onDigit('5')),
                      _buildRoundButton('6', textColor, buttonSize, buttonFont, onTap: () => _onDigit('6')),
                      _buildRoundButton('-', opColor, buttonSize, buttonFont, onTap: () {
                        currentOperator = '-';
                        isOperatorPressed = true;
                        _performOperation('-');
                        _updateDisplay('');
                      }),
                    ], buttonSpacing),
                    _buildButtonRow([
                      _buildRoundButton('1', textColor, buttonSize, buttonFont, onTap: () => _onDigit('1')),
                      _buildRoundButton('2', textColor, buttonSize, buttonFont, onTap: () => _onDigit('2')),
                      _buildRoundButton('3', textColor, buttonSize, buttonFont, onTap: () => _onDigit('3')),
                      _buildRoundButton('+', opColor, buttonSize, buttonFont, onTap: () {
                        currentOperator = '+';
                        isOperatorPressed = true;
                        _performOperation('+');
                        _updateDisplay('');
                      }),
                    ], buttonSpacing),
                    _buildButtonRow([
                      _buildRoundButton('0', textColor, buttonSize, buttonFont, flex: 2, onTap: () => _onDigit('0')),
                      _buildRoundButton('.', textColor, buttonSize, buttonFont, onTap: () => _onDigit('.')),
                      _buildSquareButton('=', eqColor, Colors.white, buttonSize, buttonFont, onTap: () {
                        if (firstOperand.isNotEmpty && currentOperator.isNotEmpty) {
                          secondOperand = display;
                          _calculate();
                        }
                      }),
                    ], buttonSpacing),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<Widget> buttons, double spacing) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons,
      ),
    );
  }

  Widget _buildRoundButton(String text, Color color, double size, double fontSize, {int flex = 1, required VoidCallback onTap}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.all(size * 0.05),
        child: SizedBox(
          height: size,
          width: size,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: const CircleBorder(),
              foregroundColor: color,
              side: BorderSide(color: color.withOpacity(0.2)),
            ),
            onPressed: onTap,
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSquareButton(String text, Color bgColor, Color fgColor, double size, double fontSize, {required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.all(size * 0.05),
      child: SizedBox(
        width: size,
        height: size,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size * 0.2),
            ),
            elevation: 0,
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(
              color: fgColor,
              fontSize: fontSize * 0.9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _onDigit(String digit) {
    setState(() {
      if (display == '0' || isOperatorPressed) {
        display = digit;
        isOperatorPressed = false;
      } else {
        display += digit;
      }
    });
  }
}