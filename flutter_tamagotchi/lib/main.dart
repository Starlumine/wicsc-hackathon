import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Life',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 12,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
