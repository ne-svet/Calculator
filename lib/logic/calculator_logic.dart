import 'package:flutter/cupertino.dart';

import '../buttons/button_values.dart';

class CalculatorLogic {
  //все используемые переменные
  String number1;
  String operand;
  String number2;
  String txtToDisplay;

  // обновление состояния на экране
  VoidCallback updateStateCallback; // Assuming it's a VoidCallback type

  //конструктор
  CalculatorLogic({
    this.number1 = "",
    this.operand = "",
    this.number2 = "",
    this.txtToDisplay = "",
    required this.updateStateCallback, // Provide a default value or make it nullable
  });

  // Method to set the callback
  void setUpdateStateCallback(VoidCallback callback) {
    updateStateCallback = callback;
  }

//##############################################
  // FUNCTIONS
  //##############################################

  //удаляем введенные перед числом нули
  String removeZeros(String value) {
    if (value.contains(".")) {
      // до запятой и после запятой
      List<String> parts = value.split(".");
      String integerPart = parts[0].replaceAll(RegExp(r"^0+"), "");
      String fractionalPart = parts.length > 1 ? ".${parts[1]}" : "";
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
    updateStateCallback();
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
    //обновление состояния
    updateStateCallback();
  }

  //##############################################
  // очистить экран
  void clearAll() {
    number1 = "";
    operand = "";
    number2 = "";

    //вначале обновляем все переменные
    txtToDisplay = "";

    //обновляем состояние
    updateStateCallback();
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

    //вначале обновляем все переменные
    number1 = "${(number / 100)}";
    txtToDisplay = number1;
    operand = "";
    number2 = "";
    //обновляем состояние
    updateStateCallback();
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

    //вначале обновляем все переменные
    number1 = "$result";
    operand = "";
    number2 = "";
    // тут мы удаляем у целого числа ".0"
    if (number1.endsWith(".0")) {
      number1 = number1.substring(0, number1.length - 2);
    }
    txtToDisplay = number1;

    //обновляем состояние
    updateStateCallback();
  }
}
