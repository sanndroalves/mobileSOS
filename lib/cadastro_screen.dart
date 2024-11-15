import 'package:flutter/material.dart';
import 'lista.dart'; // Importando a tela de cadastro


class CadastroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(Icons.person, color: const Color(0xFFA7005C)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: const Color(0xFFA7005C)),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Container(
          color: Colors.grey[800],
          padding: EdgeInsets.all(16.0),
          width: 400,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA7005C),
                  foregroundColor: Colors.white, // Cor do texto do botão
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {},
                child: Text('CADASTRAR'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white, // Cor do texto do botão
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Voltar'), // Modifique o texto se necessário
                  ),
                  SizedBox(width: 20), // Espaço entre os botões
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white, // Cor do texto do botão
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    onPressed: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContatoScreen()),
                      );
                    },
                    child: Text('Lista'), // Modifique o texto se necessário
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
