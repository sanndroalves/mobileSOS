import 'package:flutter/material.dart';
import 'cadastro_screen.dart';    // Importa a tela após o login

class ContatoScreen extends StatefulWidget {
  @override
  _ContatoScreenState createState() => _ContatoScreenState();
}

class _ContatoScreenState extends State<ContatoScreen> {
  // Lista de contatos (apenas um exemplo de dados iniciais)
  List<Map<String, String>> contatos = [
    {'nome': 'Prof Daniel', 'telefone': '(11) 98765-4321'},
    {'nome': 'Isabela', 'telefone': '(21) 98765-4322'},
    {'nome': 'Felipe', 'telefone': '(31) 98765-4323'}, 
  ];

  // Função para remover um contato
  void _removerContato(int index) {
    setState(() {
      contatos.removeAt(index);
    });
  }

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
            onPressed: () {
              // Navegar para a tela de cadastro
              Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: contatos.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Card(
                color: Colors.grey[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Informações de contato (Nome e Telefone)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NOME: ${contatos[index]['nome']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'TELEFONE: ${contatos[index]['telefone']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      // Ícones de editar e remover
                      Row(
                        children: [ 
                          IconButton(
                            icon: Icon(Icons.delete, color: const Color(0xFFA7005C)),
                            onPressed: () {
                              _removerContato(index); // Remove o contato
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
