import 'package:get/get.dart';
import 'package:rosary/data/repository/terms_repo.dart';
import 'package:rosary/model/terms_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/response_model.dart';

class TermsController extends GetxController implements GetxService {
  final TermsRepo termsRepo;
  final SharedPreferences sharedPreferences;
  TermsController({required this.termsRepo, required this.sharedPreferences}) {
    _termsModel = termsRepo.getTermsCache();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _hasTerms = false;
  bool get hasTerms => _hasTerms;

  late TermsModel _termsModel;
  TermsModel get termsModel => _termsModel;

  Future<ResponseModel> getTerm(int languageCode) async {
    print(languageCode);
    _isLoading = true;
    Response response = await termsRepo.getTerms(languageCode.toString());
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      _hasTerms = true;
      _termsModel = TermsModel.fromJson(response.body);
      termsRepo.cacheTerms(_termsModel);
      responseModel = ResponseModel(true, "OK");
    } else {
      print("Terms");
      _hasTerms = false;
      responseModel = ResponseModel(false, "Error");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
