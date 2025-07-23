import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp é o widget principal que configura o app.
    return MaterialApp(
      title: 'Cotações App',
      // Scaffold é a estrutura básica de uma tela no Material Design.
      home: Scaffold(
        // AppBar é a barra no topo da tela.
        appBar: AppBar(
          title: const Text('CambioNow'),
          backgroundColor: Colors.blueGrey,
        ),
        // Center centraliza o widget filho.
        body: const Center(
          // Text é o widget para exibir texto. [cite: 17]
          child: Text(
            'Bem-vindo ao meu App de Cotações!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
