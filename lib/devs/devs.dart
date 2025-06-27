import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            DevCard(
              name: 'Diêgo Axel',
              githubUrl: 'https://github.com/Diego-Axel',
            ),
            SizedBox(height: 16),
            DevCard(
              name: 'Samuel Morais',
              githubUrl: 'https://github.com/SamuelMorais45',
            ),
          ],
        ),
      ),
    );
  }
}

class DevCard extends StatelessWidget {
  final String name;
  final String? githubUrl;

  const DevCard({required this.name, this.githubUrl});

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
        subtitle: githubUrl != null
            ? InkWell(
                onTap: () async {
                  final uri = Uri.parse(githubUrl!);
                  if (await canLaunchUrl(uri)) { // Verifique se pode lançar a URL
                    await launchUrl(uri); // Lança a URL no navegador
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Não foi possível abrir o link: $githubUrl')),
                    );
                  }
                },
                child: Text(
                  githubUrl!,
                  style: TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline),
                ),
              )
            : Text('Informação de contato não disponível', style: TextStyle(color: Colors.white60)),
      ),
    );
  }
}