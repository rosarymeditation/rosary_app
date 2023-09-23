class BidModel {
  final int id;
  final String type;
  bool hasSelected;
  bool isCrucifix;

  BidModel({
    required this.id,
    required this.type,
    this.hasSelected = false,
    this.isCrucifix = false,
  });

  // Factory constructor to create a model instance from a map (JSON)
  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      id: json['id'],
      type: json['type'],
      isCrucifix: json['isCrucifix'],
      hasSelected: json['hasSelected'] ?? false,
    );
  }

  // Method to convert model instance to a map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'isCrucifix': isCrucifix,
      'hasSelected': hasSelected,
    };
  }
}
