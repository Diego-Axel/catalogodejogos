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
        child: Text(
          'A RAWG é uma das maiores APIs abertas sobre jogos. '
          'Você pode acessar jogos, desenvolvedores, plataformas e mais. '
          '\n\nDocumentação oficial: https://api.rawg.io/docs/',
          style: TextStyle(color: Colors.green, fontSize: 16),
        ),
      ),
    );
  }
}
