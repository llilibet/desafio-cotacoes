// test/api_service_test.dart

// 1. VERIFIQUE SE O NOME 'cotacoes' ESTÁ CORRETO AQUI
import 'package:cotacao/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 2. ESTE IMPORT VAI DAR ERRO POR ENQUANTO, É NORMAL
import 'api_service_test.mocks.dart';

// 3. GARANTA QUE ESTA ANOTAÇÃO ESTÁ EXATAMENTE ASSIM
@GenerateMocks([http.Client])
void main() {
  group('fetchRates', () {
    test(
      'retorna um mapa de cotações se a chamada http for bem-sucedida',
      () async {
        final client = MockClient();

        when(
          client.get(
            Uri.parse(
              'https://v6.exchangerate-api.com/v6/c6170c1c0dc5b341e04ccd30/latest/USD',
            ),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            '{"result":"success","conversion_rates":{"USD":1.0,"BRL":5.5}}',
            200,
          ),
        );

        final rates = await fetchRates(client);

        expect(rates, isA<Map<String, dynamic>>());
        expect(rates['BRL'], 5.5);
      },
    );

    test('lança uma exceção se a chamada http retornar um erro', () {
      final client = MockClient();

      when(
        client.get(
          Uri.parse(
            'https://v6.exchangerate-api.com/v6/c6170c1c0dc5b341e04ccd30/latest/USD',
          ),
        ),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchRates(client), throwsException);
    });
  });
}
