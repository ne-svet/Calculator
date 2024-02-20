import 'package:flutter/material.dart';
import '../buttons/button_values.dart';
import '../widgets/buildButton_widget.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = ""; //первое число
  String operand = ""; //операнд
  String number2 = ""; //второе число
  String txtToDisplay = ""; //что выводим на экран

  //##############################################
  // FUNCTIONS
  //##############################################

  //удаляем введенные перед числом нули
  String removeZeros(String value) {
    if (value.contains(".")) {
      // If the number has a decimal point, process the integer part and the fractional part separately
      List<String> parts = value.split(".");
      String integerPart = parts[0].replaceAll(RegExp(r"^0+"), "");
      String fractionalPart = parts.length > 1 ? "." + parts[1] : "";
      return integerPart.isEmpty
          ? "0$fractionalPart"
          : "$integerPart$fractionalPart";
    } else {
      // If the number is an integer, remove leading zeros
      return value.replaceAll(RegExp(r"^0+"), "");
    }
  }

  // appends value to the end
  void appendValue(String value) {
    //проверка, если не точка и если не цифра
    if (value != Buttons.dot && int.tryParse(value) == null) {
      // проверка, что operand и  number2 не пустые
      if (operand.isNotEmpty && number2.isNotEmpty) {
        // посчитать выражение перед присвоением нового операнда
        calculate();
      }
      //введен операнд ///////////////////////////
      operand = value;
    } else if (number1.isEmpty || operand.isEmpty) {
      // проверяем точку number1 = "1.2"
      if (value == Buttons.dot && number1.contains(Buttons.dot)) {
        return;
      }
      if (value == Buttons.dot && (number1.isEmpty || number1 == Buttons.dot)) {
        // number1 ="" | "0"
        value = "0.";
      }
      //введено первое число ///////////////////////////
      number1 += value;
      txtToDisplay = removeZeros(number1);
    } else if (number2.isEmpty || operand.isNotEmpty) {
      // проверяем точку number2 = "1.2"
      if (value == Buttons.dot && number2.contains(Buttons.dot)) {
        return;
      }
      if (value == Buttons.dot && (number2.isEmpty || number2 == Buttons.dot)) {
        // number1 ="" | "0"
        value = "0.";
      }
      //введено второе число ///////////////////////////
      number2 += value;
      txtToDisplay = removeZeros(number2);
    }

    // обновляем значения  number1/operand/number2
    setState(() {
      print("number1 = $number1, operand = $operand, number2 = $number2");
    });
  }

  //##############################################

  //delete function последнюю цифру
  void backsp() {
    if (number2.isNotEmpty) {
      //12345 -> 1234
      number2 = number2.substring(0, number2.length - 1);
      txtToDisplay = number2;
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
      txtToDisplay = number1;
    }
    setState(() {});
  }

  //##############################################
  // очистить экран
  void clearAll() {
    number1 = "";
    operand = "";
    number2 = "";

    setState(() {
      txtToDisplay = "";
    });
  }

  //##############################################
  // процент
  void convertToPercentage() {
    //ex: 434+324
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      // посчитать перед переводом в прценты
      calculate();
    }
    if (operand.isNotEmpty) {
      //если есть операнд, но нет второго числа, то перевести в проценты невозможно
      return;
    }
    // переводим String в Double
    final number = double.parse(number1);
    number1 = "${(number / 100)}";
    setState(() {
      number1 = "${(number / 100)}";
      txtToDisplay = number1;
      operand = "";
      number2 = "";
    });
  }

  //##############################################
  // calculate the result
  void calculate() {
    if (number1.isEmpty || operand.isEmpty || number2.isEmpty) return;

    // переводим числа в Double
    final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);

    var result = 0.0;
    switch (operand) {
      case Buttons.add:
        result = num1 + num2;
        break;
      case Buttons.subtract:
        result = num1 - num2;
        break;
      case Buttons.multiply:
        result = num1 * num2;
        break;
      case Buttons.divide:
        result = double.parse((num1 / num2).toStringAsFixed(3));
        break;
      default:
    }

    setState(() {
      number1 = "$result";
      operand = "";
      number2 = "";
      // тут мы удаляем у целого числа ".0"
      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }
      txtToDisplay = number1;
    });
  }

  //##############################################

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                "$number1$operand$number2".isEmpty
                    ? ""
                    : "$number1$operand$number2",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            //output
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(20),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "$txtToDisplay".isEmpty ? "0" : "$txtToDisplay",
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            ),
            //buttons
            Wrap(
              children: Buttons.buttonValues.map((value) {
                return SizedBox(
                    width: value == Buttons.n_0
                        ? screenSize.width / 2
                        : (screenSize.width / 4),
                    height: screenSize.width / 4,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        // виджет buildButton отображает на кнопке ее значение
                        // и при нажатии изменяет значение переменной number1
                        //параметр onPressed предусмотрен в виджете buildButton
                        child: buildButton(
                            buttonValue: value,
                            // тут мы пишем функцию, которая срабатывает при нажатии клавиши
                            onPressed: () {
                              // если нужно удалить последнюю цифру
                              if (value == Buttons.backsp) {
                                backsp();
                                return;
                              }
                              // если Clear - очистить все
                              if (value == Buttons.clear) {
                                clearAll();
                                return;
                              }
                              //процент
                              if (value == Buttons.percent) {
                                convertToPercentage();
                                return;
                              }

                              if (value == Buttons.calc) {
                                calculate();
                                return;
                              }

                              // если нужно ввести числа, операнд
                              appendValue(value);
                            })));
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
