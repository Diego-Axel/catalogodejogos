import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/game.dart';
import '../widgets/game_card.dart';
import 'game_detail.dart';

class AllGamesPage extends StatefulWidget {
  const AllGamesPage({super.key});

  @override
  State<AllGamesPage> createState() => _AllGamesPageState();
}

class _AllGamesPageState extends State<AllGamesPage> {
  final String apiKey = 'feb59574ca2e46c49cce18fc9f2b25b4';
  final List<Game> _allGames = [];
  int _page = 1;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchAllGames();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
        _fetchAllGames();
      }
    });
  }

  Future<void> _fetchAllGames() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final url = Uri.parse(
        'https://api.rawg.io/api/games?key=$apiKey&page=$_page&page_size=20'); // Ajuste page_size conforme necessário
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      setState(() {
        _allGames.addAll(results.map((e) => Game.fromJson(e)).toList());
        _page++;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      // Opcional: mostrar uma mensagem de erro
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos os Jogos'),
        leading: BackButton(),
      ),
      body: _allGames.isEmpty && _isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dois cards por linha
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7, // Ajuste para melhor visualização dos cards
              ),
              itemCount: _allGames.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _allGames.length) {
                  return Center(child: CircularProgressIndicator());
                }
                final game = _allGames[index];
                return GameCard(
                  game: game,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameDetailPage(game: game),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}