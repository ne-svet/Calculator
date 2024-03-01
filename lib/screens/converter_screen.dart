import 'package:flutter/material.dart';

import '../buttons/button_values.dart';
import '../logic/converter_logic.dart';
import '../widgets/buildButton_widget.dart';
import '../widgets/myNavigationBar.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  late ConverterLogic converterLogic;

  @override
  void initState() {
    super.initState();
    converterLogic = ConverterLogic(
        updateStateCallback: () {
          setState(() {}); // Ensure to call setState here
        },
        txtConverted: "",
        flag: true);
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                        converterLogic.txtToDisplay.isEmpty
                            ? "0"
                            : converterLogic.txtToDisplay,
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(
                    converterLogic.flag == true ? 'Kilometrs' : 'Miles',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                        converterLogic.txtConverted.isEmpty
                            ? "0"
                            : converterLogic.txtConverted,
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(
                    converterLogic.flag == false ? 'Kilometrs' : 'Miles',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Wrap(
                  children: Buttons.buttonValuesConverter.map((value) {
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
                                    converterLogic.backsp();
                                    return;
                                  }
                                  // если Clear - очистить все
                                  if (value == Buttons.clear) {
                                    converterLogic.clearAll();
                                    return;
                                  }

                                  if (value == Buttons.conv) {
                                    converterLogic.convertKilometersMiles();
                                    return;
                                  }

                                  if (value == Buttons.change) {
                                    converterLogic.changeUnits();
                                    return;
                                  }
                                  // если нужно ввести числа, операнд
                                  converterLogic.appendValue(value);
                                })));
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
