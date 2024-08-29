import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return apiClient.postData(AppConstant.USER_INFO_URL, {});
  }

  Future<Response> getProfileData(String id) async {
    return apiClient.postData(AppConstant.GET_PROFILE_DATA, {"id": id});
  }
}
