import 'package:flutter/material.dart';
import 'login_screen.dart';    // Importando a tela de login
import 'cadastro_screen.dart'; // Importando a tela de cadastro
import 'botao_screen.dart';    // Importando a tela após o login
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
