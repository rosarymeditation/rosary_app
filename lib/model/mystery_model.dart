import 'package:rosary/model/mystery_content_model.dart';

class MysteryModel {
  final int id;
  final String name;
  final String days;
  final String img;
  List<MysteryContentModel> mysteryList;

  MysteryModel({
    required this.id,
    required this.name,
    required this.days,
    required this.img,
    List<MysteryContentModel>? mysteryList,
  }) : mysteryList = mysteryList ?? [];

  // Factory constructor to create a model instance from a map (JSON)
  factory MysteryModel.fromJson(Map<String, dynamic> json) {
    return MysteryModel(
      id: json['id'],
      name: json['name'],
      days: json['days'],
      img: json['img'],
    );
  }

  // Method to convert model instance to a map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
