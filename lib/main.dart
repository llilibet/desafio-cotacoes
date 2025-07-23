import 'package:flutter/material.dart';
import 'services/api_service.dart'; // Importa nosso serviço de API

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cotações App',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const HomePage(),
    );
  }
}

// Convertemos para StatefulWidget para poder gerenciar o estado
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variáveis de estado
  bool _isLoading = true; // Para controlar o indicador de carregamento
  Map<String, dynamic> _rates = {}; // Para guardar as cotações
  String? _errorMessage; // Para guardar mensagens de erro

  @override
  void initState() {
    super.initState();
    _getRates(); // Chama a função para buscar os dados quando a tela é iniciada
  }

  // Função para buscar os dados e atualizar o estado da tela
  Future<void> _getRates() async {
    try {
      final rates = await fetchRates();
      setState(() {
        // Atualiza a UI com os novos dados
        _rates = rates;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        // Em caso de erro, atualiza a UI para mostrar a mensagem
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cotações em USD')),
      // O corpo da tela agora depende do estado
      body: _buildBody(),
    );
  }

  // Widget auxiliar para construir o corpo da tela
  Widget _buildBody() {
    if (_isLoading) {
      // Se está carregando, mostra um indicador de progresso
      return const Center(child: CircularProgressIndicator());
    } else if (_errorMessage != null) {
      // Se houve um erro, mostra a mensagem de erro
      return Center(child: Text('Erro: $_errorMessage'));
    } else {
      // Se os dados chegaram, constrói a ListView
      return ListView.builder(
        itemCount: _rates.keys.length,
        itemBuilder: (context, index) {
          String currencyCode = _rates.keys.elementAt(index);

          // AQUI ESTÁ A CORREÇÃO FINAL E IMPORTANTE
          double rate = (_rates[currencyCode] as num).toDouble();

          // ListTile é um widget pronto para itens de lista
          return ListTile(
            title: Text(
              currencyCode,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(rate.toStringAsFixed(4)),
          );
        },
      );
    }
  }
}
