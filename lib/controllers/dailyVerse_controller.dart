import 'package:get/get.dart';
import 'package:rosary/model/daily_verse_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repository/dailyVerse_repo.dart';
import '../model/response_model.dart';
import 'auth_controller.dart';

class DailyVerseController extends GetxController implements GetxService {
  final DailyVerseRepo dailyVerseRepo;
  final SharedPreferences sharedPreferences;
  DailyVerseController(
      {required this.dailyVerseRepo, required this.sharedPreferences}) {
    _dailyVerseModel = dailyVerseRepo.getDailyVerseCache();
  }
  var _authController = Get.find<AuthController>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _hasVerse = false;
  bool get hasVerse => _hasVerse;

  DailyVerseModel _dailyVerseModel = DailyVerseModel(
      content:
          "Trust in the Lord with all your heart and lean not on your own understanding; in all your ways submit to him, and he will make your paths straight",
      verse: "Proverbs 3:5-6",
      id: "");
  DailyVerseModel get dailyVerseModel => _dailyVerseModel;

  Future<ResponseModel> getDailyVerse(languageCode) async {
    DateTime date = DateTime.now();
    var day = date.day;
    var month = date.month;
    var formattedDate = "$day/$month";

    _isLoading = true;
    Response response = await dailyVerseRepo
        .getDailyVerse({"date": formattedDate, "code": languageCode});
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      _hasVerse = true;
      _dailyVerseModel = DailyVerseModel.fromJson(response.body);
      dailyVerseRepo.cacheDailyVerse(_dailyVerseModel);
      responseModel = ResponseModel(true, "OK");
    } else {
      _hasVerse = false;
      responseModel = ResponseModel(false, "Error");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
