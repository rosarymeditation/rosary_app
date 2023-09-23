import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';

import '../model/response_model.dart';
import '../utils/constants.dart';

class ImageController extends GetxController {
  final SharedPreferences sharedPreferences;
  late String token;
  ImageController({required this.sharedPreferences});
  File? _image;
  File? get image => _image;
  bool _isLoaded = true;
  bool get isLoaded => _isLoaded;

  PickedFile? _pickedFile;
  PickedFile? get pickedFile => _pickedFile;
  final _picker = ImagePicker();

  Future pickImage(ImageSource source) async {
    try {
      update();
      _pickedFile = await _picker.getImage(source: source);
      final image = await ImagePicker().pickImage(source: source);
      // _pickedFile = image;
      if (image == null) return;
      _image = File(_pickedFile!.path);
      //final imagePermanent = await saveImagePermanently(image.path);

      //this._image = imagePermanent;
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image" + e.toString());
    }
  }
}
