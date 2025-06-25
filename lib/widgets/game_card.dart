import 'package:flutter/material.dart';
import '../models/game.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final VoidCallback? onTap;

  const GameCard({required this.game, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 150,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.green.shade900.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 5,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          children: [
            Hero(
              tag: game.name,
              child: game.backgroundImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        game.backgroundImage!,
                        height: 100,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(height: 100, color: Colors.grey),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                game.name,
                style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}