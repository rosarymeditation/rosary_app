import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:rosary/data/repository/prayer_request_repo.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerRequestController extends GetxController implements GetxService {
  final PrayerRequestRepo prayerRequestRepo;
  PrayerRequestController({required this.prayerRequestRepo});

  @override
  void onInit() {
    super.onInit();
    _prayerRequestList = prayerRequestRepo.prayerRequestCacheList();
  }

  late PrayerRequestModel _editContent;
  PrayerRequestModel get editContent => _editContent;
  List<PrayerRequestModel> _prayerRequestList = [];
  List<PrayerRequestModel> get prayerRequestList =>
      prayerRequestRepo.prayerRequestCacheList().toList();

  List<PrayerRequestModel> _selectedList = [];
  List<PrayerRequestModel> get selectedtList => _selectedList;

  void add(String content) {
    var random = Random();

    int id = random.nextInt(10000);

    var date = DateTime.now();
    _prayerRequestList.insert(0, PrayerRequestModel(id: id, content: content));

    prayerRequestRepo.savePrayerRequestAsString(_prayerRequestList);
    update();
  }

  void clear() {
    prayerRequestRepo.clearSharedData();
  }

  void delete(id) {
    _prayerRequestList.removeWhere((item) => item.id == id);
    prayerRequestRepo.savePrayerRequestAsString(_prayerRequestList);
    update();
  }

  void toggle(id) {
    var getPrayer = _prayerRequestList.firstWhere((item) => item.id == id,
        orElse: () => null!);

    if (getPrayer != null) {
      getPrayer.isChecked = !getPrayer.isChecked!;
    } else {
      print('Item not found');
    }

    prayerRequestRepo.savePrayerRequestAsString(_prayerRequestList);
    update();
  }

  void edit(PrayerRequestModel content) {
    _editContent = content;
    update();
  }

  void updateContent(id, content) {
    var getPrayer = _prayerRequestList.firstWhere((item) => item.id == id,
        orElse: () => null!);

    if (getPrayer != null) {
      getPrayer.content = content;
    } else {
      print('Item not found');
    }

    prayerRequestRepo.savePrayerRequestAsString(_prayerRequestList);
    update();
  }

  void getSelectedPrayerRequest() {
    _selectedList =
        _prayerRequestList.where((item) => item.isChecked == true).toList();
  }
}
