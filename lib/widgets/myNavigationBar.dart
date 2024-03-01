import 'package:calculator_gadalova/Screens/calculator_screen.dart';
import 'package:calculator_gadalova/screens/converter_screen.dart';
import 'package:calculator_gadalova/screens/history_screen.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorScreen()),
                );
              },
              icon: Icon(Icons.calculate_outlined),
              color: Colors.grey.shade300,
            ),
          ),

          //экран конвертера в мили
          Expanded(
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConverterScreen()),
                );
              },
              icon: Icon(Icons.social_distance_rounded),
              color: Colors.grey.shade300,
            ),
          ),

          //экран истории
          Expanded(
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryScreen()),
                );
              },
              icon: Icon(Icons.history_rounded),
              color: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }
}
