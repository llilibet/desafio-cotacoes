// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchRates() async {
  final url = Uri.parse(
    'https://v6.exchangerate-api.com/v6/c6170c1c0dc5b341e04ccd30/latest/USD',
  );
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    // O print de debug não é mais necessário, você pode removê-lo se quiser.
    // print('Resposta da API: $data');

    // CORREÇÃO: Agora procuramos por 'conversion_rates', que é o nome correto da chave.
    if (data is Map &&
        data.containsKey('conversion_rates') &&
        data['conversion_rates'] is Map) {
      // E retornamos o mapa de 'conversion_rates'.
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
