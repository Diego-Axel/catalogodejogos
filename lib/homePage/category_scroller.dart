import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/game.dart';
import '../widgets/game_card.dart';
import 'game_detail.dart';

class CategoryScroller extends StatefulWidget {
  final String title;
  final String ordering;

  const CategoryScroller({super.key, 
    required this.title,
    required this.ordering,
  });

  @override
  State<CategoryScroller> createState() => _CategoryScrollerState();
}

class _CategoryScrollerState extends State<CategoryScroller> {
  final String apiKey = 'feb59574ca2e46c49cce18fc9f2b25b4';
  final List<Game> _games = [];
  int _page = 1;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  void _fetchMore() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final url = Uri.parse(
        'https://api.rawg.io/api/games?key=$apiKey&ordering=${widget.ordering}&page=$_page&page_size=10');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List results = json.decode(response.body)['results'];
      setState(() {
        _games.addAll(results.map((e) => Game.fromJson(e)).toList());
        _page++;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        _fetchMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
            style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: _games.length + 1,
            itemBuilder: (context, index) {
              if (index < _games.length) {
                return GameCard(
                  game: _games[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameDetailPage(game: _games[index]),
                      ),
                    );
                  },
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
