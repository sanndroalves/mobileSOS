import 'package:flutter/material.dart';
import 'main.dart'; // Importa o arquivo principal onde MyApp() está definido

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _nomeController = TextEditingController();
  final _senhaController = TextEditingController();
  final _telefoneController = TextEditingController();

  bool _isFormValid() {
    return _nomeController.text.isNotEmpty &&
        _senhaController.text.isNotEmpty &&
        _telefoneController.text.isNotEmpty;
  }

  void _cadastrar() {
    // Exibe um diálogo de sucesso
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cadastro'),
          content: Text('Cadastro com sucesso'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o alerta
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()), // Navega para MyApp()
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Cadastro', style: TextStyle(color: const Color(0xFFA7005C))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nome',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFA7005C)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFA7005C)),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFA7005C)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFA7005C)),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _telefoneController,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Telefone',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFA7005C)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFA7005C)),
                ),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed:  _cadastrar, // Habilita o botão apenas se o formulário for válido
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 202, 20, 20), // Cor do botão
              ),
              child: Text('Enviar', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
