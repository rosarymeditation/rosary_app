class BidDrawModel {
  final int id;
  final double x;
  final double y;
  bool isRegular;

  BidDrawModel({
    required this.id,
    required this.x,
    required this.y,
    this.isRegular = true,
  });

  factory BidDrawModel.fromJson(Map<String, dynamic> json) {
    return BidDrawModel(
      id: json['id'],
      x: json['x'],
      y: json['y'],
      isRegular: json['isRegular'] ?? false,
    );
  }

  // Method to convert model instance to a map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'x': x,
      'y': y,
      'isRegular': isRegular,
    };
  }
}
