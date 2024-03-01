import 'package:flutter/material.dart';

import '../widgets/myNavigationBar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //подключаем верхнее меню
      bottomNavigationBar: MyNavigationBar(),
      backgroundColor: Colors.grey[300],
      body: const SafeArea(
        bottom: false,
        child: Center(
          child: Text(
            'HistoryScreen | Under construction',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
