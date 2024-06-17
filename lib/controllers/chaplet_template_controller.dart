import 'package:get/get.dart';
import 'package:rosary/data/repository/chaplet_repo.dart';

class ChapletController extends GetxController {
  final ChapletRepo chapletRepo;
  ChapletController({required this.chapletRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  String _templateType = "";
  String get templateType => _templateType;

  Future<void> setTemplate(String template) async {
    await chapletRepo.saveTemplate(template);
    await getTemplate();
    update();
  }

  Future<void> getTemplate() async {
    _templateType = await chapletRepo.getTemplate();
    update();
  }

  Future<bool> setHasSeenSettings() {
    return chapletRepo.setHasSeenSettings();
  }

  bool getHasSeenSettings() {
    return chapletRepo.getHasSeenSettings();
  }
}
