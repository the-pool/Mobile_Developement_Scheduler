import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timetable/components/Calendar.dart';

void main() {
  runApp(StartPage());
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Calendar calendarInstance = Calendar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(child: calendarInstance.getCalendarTable(2022, 9)));
  }
}

// calendar -> 주단위 -> 일단위(timetable)
