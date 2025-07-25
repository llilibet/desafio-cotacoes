# Desafio Flutter: Aplicativo de Cotações de Moedas.

## Descrição do Projeto 

Este é um aplicativo mobile desenvolvido em Flutter como parte do desafio Talent Lab. O objetivo é fornecer cotações de moedas em tempo real, consumindo uma API pública e apresentar os dados em uma interface amigável e funcional.

Além dos requisitos básicos definidos, o projeto inclui funcionalidades extras como um conversor de moedas integrado e uma barra de pesquisa para filtrar os resultados.

## Funcionalidades Implementadas 
* Visualização de uma lista de cotações de moedas baseadas no Dólar (USD).
* Navegação para uma tela de detalhes para cada moeda.
* Interface com Cards e ícones de bandeiras (via `CircleFlags`).
* Barra de pesquisa para filtrar moedas por seu código.
* Tela de conversão de moedas em tempo real.
* Testes unitários para o serviço de consumo da API.

## Tecnologias Utilizadas
* Flutter & Dart
* Pacote `http` para requisições de API
* Pacote `mockito` para testes unitários
* Pacote `circle_flags` para exibição das bandeiras

## API Utilizada
O aplicativo consome os dados da **Exchange Rate-API**.
* **Endereço:** `https://www.exchangerate-api.com`

## Como Executar o Projeto

1.  Clone este repositório.
2.  Garanta que o Flutter SDK esteja instalado e configurado em sua máquina.
3.  Abra a pasta do projeto no seu terminal.
4.  Execute o comando para baixar as dependências:
   
```bash
flutter pub get
```

6.  Execute o comando para iniciar o aplicativo em um emulador ou dispositivo físico: 

```bash
flutter run
```

## Testes
Para rodar os testes unitários, execute o comando:

```bash
flutter test
```

