import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rosary/data/repository/dailyReading_repo.dart';
import 'package:rosary/model/font_size_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/daily_reading_model.dart';
import '../model/response_model.dart';

class DailyReadingController extends GetxController implements GetxService {
  final DailyReadingRepo dailyReadingRepo;
  final SharedPreferences sharedPreferences;
  DailyReadingController(
      {required this.dailyReadingRepo, required this.sharedPreferences});
  //var _authController = Get.find<AuthController>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _hasReading = false;
  bool get hasVerse => _hasReading;

  FontSizeModel _fontSizeModel = FontSizeModel(
      headerOne: "4.0", headerThree: "5.0", headerTwo: "5.0", paragraph: "5.0");
  FontSizeModel get fontSizeModel => _fontSizeModel;

  DailyReadingModel _dailyReadingModel =
      DailyReadingModel(content: "", id: "", summary: "");
  DailyReadingModel get dailyReadingModel => _dailyReadingModel;

  Future<ResponseModel> getReading(languageCode) async {
    DateTime date = DateTime.now();
    var day = date.day;
    var month = DateFormat('MM').format(date);
    var year = date.year;
    var formattedDate = "$year-$month-$day";

    _isLoading = true;
    Response response = await dailyReadingRepo
        .getDailyReading({"date": "2024-08-31", "code": languageCode});
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      _hasReading = true;

      _dailyReadingModel = DailyReadingModel.fromJson(response.body);
      dailyReadingRepo.saveDailyReadingCache(_dailyReadingModel);
      // dailyReadingRepo.cacheDailyVerse(_dailyReadingModel);
      responseModel = ResponseModel(true, "OK");
    } else {
      _hasReading = false;
      responseModel = ResponseModel(false, "Error");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveFontSizeCache(FontSizeModel model) {
    dailyReadingRepo.saveFontSizeCache(model);
    _fontSizeModel = model;
    update();
  }

  void getFontSizeCache() {
    _fontSizeModel = dailyReadingRepo.getFontSizeCache();
    _dailyReadingModel = dailyReadingRepo.getDailyReadingCache();
  }
}
