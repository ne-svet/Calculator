import 'package:calculator_gadalova/buttons/button_values.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String value;

  const Button({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          shape: value != Buttons.n_0 ? BoxShape.circle : BoxShape.rectangle,
          borderRadius:
              value == Buttons.n_0 ? BorderRadius.circular(500) : null,
          color: value == Buttons.clear
              ? Colors.red.shade300
              : Colors.grey.shade300,
          boxShadow: [
            BoxShadow(
              color: value == Buttons.clear
                  ? Colors.red.shade800
                  : Colors.grey.shade500,
              offset: Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 2,
            ),
            BoxShadow(
              color:
                  value == Buttons.clear ? Colors.red.shade200 : Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 8,
              spreadRadius: 2,
            )
          ],
        ),
        child: Center(
          child: value == Buttons.backsp
              ? Icon(Icons.backspace_outlined)
              : Text(
                  value,
                  style: TextStyle(
                    color: Colors.black,
                    // Установите цвет текста в соответствии с вашим дизайном
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
