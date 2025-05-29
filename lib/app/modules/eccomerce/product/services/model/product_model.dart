class GameModel {
  final int id;
  final String name;
  final String? backgroundImage;
  final List<String> shortScreenshots;

  GameModel({required this.id, required this.name, this.backgroundImage, required this.shortScreenshots});

  factory GameModel.fromJson(Map<String, dynamic> json) {
    List<String> screenshots = [];
    if (json['short_screenshots'] != null && json['short_screenshots'] is List) {
      screenshots = List<String>.from((json['short_screenshots'] as List).map((ss) => ss['image'] as String? ?? '').where((url) => url.isNotEmpty));
    }

    return GameModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Nome Indisponível',
      backgroundImage: json['background_image'] as String?,
      shortScreenshots: screenshots,
    );
  }
}
