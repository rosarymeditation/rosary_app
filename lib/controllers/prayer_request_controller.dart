import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:rosary/data/repository/prayer_request_repo.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:rosary/model/public_prayer_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/response_model.dart';
import '../utils/constants.dart';

class PrayerRequestController extends GetxController implements GetxService {
  final PrayerRequestRepo prayerRequestRepo;
  PrayerRequestController({required this.prayerRequestRepo});
  bool _isLoaded = true;
  bool get isLoaded => _isLoaded;

  bool _isMoreLoaded = false;
  bool get isMoreLoaded => _isMoreLoaded;

  @override
  void onInit() {
    super.onInit();
    _prayerRequestList = prayerRequestRepo.prayerRequestCacheList();
  }

  int _limit = 20;
  int get limit => _limit;

  int _page = 1;
  int get page => _page;

  late PrayerRequestModel _editContent;
  PrayerRequestModel get editContent => _editContent;
  List<PrayerRequestModel> _prayerRequestList = [];
  List<PrayerRequestModel> get prayerRequestList =>
      prayerRequestRepo.prayerRequestCacheList().toList();

  List<PrayerRequestModel> _selectedList = [];
  List<PrayerRequestModel> get selectedtList => _selectedList;

  List<PublicPrayerRequestModel> _publicRequestList = [];
  List<PublicPrayerRequestModel> get publicRequestList => _publicRequestList;

  void add(String content) {
    var random = Random();

    int id = random.nextInt(100000);

    var date = DateTime.now();
    _prayerRequestList.insert(
      0,
      PrayerRequestModel(id: id, content: content, isChecked: true),
    );

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
    print(id);
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

  Future<ResponseModel> submitPublicRequest(String content,
      [String? name = "Anonymous"]) async {
    _isLoaded = false;
    update();
    print(name);
    print("--4-4--4-4-4--4-4-4--440");
    Response response =
        await prayerRequestRepo.submitRequest(content, name ?? "Anonymous");
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "OK");
    } else {
      responseModel = ResponseModel(false, "Your comment could not be saved");
    }
    _isLoaded = true;
    update();
    return responseModel;
  }

  Future<void> getPrayerList() async {
    _page = 1;
    _limit = 20;
    try {
      _isLoaded = false;
      update();
      Response response = await prayerRequestRepo.getPrayerRequest(page, limit);

      if (response.statusCode == 200) {
        _publicRequestList = [];
        _publicRequestList
            .addAll(PublicPrayerRequest.fromJson(response.body).prayers);
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoaded = true;
      update();
    }
  }

  Future<void> loadMore() async {
    var newPage = _page + 1;
    _isMoreLoaded = false;
    update();

    try {
      Response response =
          await prayerRequestRepo.getPrayerRequest(newPage, _limit);

      if (response.statusCode == 200) {
        _publicRequestList
            .addAll(PublicPrayerRequest.fromJson(response.body).prayers);
        if (_publicRequestList.length > 0) {
          _page = newPage;
        }
      }
    } catch (err) {
      print(err);
    } finally {
      _isMoreLoaded = true;
      update();
    }
  }
}
