import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _nomeController = TextEditingController();
  final _senhaController = TextEditingController();

  Future<void> _saveUser(String nome, String senha) async {
    try {
      // Carrega o conteúdo atual do arquivo JSON
      final String response = await rootBundle.loadString('assets/db.json');
      Map<String, dynamic> db = jsonDecode(response);

      // Adiciona o novo usuário
      db['users'].add({'login': nome, 'password': senha});

      // Atualiza o JSON (no caso real, seria necessário gravar isso em um backend ou solução local persistente)
      print(jsonEncode(db)); // Apenas para verificar no console
      // Para salvar localmente, seria necessário um backend ou lógica de escrita.
    } catch (e) {
      print("Erro ao salvar o usuário: $e");
    }
  }

  void _cadastrar() async {
    if (_nomeController.text.isNotEmpty && _senhaController.text.isNotEmpty) {
      await _saveUser(_nomeController.text, _senhaController.text);

      // Exibe um diálogo de sucesso
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Cadastro'),
            content: Text('Cadastro realizado com sucesso!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o alerta
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:
            Text('Cadastro', style: TextStyle(color: const Color(0xFFA7005C))),
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
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _cadastrar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 202, 20, 20),
              ),
              child: Text('Enviar', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
