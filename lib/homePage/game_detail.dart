import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/game.dart';

class GameDetailPage extends StatefulWidget {
  final Game game;

  const GameDetailPage({required this.game});

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  Game? detailedGame;
  final String apiKey = 'feb59574ca2e46c49cce18fc9f2b25b4';

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    final url = Uri.parse('https://api.rawg.io/api/games/${Uri.encodeComponent(widget.game.name)}?key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        detailedGame = Game.fromJson(data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final game = detailedGame ?? widget.game;

    return Scaffold(
      appBar: AppBar(title: Text(game.name)),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Hero(
            tag: game.name,
            child: game.backgroundImage != null
                ? Image.network(game.backgroundImage!)
                : Container(height: 200, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Text(game.name, style: TextStyle(fontSize: 24, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          if (game.released != null)
            Text('Lançamento: ${game.released!}', style: TextStyle(color: Colors.white70)),
          if (game.rating != null)
            Text('Avaliação: ${game.rating!.toStringAsFixed(1)} / 5.0', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 16),
          if (game.description != null)
            Text(game.description!.replaceAll(RegExp(r'<[^>]*>'), ''),
                style: TextStyle(color: Colors.white)),
          if (game.description == null)
            Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            )),
        ],
      ),
    );
  }
}