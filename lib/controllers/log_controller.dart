import 'package:get/get.dart';

import '../data/repository/affirmation_repo.dart';
import '../data/repository/log_repo.dart';
import '../model/response_model.dart';
import 'auth_controller.dart';

class LogController extends GetxController implements GetxService {
  final LogRepo logRepo;
  LogController({required this.logRepo});

  Future<ResponseModel> logPsalm() async {
    Response response = await logRepo.logPsalm();
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "OK");
    } else {
      responseModel = ResponseModel(false, "Error");
    }

    update();
    return responseModel;
  }

  Future<ResponseModel> logNovena() async {
    Response response = await logRepo.logNovena();
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "OK");
    } else {
      responseModel = ResponseModel(false, "Error");
    }

    update();
    return responseModel;
  }

  Future<ResponseModel> logInspiration() async {
    Response response = await logRepo.logInpiration();
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "OK");
    } else {
      responseModel = ResponseModel(false, "Error");
    }

    update();
    return responseModel;
  }

  Future<ResponseModel> logRosary() async {
    Response response = await logRepo.logRosary();
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "OK");
    } else {
      responseModel = ResponseModel(false, "Error");
    }

    update();
    return responseModel;
  }

  Future<ResponseModel> logMystery() async {
    Response response = await logRepo.logMystery();
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "OK");
    } else {
      responseModel = ResponseModel(false, "Error");
    }

    update();
    return responseModel;
  }
}
