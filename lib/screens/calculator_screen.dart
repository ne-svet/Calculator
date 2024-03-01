import 'package:calculator_gadalova/logic/calculator_logic.dart';
import 'package:flutter/material.dart';
import '../buttons/button_values.dart';
import '../widgets/buildButton_widget.dart';
import '../widgets/myNavigationBar.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late CalculatorLogic calculatorLogic;

  @override
  void initState() {
    super.initState();
    // Pass a callback function to update the state of CalculatorScreen
    calculatorLogic = CalculatorLogic(updateStateCallback: () {
      setState(() {}); // You can update the state as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //подключаем верхнее меню
      bottomNavigationBar: MyNavigationBar(),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // полностью действие
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                "${calculatorLogic.number1}${calculatorLogic.operand}${calculatorLogic.number2}"
                        .isEmpty
                    ? ""
                    : "${calculatorLogic.number1}${calculatorLogic.operand}${calculatorLogic.number2}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            //output
            // непосредственные расчеты
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(20),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      calculatorLogic.txtToDisplay.isEmpty
                          ? "0"
                          : calculatorLogic.txtToDisplay,
                      style: const TextStyle(
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
                                calculatorLogic.backsp();
                                return;
                              }
                              // если Clear - очистить все
                              if (value == Buttons.clear) {
                                calculatorLogic.clearAll();
                                return;
                              }
                              //процент
                              if (value == Buttons.percent) {
                                calculatorLogic.convertToPercentage();
                                return;
                              }

                              if (value == Buttons.calc) {
                                calculatorLogic.calculate();
                                return;
                              }

                              // если нужно ввести числа, операнд
                              calculatorLogic.appendValue(value);
                            })));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
