import 'package:flutter/material.dart';
import 'dart:async'; // Para usar Timer
import 'package:url_launcher/url_launcher.dart'; // Importa o url_launcher
import 'cadastro_screen.dart';    // Importa a tela após o login


class BotaoScreen extends StatefulWidget {
  @override
  _BotaoScreenState createState() => _BotaoScreenState();
}

class _BotaoScreenState extends State<BotaoScreen> {
  Timer? _longPressTimer;
  Timer? _alertTimer;
  Timer? _dotTimer; // Timer para as bolinhas
  String _status = 'STATUS: CARREGANDO';
  bool _isAlerting = false;
  Color _iconColor = const Color(0xFFA7005C); // Cor inicial do ícone
  int _dotsCount = 0; // Quantidade de bolinhas a serem mostradas (até 3)

  // Número do WhatsApp para enviar a mensagem
  final String _whatsappNumber = '5519988190652';

  // Função para enviar mensagem no WhatsApp
  void _sendWhatsAppMessage(String message) async {
    final Uri url = Uri.parse('https://wa.me/$_whatsappNumber?text=$message');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Não foi possível abrir o WhatsApp.';
    }
  }

  // Função para iniciar o timer de 3 segundos e alterar o status
  void _startLongPressTimer() {
    _dotsCount = 0; // Reseta as bolinhas
    _startDotTimer(); // Inicia o timer das bolinhas

    _longPressTimer = Timer(Duration(seconds: 3), () {
      setState(() {
        _status = 'STATUS: ALERTANDO...'; // Atualiza o status
        _isAlerting = true;
        _iconColor = Colors.white; // Altera a cor do ícone para branco
      });

      // Inicia o segundo timer para exibir o alerta após mais 2 segundos
      _alertTimer = Timer(Duration(seconds: 2), () {
        _showAlert();
        // Envia mensagem automaticamente após o alerta ser exibido
        _sendWhatsAppMessage('USUARIO TAL PEDINDO SOCORRO');
        setState(() {
          _status = 'STATUS: CARREGANDO'; // Volta o status ao normal
          _iconColor = const Color(0xFFA7005C); // Volta o ícone à cor original
          _isAlerting = false;
          _dotsCount = 0; // Reseta as bolinhas após o alerta
        });
      });
    });
  }

  // Função para o timer que adiciona bolinhas a cada segundo
  void _startDotTimer() {
    _dotTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_dotsCount < 3) {
        setState(() {
          _dotsCount++; // Incrementa o número de bolinhas até 3
        });
      } else {
        _dotTimer?.cancel(); // Para de adicionar bolinhas após 3 segundos
      }
    });
  }

  // Função para cancelar o timer caso o usuário solte o botão antes do tempo
  void _cancelLongPressTimer() {
    if (_longPressTimer != null) {
      _longPressTimer!.cancel();
    }
    if (_alertTimer != null) {
      _alertTimer!.cancel();
    }
    if (_dotTimer != null) {
      _dotTimer!.cancel();
    }
    if (_isAlerting) {
      setState(() {
        _status = 'STATUS: CARREGANDO'; // Volta ao status original
        _iconColor = const Color(0xFFA7005C); // Volta o ícone à cor original
        _dotsCount = 0; // Reseta as bolinhas
      });
    }
  }

  // Função para exibir o alerta "SOCORRO ENVIADO"
  void _showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text('SOCORRO ENVIADO'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _cancelLongPressTimer(); // Cancelar os timers ao sair da tela
    super.dispose();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Adiciona o ícone maior como botão centralizado com GestureDetector
          Center(
            child: SizedBox(
              width: 200, // Define o tamanho do botão
              height: 200,
              child: GestureDetector(
                onTapDown: (details) {
                  // Inicia o timer quando o botão é pressionado
                  _startLongPressTimer();
                },
                onTapUp: (details) {
                  // Cancela o timer se o toque for liberado antes dos 3 segundos
                  _cancelLongPressTimer();
                },
                onTapCancel: () {
                  // Cancela o timer se o toque for cancelado
                  _cancelLongPressTimer();
                },
                child: Icon(
                  Icons.touch_app,
                  color: _iconColor, // Cor do ícone que será alterada após 3 segundos
                  size: 150, // Tamanho do ícone
                ),
              ),
            ),
          ),
          SizedBox(height: 20), // Espaço entre o ícone e as bolinhas
          // Exibe as bolinhas brancas de acordo com o número de segundos
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_dotsCount, (index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 10, // Tamanho da bolinha
                  backgroundColor: Colors.white, // Cor da bolinha
                ),
              );
            }),
          ),
          SizedBox(height: 40), // Espaço entre as bolinhas e o texto de status
          // Adiciona o texto de status na parte inferior
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xFFA7005C),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  _status,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
