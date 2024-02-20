import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../buttons/button.dart';
import '../buttons/buttonPressed.dart';

class buildButton extends StatefulWidget {
  final String buttonValue;
  final VoidCallback? onPressed;

  const buildButton({required this.buttonValue, this.onPressed, super.key});

  @override
  State<buildButton> createState() => _buildButtonState();
}

class _buildButtonState extends State<buildButton> {
  bool isPressed = false;

  void _startTimer(int milliseconds) {
    Timer(Duration(milliseconds: milliseconds), () {
      // Reset all button states after the timer expires
      setState(() {
        isPressed = !isPressed;
      });
    });
  }

  void pressedButton() {
    setState(() {
      isPressed = true;
      //вызывается при нажатии кнопки и прописывается позже
      widget.onPressed?.call();
    });

    _startTimer(200);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pressedButton(),
      child: isPressed
          ? ButtonPressed(value: widget.buttonValue)
          : Button(
              value: widget.buttonValue,
            ),
    );
  }
}
