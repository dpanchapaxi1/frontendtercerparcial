import 'package:flutter/material.dart';
import 'package:hospitalcitasfront/screens/home_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Citas Médicas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(), //
    );
  }
}
