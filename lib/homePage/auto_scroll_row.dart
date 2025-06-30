import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/game.dart';
import '../widgets/game_card.dart';

class AutoScrollRow extends StatefulWidget {
  final String title;
  final String ordering;

  const AutoScrollRow({super.key, 
    required this.title,
    required this.ordering,
  });

  @override
  _AutoScrollRowState createState() => _AutoScrollRowState();
}

class _AutoScrollRowState extends State<AutoScrollRow> {
  final String apiKey = 'feb59574ca2e46c49cce18fc9f2b25b4';
  List<Game> games = [];
  ScrollController scrollController = ScrollController();
  Timer? scrollTimer;

  @override
  void initState() {
    super.initState();
    fetchGames();
    startAutoScroll();
  }

  Future<void> fetchGames() async {
    final url = Uri.parse('https://api.rawg.io/api/games?key=$apiKey&ordering=${widget.ordering}&page=1&page_size=10');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List results = json.decode(response.body)['results'];
      setState(() {
        games = results.map((e) => Game.fromJson(e)).toList();
      });
    }
  }

  void startAutoScroll() {
    scrollTimer = Timer.periodic(Duration(seconds: 3), (_) {
      if (scrollController.hasClients) {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.offset;

        double newScroll = currentScroll + 160; // largura aproximada do card

        if (newScroll >= maxScroll) {
          scrollController.animateTo(0,
              duration: Duration(milliseconds: 500), curve: Curves.easeOut);
        } else {
          scrollController.animateTo(newScroll,
              duration: Duration(milliseconds: 500), curve: Curves.easeOut);
        }
      }
    });
  }

  @override
  void dispose() {
    scrollTimer?.cancel();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return games.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    return GameCard(game: games[index]);
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          );
  }
}