import 'dart:convert';
import 'package:http/http.dart' as http;

// A função precisa aceitar o 'client' como parâmetro.
Future<Map<String, dynamic>> fetchRates(http.Client client) async {
  final url = Uri.parse(
    'https://v6.exchangerate-api.com/v6/c6170c1c0dc5b341e04ccd30/latest/USD',
  );

  // E precisa usar o 'client' recebido para fazer a chamada.
  final response = await client.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    if (data is Map &&
        data.containsKey('conversion_rates') &&
        data['conversion_rates'] is Map) {
      return Map<String, dynamic>.from(data['conversion_rates']);
    } else {
      throw Exception('Formato de resposta inesperado da API.');
    }
  } else {
    throw Exception(
      'Falha ao carregar cotações: Status code ${response.statusCode}',
    );
  }
}
