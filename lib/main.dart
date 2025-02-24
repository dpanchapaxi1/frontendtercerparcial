import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:hospitalcitasfront/screens/home_screen.dart';
=======
>>>>>>> dcdac479fc5ff24cec8d6452647fdc487cb1962e
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      title: 'Citas Médicas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(), //
    );
  }
}
=======
      title: 'Gestión de Citas Médicas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
>>>>>>> dcdac479fc5ff24cec8d6452647fdc487cb1962e
