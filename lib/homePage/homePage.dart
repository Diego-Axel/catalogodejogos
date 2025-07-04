import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../devs/devs.dart';
import '../api/api.dart';
import '../models/game.dart';
import '../widgets/game_card.dart';
import 'category_scroller.dart';
import 'auto_scroll_row.dart';
import 'game_detail.dart';
import 'all_games_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // A chave API agora é carregada do arquivo .env
  final String apiKey = dotenv.env['RAWG_API_KEY']!; // Modificado
  final TextEditingController _searchController = TextEditingController();
  List<Game> searchResults = [];
  bool searchNotFound = false;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          searchResults = [];
          searchNotFound = false;
        });
      }
    });
  }

  Future<void> searchGame(String query) async {
    final url = Uri.parse(
        'https://api.rawg.io/api/games?key=$apiKey&search=$query&page_size=5');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List results = json.decode(response.body)['results'];
      if (results.isEmpty) {
        setState(() {
          searchNotFound = true;
          searchResults = [];
        });
      } else {
        setState(() {
          searchNotFound = false;
          searchResults = results.map((json) => Game.fromJson(json)).toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Jogos'),
        actions: [
          // Removido o botão "Todos os Jogos" daqui para movê-lo para o corpo
        ],
        leading: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'devs') {
              Navigator.push(context, MaterialPageRoute(builder: (_) => DevsPage()));
            } else if (value == 'api') {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ApiPage()));
            }
          },
          icon: Icon(Icons.menu),
          itemBuilder: (context) => [
            PopupMenuItem(value: 'devs', child: Text('Desenvolvedores')),
            PopupMenuItem(value: 'api', child: Text('API')),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onSubmitted: searchGame,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar jogo...',
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.green.shade900,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                suffixIcon: Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: searchResults.isNotEmpty
            ? ListView(
                children: [
                  Text("Resultados da busca:",
                      style: TextStyle(color: Colors.green, fontSize: 18)),
                  SizedBox(height: 10),
                    ...searchResults.map(
                      (game) => InkWell(
                        onTap: () { Navigator.push(
                          context, MaterialPageRoute(
                            builder: (_) => GameDetailPage(game: game),
                          ),
                        );
                      },
                      child: GameCard(game: game),
                    ),
                  ),
                ],
              )
            : searchNotFound
                ? Center(child: Text("Jogo não encontrado", style: TextStyle(color: Colors.red)))
                : ListView(
                    children: [
                      AutoScrollRow(
                        title: "Jogos em Destaque",
                        ordering: "-rating",
                      ),
                      CategoryScroller(
                        title: "Mais populares",
                        ordering: "-added",
                      ),
                      SizedBox(height: 20), // Espaçamento após a categoria "Mais Populares"
                      Center( // Centraliza o botão
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700, // Cor de fundo do botão
                            foregroundColor: Colors.white, // Cor do texto do botão
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AllGamesPage()),
                            );
                          },
                          child: Text('Todos os Jogos'),
                        ),
                      ),
                      SizedBox(height: 20), // Espaçamento após o botão
                    ],
                  ),
      ),
    );
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}