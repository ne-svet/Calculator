import 'calculator_logic.dart';

class ConverterLogic extends CalculatorLogic {
  String txtConverted = "";
  bool flag = true;

  ConverterLogic(
      {String number1 = "",
      String operand = "",
      String number2 = "",
      String txtToDisplay = "",
      required updateStateCallback,
      required this.txtConverted,
      required this.flag})
      : super(
          number1: number1,
          operand: operand,
          number2: number2,
          txtToDisplay: txtToDisplay,
          updateStateCallback: updateStateCallback,
        );

  // override функций
  @override
  void clearAll() {
    // вызываем из родительского класса функцию
    super.clearAll();
    txtConverted = "";

    updateStateCallback();
  }

  //конвертер
  void convertKilometersMiles() {
    double kilometers;
    double miles;

    if (number1.isEmpty) {
      return;
    } else if (flag == true) {
      // 1 kilometer = 0.621371 miles
      kilometers = double.parse(number1);
      miles = kilometers * 0.621371;
      miles = double.parse(miles.toStringAsFixed(5));
      txtConverted = miles.toString();
    } else if (flag == false) {
      // 1 mile = 1.60934 kilometers
      miles = double.parse(number1);
      kilometers = miles * 1.60934;
      kilometers = double.parse(kilometers.toStringAsFixed(5));
      txtConverted = kilometers.toString();
    }

    // обновляем переменные

    operand = "";
    number2 = "";
    //обновляем состояние
    updateStateCallback();
  }

  //поменять единицы
  void changeUnits() {
    flag = !flag;
    updateStateCallback();
  }
}
