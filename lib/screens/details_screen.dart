import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String currencyCode;
  final double rate;

  const DetailsScreen({
    super.key,
    required this.currencyCode,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes de $currencyCode'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '1 USD (Dólar americano) equivale',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                '${rate.toStringAsFixed(4)} $currencyCode',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.blueGrey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Cotação referente à última atualização da API.',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
