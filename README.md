# Catálogo de Jogos

Este projeto é um aplicativo móvel desenvolvido em Flutter para catalogar e explorar informações sobre jogos. Foi criado como um projeto avaliativo para a disciplina de Programação Orientada a Objetos (POO), ministrada pelo Professor Fabricio, do curso de Sistemas de Informação.

## Desenvolvedores

* Diêgo Axel
* Samuel Morais

## Visão Geral do Projeto

O "Catálogo de Jogos" permite aos usuários buscar jogos, navegar por diferentes categorias e visualizar detalhes específicos de cada jogo. A aplicação consome dados de uma API externa para fornecer informações atualizadas sobre os títulos.

## Funcionalidades

* **Busca de Jogos:** Pesquise jogos por nome utilizando a barra de busca na tela inicial.
* **Listagem de Jogos em Destaque:** Uma seção com rolagem automática exibe jogos destacados.
* **Categorias de Jogos:** Explore jogos organizados em categorias como "Mais Populares" e "Simulação", com a capacidade de carregar mais itens ao rolar.
* **Detalhes do Jogo:** Clique em um jogo para ver informações detalhadas, incluindo imagem de fundo, data de lançamento, avaliação e uma descrição (se disponível).
* **Informações da API:** Acesso a detalhes sobre a API utilizada.
* **Informações dos Desenvolvedores:** Página dedicada aos desenvolvedores do projeto.

## Tecnologias Utilizadas

* **Flutter:** Framework de UI para desenvolvimento multiplataforma.
* **Dart:** Linguagem de programação utilizada pelo Flutter.
* **HTTP Package:** Para fazer requisições a APIs externas.

## API Utilizada

Este projeto utiliza a **RAWG API** para obter informações sobre jogos, desenvolvedores e plataformas.
Documentação oficial: [https://api.rawg.io/docs/](https://api.rawg.io/docs/)

## Estrutura do Projeto (Relevante)

O projeto segue a estrutura padrão de um aplicativo Flutter, com a lógica de UI e dados bem separadas.

* `lib/main.dart`: Ponto de entrada da aplicação, define o tema e a tela inicial.
* `lib/homePage/homePage.dart`: Implementa a tela inicial com busca e as seções de jogos.
* `lib/homePage/auto_scroll_row.dart`: Componente para a linha de jogos com rolagem automática.
* `lib/homePage/category_scroller.dart`: Componente para as categorias de jogos com rolagem horizontal e carregamento sob demanda.
* `lib/homePage/game_detail.dart`: Tela para exibir os detalhes de um jogo específico.
* `lib/models/game.dart`: Modelo de dados para a entidade `Game`.
* `lib/widgets/game_card.dart`: Widget reutilizável para exibir um card de jogo.
* `lib/devs/devs.dart`: Tela que mostra os desenvolvedores do projeto.
* `lib/api/api.dart`: Tela com informações sobre a API utilizada.
* `pubspec.yaml`: Gerencia as dependências do projeto e metadados.

## Como Executar o Projeto

Para rodar este projeto localmente, siga os passos abaixo:

1.  **Clone o repositório:**

    ```bash
    git clone git@github.com:Diego-Axel/catalogodejogos.git
    cd catalogodejogos
    ```

2.  **Obtenha as dependências:**

    ```bash
    flutter pub get
    ```

3.  **Execute o aplicativo:**

    ```bash
    flutter run
    ```

    Certifique-se de ter um dispositivo ou emulador configurado.

## Licença

Este projeto está licenciado sob a licença MIT License. Você pode encontrar os detalhes no arquivo `LICENSE`.
