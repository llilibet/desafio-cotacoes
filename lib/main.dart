import 'package:flutter/material.dart';
import 'services/api_service.dart'; // Importa nosso serviço de API
import 'screens/details_screen.dart'; // Importa a tela de detalhes

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CambioNow',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  Map<String, dynamic> _rates = {};
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _getRates();
  }

  // Usa setState para gerenciar o estado dos dados [cite: 27]
  Future<void> _getRates() async {
    try {
      final rates = await fetchRates();
      setState(() {
        _rates = rates;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cotações em USD')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_errorMessage != null) {
      return Center(child: Text('Erro: $_errorMessage'));
    } else {
      return ListView.builder(
        itemCount: _rates.keys.length,
        itemBuilder: (context, index) {
          String currencyCode = _rates.keys.elementAt(index);
          double rate = (_rates[currencyCode] as num).toDouble();

          // Envolvemos o ListTile com um InkWell para torná-lo clicável.
          return InkWell(
            onTap: () {
              // Ação que acontece ao tocar no item da lista.
              // Implementa a navegação para a tela de detalhes. [cite: 26]
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailsScreen(currencyCode: currencyCode, rate: rate),
                ),
              );
            },
            child: ListTile(
              title: Text(
                currencyCode,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(rate.toStringAsFixed(4)),
            ),
          );
        },
      );
    }
  }
}
