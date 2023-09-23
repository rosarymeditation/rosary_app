class MysteryContentModel {
  final int id;
  final String title;
  final String imageUrl;
  List<String> content;

  MysteryContentModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    List<String>? content,
  }) : content = content ?? [];
}
