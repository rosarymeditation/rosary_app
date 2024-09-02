import 'package:get/get.dart';
import '../data/repository/psalm_repo.dart';
import '../model/psalm_model.dart';
import '../utils/constants.dart';
import 'langauge_controller.dart';

class PsalmController extends GetxController {
  final PsalmRepo psalmRepo;
  PsalmController({required this.psalmRepo});

  var _local = Get.find<LocalizationController>();

  List<PsalmModel> get psalmList => _psalmList;
  List<PsalmModel> _psalmList = [];

  PsalmModel get psalm => _psalm;
  late PsalmModel _psalm;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isMoreLoaded = false;
  bool get isMoreLoaded => _isMoreLoaded;

  int _limit = AppConstant.PAGE_LIMIT;
  int get limit => _limit;

  int _page = 1;
  int get page => _page;

  void setPsalm(PsalmModel psalm) {
    _psalm = psalm;
    update();
  }

  Future<void> getPsalmList() async {
    print(_local.selectedIndex);
    _isLoaded = false;
    update();
    _page = 1;
    try {
      Response response =
          await psalmRepo.getAll(_page, _limit, _local.selectedIndex);
      print(response.body);
      if (response.statusCode == 200) {
        _psalmList = [];
        // print(response.body);

        _psalmList.addAll(Psalm.fromJson(response.body).psalms);
        psalmRepo.savePsalmAsString(_psalmList);
      }
      _isLoaded = true;
      update();
    } catch (err) {
      _isLoaded = true;
      update();
      print("yesssjddkdkd");
      print(err);
    }
  }

  Future<void> loadMore() async {
    var newPage = _page + 1;
    _isMoreLoaded = false;

    try {
      Response response =
          await psalmRepo.getAll(newPage, _limit, _local.selectedIndex);

      if (response.statusCode == 200) {
        _psalmList.addAll(Psalm.fromJson(response.body).psalms);
        if (_psalmList.length > 0) {
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
