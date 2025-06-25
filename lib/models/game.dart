class Game {
  final String name;
  final String? backgroundImage;
  final String? description;
  final double? rating;
  final String? released;

  Game({
    required this.name,
    this.backgroundImage,
    this.description,
    this.rating,
    this.released,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      name: json['name'],
      backgroundImage: json['background_image'],
      rating: (json['rating'] as num?)?.toDouble(),
      released: json['released'],
      // O campo description só é retornado na requisição por ID
      description: json['description'],
    );
  }
}