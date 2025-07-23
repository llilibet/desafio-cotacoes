import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  final Map<String, dynamic> rates;

  // Recebemos o mapa de cotações da tela anterior
  const ConverterScreen({super.key, required this.rates});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  // Controladores e variáveis de estado
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD'; // Moeda de origem padrão
  String _toCurrency = 'BRL'; // Moeda de destino padrão
  double _convertedAmount = 0.0;

  @override
  void initState() {
    super.initState();
    // Adiciona um listener para o campo de texto para converter em tempo real
    _amountController.addListener(_convertCurrency);
  }

  void _convertCurrency() {
    // Pega o valor do input, tratando vírgula e valor vazio
    final amountText = _amountController.text.replaceAll(',', '.');
    final amount = double.tryParse(amountText) ?? 0.0;

    // Pega as taxas de conversão (baseadas em USD)
    final fromRate = (widget.rates[_fromCurrency] as num).toDouble();
    final toRate = (widget.rates[_toCurrency] as num).toDouble();

    setState(() {
      // A fórmula de conversão: (valor / taxa_origem) * taxa_destino
      _convertedAmount = (amount / fromRate) * toRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Moeda'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo para digitar o valor
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Valor a converter',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Linha com os dois menus de seleção e o botão de inverter
            Row(
              children: [
                Expanded(child: _buildCurrencyDropdown(isFrom: true)),
                IconButton(
                  icon: const Icon(Icons.swap_horiz),
                  onPressed: () {
                    // Inverte as moedas e recalcula
                    final temp = _fromCurrency;
                    setState(() {
                      _fromCurrency = _toCurrency;
                      _toCurrency = temp;
                      _convertCurrency();
                    });
                  },
                ),
                Expanded(child: _buildCurrencyDropdown(isFrom: false)),
              ],
            ),
            const SizedBox(height: 30),

            // Exibição do resultado da conversão
            const Text(
              'Resultado:',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            Text(
              _convertedAmount.toStringAsFixed(2),
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para construir os Dropdowns
  Widget _buildCurrencyDropdown({required bool isFrom}) {
    return DropdownButton<String>(
      value: isFrom ? _fromCurrency : _toCurrency,
      isExpanded: true,
      items: widget.rates.keys.map((String currency) {
        return DropdownMenuItem<String>(value: currency, child: Text(currency));
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            if (isFrom) {
              _fromCurrency = newValue;
            } else {
              _toCurrency = newValue;
            }
            _convertCurrency();
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
