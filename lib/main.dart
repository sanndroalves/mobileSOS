import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importando a tela de login

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // Tela inicial será a tela de login
    );
  }
}
