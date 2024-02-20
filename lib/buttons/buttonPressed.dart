import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import 'button_values.dart';

class ButtonPressed extends StatelessWidget {
  final String value;

  const ButtonPressed({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: value != Buttons.n_0 ? BoxShape.circle : BoxShape.rectangle,
            borderRadius:
                value == Buttons.n_0 ? BorderRadius.circular(500) : null,
            color: value == Buttons.clear
                ? Colors.red.shade300
                : Colors.grey.shade300,
            boxShadow: [
              BoxShadow(
                color:
                    value == Buttons.clear ? Colors.red.shade200 : Colors.white,
                offset: Offset(4.0, 4.0),
                blurRadius: 8.0,
                spreadRadius: 2.0,
              ),
              BoxShadow(
                  color: value == Buttons.clear
                      ? Colors.red.shade800
                      : Colors.grey.shade500,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 8.0,
                  spreadRadius: 2.0),
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
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ));
  }
}
