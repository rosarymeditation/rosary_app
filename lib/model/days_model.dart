class DaysModel {
  final int id;
  final String name;
  final String mystery;
  final int number;

  DaysModel(
      {required this.id,
      required this.name,
      required this.number,
      required this.mystery});

  // Factory constructor to create a model instance from a map (JSON)
  factory DaysModel.fromJson(Map<String, dynamic> json) {
    return DaysModel(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      mystery: json['mystery'],
    );
  }

  // Method to convert model instance to a map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'mystery': mystery,
    };
  }
}
