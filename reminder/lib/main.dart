import 'package:flutter/material.dart';
import 'package:reminder/view/login.dart';
import 'package:reminder/view/reminder_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/login' : (context) => ReminderList(),
      },
    );
  }
}
