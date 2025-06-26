import 'package:flutter/material.dart';

class ApiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações da API'),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Adicionado SingleChildScrollView para acomodar texto maior
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A RAWG API é uma das maiores e mais abrangentes APIs abertas dedicadas a videogames. Ela oferece acesso programático a uma vasta base de dados que inclui informações detalhadas sobre jogos, desenvolvedores, plataformas, gêneros, tags e muito mais. Esta API é uma ferramenta essencial para desenvolvedores que buscam integrar funcionalidades ricas em dados de jogos em suas aplicações.',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Recursos Principais da RAWG API:',
                style: TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '- **Catálogo de Jogos:** Acesse informações sobre milhões de jogos, incluindo títulos, datas de lançamento, avaliações, imagens de fundo e descrições detalhadas.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                '- **Desenvolvedores e Editoras:** Consulte perfis de desenvolvedores e editoras, seus jogos e estatísticas.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                '- **Plataformas:** Obtenha listas de plataformas suportadas e os jogos disponíveis em cada uma.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                '- **Busca e Filtragem:** Capacidade de realizar buscas complexas e aplicar filtros por gênero, ano de lançamento, avaliações (como Metacritic) e popularidade, permitindo a criação de listas personalizadas de jogos.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Para mais informações e para explorar todas as funcionalidades disponíveis, consulte a documentação oficial:',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () {
                  // Implementar lançamento de URL, se necessário
                },
                child: Text(
                  'Documentação oficial da RAWG API',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Text(
                'https://api.rawg.io/docs/',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}