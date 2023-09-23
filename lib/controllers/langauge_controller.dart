import 'dart:ui';

import 'package:get/get.dart';
import 'package:rosary/model/language_model.dart';
import 'package:rosary/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstant.languages[0].languageCode,
      AppConstant.languages[0].countryCode);
  Locale get locale => _locale;

  int _selectedindex = 0;
  int get selectedIndex => _selectedindex;

  List<LanguageModel> _langauges = [];

  List<LanguageModel> get languages => _langauges;

  void loadCurrentLanguage() async {
    //Only gets called during installation or reboot

    _locale = Locale(
        sharedPreferences.getString(AppConstant.LANGUAGE_CODE) ??
            AppConstant.languages[0].languageCode,
        sharedPreferences.getString(AppConstant.COUNTRY_CODE) ??
            AppConstant.languages[0].countryCode);

    for (int index = 0; index < AppConstant.languages.length; index++) {
      if (AppConstant.languages[index].languageCode == _locale.languageCode) {
        _selectedindex = index;
        break;
      }
    }
    _langauges = [];
    _langauges.addAll(AppConstant.languages);
    update();
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(locale);
    update();
  }

  void setSelectedIndex(int index) {
    _selectedindex = index;
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(AppConstant.LANGUAGE_CODE, locale.languageCode);
    sharedPreferences.setString(AppConstant.COUNTRY_CODE, locale.countryCode!);
  }
}
