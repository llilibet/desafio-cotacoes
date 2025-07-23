# Desafio Flutter: Aplicativo de Cotações de Moedas.

## Descrição do Projeto

[cite_start]Este é um aplicativo mobile desenvolvido em Flutter como parte do desafio Talent Lab. [cite: 38] [cite_start]O objetivo é fornecer cotações de moedas em tempo real, consumir uma API pública e apresentar os dados em uma interface amigável e funcional. [cite: 6, 7]

Além dos requisitos básicos, o projeto inclui funcionalidades extras como um conversor de moedas integrado e uma barra de pesquisa para filtrar os resultados.

## Funcionalidades Implementadas
* [cite_start]Visualização de uma lista de cotações de moedas baseadas no Dólar (USD). [cite: 11]
* [cite_start]Navegação para uma tela de detalhes para cada moeda. [cite: 12]
* [cite_start]Interface com Cards e ícones de bandeiras (via `CircleFlags`). [cite: 28]
* Barra de pesquisa para filtrar moedas por seu código.
* Tela de conversão de moedas em tempo real.
* [cite_start]Testes unitários para o serviço de consumo da API. [cite: 13]

## Tecnologias Utilizadas
* Flutter & Dart
* Pacote `http` para requisições de API
* Pacote `mockito` para testes unitários
* Pacote `circle_flags` para exibição das bandeiras

## API Utilizada
[cite_start]O aplicativo consome os dados da **Exchange Rate-API**. [cite: 10, 39]
* **Endereço:** `https://www.exchangerate-api.com`

## Como Executar o Projeto

1.  Clone este repositório.
2.  Garanta que o Flutter SDK esteja instalado e configurado em sua máquina.
3.  Abra a pasta do projeto no seu terminal.
4.  Execute o comando `flutter pub get` para baixar as dependências.
5.  [cite_start]Execute o comando `flutter run` para iniciar o aplicativo em um emulador ou dispositivo físico. [cite: 37]

## Testes
Para rodar os testes unitários, execute o comando:
`flutter test`
