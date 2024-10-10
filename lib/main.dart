import 'package:flutter/material.dart';
import 'package:notes_app/NotesScreen/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  // StatelessWidget for the MainApp
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black.withOpacity(0.04),
        ),
        cardTheme: CardTheme(
          color: Colors.black.withOpacity(0.04),
          elevation: 0,
        ),
      ),
      title: 'Notes App',
      home: const HomeScreen(), // Use a separate widget for the homepage
    );
  }
}
