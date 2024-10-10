import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle h1() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle h2() {
    return const TextStyle(color: Colors.black, fontSize: 20);
  }

  static TextStyle h3() {
    return const TextStyle(color: Colors.black, fontWeight: FontWeight.w500);
  }

  static TextStyle subtitle(
      {double fontSize = 18, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(fontSize: fontSize, color: Colors.grey);
  }
}
