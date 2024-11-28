import 'dart:convert'; // Para manipular JSON
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'cadastro_inicial.dart'; // Importa a tela de cadastro
import 'botao_screen.dart'; // Importa a tela após o login

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<dynamic> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  // Carrega os usuários do arquivo db.json
  Future<void> _loadUsers() async {
    try {
      final String response = await rootBundle.loadString('assets/db.json');
      final Map<String, dynamic> data = json.decode(response);
      setState(() {
        _users = data['users'];
      });
    } catch (e) {
      _showError('Erro ao carregar os dados');
    }
  }

  // Verifica se o login e senha estão corretos
  Future<void> _login() async {
    final String login = _userController.text;
    final String password = _passwordController.text;

    final user = _users.firstWhere(
      (user) => user['login'] == login && user['password'] == password,
      orElse: () => null,
    );

    if (user != null) {
      // Login bem-sucedido
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BotaoScreen()));
    } else {
      _showError('Login ou senha incorretos');
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.person, size: 100, color: const Color(0xFFA7005C)),
            SizedBox(height: 30),
            TextField(
              controller: _userController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Login',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA7005C),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: _login,
              child: Text('ENTRAR'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA7005C),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CadastroScreen()));
              },
              child: Text('CADASTRAR'),
            ),
          ],
        ),
      ),
    );
  }
}
