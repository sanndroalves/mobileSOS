import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _nomeController = TextEditingController();
  final _senhaController = TextEditingController();
  late File _localDbFile;

  @override
  void initState() {
    super.initState();
    _initializeDb();
  }

  Future<void> _initializeDb() async {
    // Obtém o diretório gravável
    final directory = await getApplicationDocumentsDirectory();
    final dbFile = File('${directory.path}/db.json');

    // Copia o arquivo de assets, se necessário
    if (!await dbFile.exists()) {
      final String response = await rootBundle.loadString('assets/db.json');
      await dbFile.writeAsString(response);
    }

    _localDbFile = dbFile;
  }

  Future<void> _saveUser(String nome, String senha) async {
    try {
      // Lê o conteúdo atual do arquivo
      final String content = await _localDbFile.readAsString();
      Map<String, dynamic> db = jsonDecode(content);

      // Adiciona o novo usuário
      db['users'].add({'nome': nome, 'senha': senha});

      // Salva o JSON atualizado
      await _localDbFile.writeAsString(jsonEncode(db));
      print("Usuário salvo com sucesso: $db");
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
