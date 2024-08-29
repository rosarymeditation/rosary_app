import 'package:get/get.dart';
import 'package:rosary/data/repository/distress_repo.dart';
import 'package:rosary/model/distress_model.dart';
import 'langauge_controller.dart';

class DistressController extends GetxController {
  final DistressRepo distressRepo;
  DistressController({required this.distressRepo});

  var _local = Get.find<LocalizationController>();
  List<DistressModel> get distressList => _distressList.length > 0
      ? _distressList
      : distressRepo.distressCacheList();
  List<DistressModel> _distressList = [];

  // List<OnlinePrayerModel> get cachedCatholicPrayerList =>
  //     prayerRepo.catholicCacheList();
  // List<OnlinePrayerModel> get cachedOtherPrayerList =>
  //     prayerRepo.othersCacheList();

  DistressModel get distress => _distress;
  late DistressModel _distress;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isMoreLoaded = false;
  bool get isMoreLoaded => _isMoreLoaded;

  int _limit = 40;
  int get limit => _limit;

  int _page = 1;
  int get page => _page;

  void setDistress(DistressModel distress) {
    _distress = distress;
    update();
  }

  Future<void> getDistressList() async {
    _isLoaded = false;
    update();
    _page = 1;
    try {
      Response response =
          await distressRepo.getAll(_page, _limit, _local.selectedIndex);
      print(response.body);
      if (response.statusCode == 200) {
        _distressList = [];
        print(response.body);

        _distressList.addAll(Distress.fromJson(response.body).distresses);
        distressRepo.saveDistressAsString(_distressList);
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
          await distressRepo.getAll(newPage, _limit, _local.selectedIndex);

      if (response.statusCode == 200) {
        _distressList.addAll(Distress.fromJson(response.body).distresses);
        if (_distressList.isNotEmpty) {
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
