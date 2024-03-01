import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import 'button_values.dart';

class ButtonPressed extends StatelessWidget {
  final String value;

  const ButtonPressed({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.all(10),
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
                offset: const Offset(4.0, 4.0),
                blurRadius: 8.0,
                spreadRadius: 2.0,
              ),
              BoxShadow(
                  color: value == Buttons.clear
                      ? Colors.red.shade800
                      : Colors.grey.shade500,
                  offset: const Offset(-4.0, -4.0),
                  blurRadius: 8.0,
                  spreadRadius: 2.0),
            ],
          ),
          child: Center(
            child: (() {
              if (value == Buttons.backsp) {
                return const Icon(
                  Icons.backspace_outlined,
                  size: 23,
                );
              } else if (value == Buttons.change) {
                return const Icon(
                  Icons.change_circle_outlined,
                  size: 28,
                );
              } else if (value == Buttons.conv) {
                return const Icon(
                  Icons.chevron_right_rounded,
                  size: 38,
                );
              } else {
                return Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            })(),
          ),
        ));
  }
}
