import 'dart:io';

class FileModel {
  File file;
  String name;

  FileModel({
    required this.file,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["file"] = this.file;
    data["name"] = this.name;
    return data;
  }
}
