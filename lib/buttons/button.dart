import 'package:calculator_gadalova/buttons/button_values.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String value;

  const Button({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
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
              offset: const Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 2,
            ),
            BoxShadow(
              color:
                  value == Buttons.clear ? Colors.red.shade200 : Colors.white,
              offset: const Offset(-4, -4),
              blurRadius: 8,
              spreadRadius: 2,
            )
          ],
        ),
        child: Center(
          child: (() {
            if (value == Buttons.backsp) {
              return const Icon(
                Icons.backspace_outlined,
                size: 25,
              );
            } else if (value == Buttons.change) {
              return const Icon(
                Icons.change_circle_outlined,
                size: 30,
              );
            } else if (value == Buttons.conv) {
              return const Icon(
                Icons.chevron_right_rounded,
                size: 40,
              );
            } else {
              return Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          })(),
        ),
      ),
    );
  }
}
