import 'package:flutter/material.dart';
import 'package:circle_flags/circle_flags.dart';
import 'package:http/http.dart' as http;
import 'services/api_service.dart'; // Importa serviço de API
import 'screens/details_screen.dart'; // Importa a tela de detalhe da cotação
import 'screens/converter_screen.dart'; // Importa a tela de converter

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
  Map<String, dynamic> _originalRates = {}; // Guarda a lista original
  Map<String, dynamic> _filteredRates =
      {}; // Guarda a lista filtrada para exibição
  String? _errorMessage;

  // campo de pesquisa
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterCurrencies);
    _getRates();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getRates() async {
    try {
      final rates = await fetchRates(http.Client());
      setState(() {
        _originalRates = rates;
        _filteredRates =
            rates; // No início, a lista filtrada é a lista completa
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  // função que faz a mágica do filtro
  void _filterCurrencies() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRates = _originalRates.entries
          .where((entry) => entry.key.toLowerCase().contains(query))
          .fold<Map<String, dynamic>>(
            {},
            (map, entry) => map..[entry.key] = entry.value,
          );
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cotações em USD')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Pesquisar moeda (ex: BRL)',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(child: _buildBody()),
        ],
      ),
      // botão flutuante
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConverterScreen(rates: _originalRates),
            ),
          );
        },
        label: const Text('Converter'),
        icon: const Icon(Icons.calculate),
        backgroundColor: const Color.fromARGB(255, 240, 241, 238),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_errorMessage != null) {
      return Center(child: Text('Erro: $_errorMessage'));
    } else if (_filteredRates.isEmpty) {
      return const Center(child: Text('Nenhuma moeda encontrada.'));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: _filteredRates.keys.length,
        itemBuilder: (context, index) {
          String currencyCode = _filteredRates.keys.elementAt(index);
          double rate = (_filteredRates[currencyCode] as num).toDouble();

          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailsScreen(currencyCode: currencyCode, rate: rate),
                  ),
                );
              },
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15.0,
                ),
                leading: _buildFlag(currencyCode),
                title: Text(
                  currencyCode,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                trailing: Text(
                  rate.toStringAsFixed(4),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  // função auxiliar para as bandeiras
  Widget _buildFlag(String currencyCode) {
    // Lista de códigos de 3 letras que não correspondem a países de 2 letras
    const nonCountryCodes = {
      // Lista das bandeiras que são exceções
      'EUR',
      'XAF',
      'XOF',
      'XPF',
      'ANG',
      'XCD',
      'XCG',
      'XDR',
    };

    // Se o código da moeda estiver na nossa lista de exceções, mostramos um ícone padrão.
    if (nonCountryCodes.contains(currencyCode)) {
      return CircleAvatar(
        backgroundColor: Colors.blueGrey[100],
        child: const Icon(
          Icons.monetization_on_outlined,
          color: Colors.blueGrey,
        ),
      );
    }

    // Se não for uma exceção, tentamos mostrar a bandeira.
    return CircleFlag(currencyCode.substring(0, 2), size: 40);
  }
}
