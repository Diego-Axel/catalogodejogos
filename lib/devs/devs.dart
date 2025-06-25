import 'package:flutter/material.dart';

class DevsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desenvolvedores'),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DevCard(name: 'Diêgo Axel'),
            SizedBox(height: 16),
            DevCard(name: 'Samuel Morais'),
          ],
        ),
      ),
    );
  }
}

class DevCard extends StatelessWidget {
  final String name;

  const DevCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade900,
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          color: Colors.black,
          child: Center(child: Icon(Icons.person, color: Colors.white)),
        ),
        title: Text(name, style: TextStyle(color: Colors.white)),
        subtitle: Text('Foto aqui', style: TextStyle(color: Colors.white60)),
      ),
    );
  }
}
